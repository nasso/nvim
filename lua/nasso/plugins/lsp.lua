local format_opts = {
  format_opts = { async = false, timeout_ms = 10000 },
  servers = {
    ['rust_analyzer'] = { 'rust' },
    ['lua_ls'] = { 'lua' },
    ['hls'] = { 'haskell' },
    ['efm'] = {
      'json',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'svelte',
      'markdown',
      'css',
      'html',
      'yaml',
    },
  }
}

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      -- here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- and you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      local win_cfg = cmp.config.window.bordered()
      win_cfg.col_offset = -1

      cmp.setup {
        window = {
          completion = win_cfg,
          documentation = win_cfg,
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, item)
            local src = entry.source.name

            if src == "nvim_lsp" then
              if
                  entry.completion_item.labelDetails
                  and entry.completion_item.labelDetails.detail
              then
                item.menu = string.format(
                  "[lsp]%s",
                  entry.completion_item.labelDetails.detail
                )
              else
                item.menu = "[lsp]"
              end
            elseif src == "nvim_lua" then
              item.menu = "[nvim]"
            else
              item.menu = string.format("[%s]", src)
            end

            return item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        }
      }
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      -- this is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps { buffer = bufnr }

        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end)

      lsp_zero.format_mapping('=', format_opts)
      lsp_zero.format_on_save(format_opts)

      require('mason-lspconfig').setup {
        ensure_installed = { "efm" },
        handlers = {
          lsp_zero.default_setup,
          rust_analyzer = function()
            require('lspconfig').rust_analyzer.setup {
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = true,
                  check = {
                    enable = true,
                    command = "clippy",
                    features = "all",
                  },
                }
              }
            }
          end,
          clangd = function()
            local cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--log=error",
            }
            if vim.env.LSP_CLANGD_QUERY_DRIVER then
              cmd[#cmd + 1] = "--query-driver=" .. vim.env.LSP_CLANGD_QUERY_DRIVER
            end
            require('lspconfig').clangd.setup { cmd = cmd }
          end,
          lua_ls = function()
            -- (optional) configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()

            require('lspconfig').lua_ls.setup(lua_opts)
          end,
          ts_ls = function()
            require('lspconfig').ts_ls.setup {
              on_init = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentFormattingRangeProvider = false
              end,
            }
          end,
          svelte = function()
            require('lspconfig').svelte.setup {
              on_attach = function(client)
                vim.api.nvim_create_autocmd("BufWritePost", {
                  group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
                  pattern = { "*.js", "*.ts" },
                  callback = function(ctx)
                    client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                  end,
                })
              end,
            }
          end,
          efm = function()
            local prettierd = {
              formatCommand = "prettierd '${INPUT}' ${--range-start=charStart} ${--range-end=charEnd}",
              formatCanRange = true,
              formatStdin = true,
              rootMarkers = {
                '.prettierrc',
                '.prettierrc.json',
                '.prettierrc.js',
                '.prettierrc.yml',
                '.prettierrc.yaml',
                '.prettierrc.json5',
                '.prettierrc.mjs',
                '.prettierrc.cjs',
                '.prettierrc.toml',
                'package.json',
              },
            }

            require('lspconfig').efm.setup {
              init_options = {
                documentFormatting = true,
                documentRangeFormatting = true,
              },
              settings = {
                rootMarkers = { '.git/', '.jj/' },
                languages = {
                  javascript = { prettierd },
                  javascriptreact = { prettierd },
                  typescript = { prettierd },
                  typescriptreact = { prettierd },
                  svelte = { prettierd },
                  markdown = { prettierd },
                }
              }
            }
          end,
        }
      }

      for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
          if err ~= nil and err.code == -32802 then
            return
          end
          return default_diagnostic_handler(err, result, context, config)
        end
      end
    end
  }
}
