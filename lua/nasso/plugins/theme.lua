return {
  {
    'Shatur/neovim-ayu',
    -- disable lazy loading because this is the main theme
    lazy = false,
    priority = 1000,
    config = function()
      require('ayu').setup { mirage = false }

      vim.cmd.colorscheme "ayu"
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'ayu',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- use a | as the vertical ruler
  {
    "lukas-reineke/virt-column.nvim",
    opts = {},
  }
}
