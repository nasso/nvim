local function auto_cd(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if directory then
    -- change to the directory
    vim.cmd.cd(data.file)
  end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = auto_cd })

return {
  {
    -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files({
          hidden = true,
          file_ignore_patterns = { ".git", '.jj' },
          find_command = { "rg", "--files", "--no-require-git" },
        })
      end, {})
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>o', builtin.buffers, {})
    end
  },

  {
    -- explorer
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
        }
      }

      vim.keymap.set("n", "-", "<CMD>Oil<CR>");
    end,
  },

  {
    -- quickly move between "pinned" files
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader><leader>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<leader>p", function() harpoon:list():append() end)
      vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end)
    end,
  },
}
