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
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '', right = '' } }
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'filetype' },
        lualine_z = {
          { 'location', separator = { left = '', right = '' } },
        },
      },
      inactive_sections = {
        lualine_a = {
          { 'filename', separator = { left = '', right = '' } },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          { 'location', separator = { left = '', right = '' } },
        },
      },
    },
  },
  -- use a | as the vertical ruler
  {
    "lukas-reineke/virt-column.nvim",
    opts = {},
  }
}
