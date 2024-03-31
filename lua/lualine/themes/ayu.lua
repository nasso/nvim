local colors = require('ayu.colors')

return {
  visual = {
    a = { fg = colors.bg, bg = colors.accent, gui = 'bold' },
    b = { fg = colors.accent, bg = colors.panel_border },
    c = { fg = colors.fg },
  },
  replace = {
    a = { fg = colors.bg, bg = colors.markup, gui = 'bold' },
    b = { fg = colors.markup, bg = colors.panel_border },
    c = { fg = colors.fg },
  },
  inactive = {
    a = { fg = colors.fg, bg = colors.panel_border },
    b = { fg = colors.fg, bg = colors.panel_border },
    c = { fg = colors.fg },
  },
  normal = {
    a = { fg = colors.bg, bg = colors.entity, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.panel_border },
    c = { fg = colors.fg },
  },
  insert = {
    a = { fg = colors.bg, bg = colors.string, gui = 'bold' },
    b = { fg = colors.string, bg = colors.panel_border },
    c = { fg = colors.fg },
  },
}
