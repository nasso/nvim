--- @type string | string[]
local features = "all"

if vim.env.LSP_RUST_ANALYZER_FEATURES then
  features = vim.split(vim.env.LSP_RUST_ANALYZER_FEATURES, ",")
elseif vim.env.LSP_RUST_FEATURES then
  features = vim.split(vim.env.LSP_RUST_FEATURES, ",")
end

return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      cargo = { features = features },
      check = {
        enable = true,
        command = "clippy",
      },
    },
  },
}
