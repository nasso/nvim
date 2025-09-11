return {
  {
    "mason-org/mason.nvim",
    tag = "v2.0.1",
    pin = true,
    config = true,
    lazy = false,
    opts = {
      PATH = "append",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    tag = "v2.0.0",
    pin = true,
    config = false,
    lazy = true,
    opts = {},
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require "cmp"

      local win_cfg = cmp.config.window.bordered()
      win_cfg.col_offset = -1

      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
        },
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
                item.menu = ("[lsp]%s"):format(
                  entry.completion_item.labelDetails.detail
                )
              else
                item.menu = "[lsp]"
              end
            elseif src == "nvim_lua" then
              item.menu = "[nvim]"
            else
              item.menu = ("[%s]"):format(src)
            end

            return item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-f>"] = function() vim.snippet.jump(1) end,
          ["<C-b>"] = function() vim.snippet.jump(-1) end,
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
      }
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    tag = "v2.3.0",
    pin = true,
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason-lspconfig.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local lspconfig = require "lspconfig"
      local cmp_nvim_lsp = require "cmp_nvim_lsp"

      local lspconfig_defaults = lspconfig.util.default_config

      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        cmp_nvim_lsp.default_capabilities()
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local id = vim.tbl_get(event, "data", "client_id")
          local client = id and vim.lsp.get_client_by_id(id)
          if client == nil then
            return
          end

          local opts = { buffer = event.buf, remap = false }

          local telescope = require "telescope.builtin"

          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "rounded" })
          end, opts)
          vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
          vim.keymap.set("n", "go", telescope.lsp_type_definitions, opts)
          vim.keymap.set("n", "gr", telescope.lsp_references, opts)
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "gl", function()
            vim.diagnostic.open_float({
              border = "rounded",
            })
          end, opts)
          vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set({ "n", "x" }, "=", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

          if client:supports_method("textDocument/formatting") then
            local group = "lsp_autoformat"
            vim.api.nvim_create_augroup(group, { clear = false })
            vim.api.nvim_clear_autocmds({ group = group, buffer = event.buf })
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              group = group,
              desc = "LSP format on save",
              callback = function()
                -- disable async when formatting on save
                vim.lsp.buf.format({
                  async = false,
                  timeout_ms = 10000,
                  filter = function(c)
                    -- ban some LSPs that suck at formatting (sorry)
                    return not vim.tbl_contains({ "ts_ls" }, c.name)
                  end,
                })
              end,
            })
          end
        end,
      })

      vim.diagnostic.config({
        signs = {
          numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          },
        },
      })

      local mason = require "mason"
      local mason_lspconfig = require "mason-lspconfig"

      mason.setup {}
      mason_lspconfig.setup {
        ensure_installed = {
          "lua_ls",
          "efm",
        },
      }

      vim.lsp.config("*", {
        root_markers = { ".git", ".jj" },
      })

      for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
        local default_diagnostic_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, result, context, config)
          if err ~= nil and err.code == -32802 then
            return
          end
          return default_diagnostic_handler(err, result, context, config)
        end
      end
    end,
  },
}
