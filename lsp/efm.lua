local prettierd = {
  formatCommand = "prettierd '${INPUT}' ${--range-start=charStart} ${--range-end=charEnd}",
  formatCanRange = true,
  formatStdin = true,
  rootMarkers = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.js",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.mjs",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "package.json",
  },
}

local languages = {
  json = { prettierd },
  javascript = { prettierd },
  typescript = { prettierd },
  javascriptreact = { prettierd },
  typescriptreact = { prettierd },
  svelte = { prettierd },
  markdown = { prettierd },
  css = { prettierd },
  html = { prettierd },
  yaml = { prettierd },
}

return {
  filetypes = vim.tbl_keys(languages),
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  settings = {
    rootMarkers = { ".git/", ".jj/" },
    languages = languages,
  },
}
