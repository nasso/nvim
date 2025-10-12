--- @type string | string[]
local features = "all"

if vim.env.LSP_RUST_FEATURES then
  features = vim.split(vim.env.LSP_RUST_FEATURES, ",")
end

--- @type string | nil
local target = nil

if vim.env.LSP_RUST_TARGET then
  target = vim.env.LSP_RUST_TARGET
end


return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      cargo = {
        features = features,
        target = target,
      },
      check = {
        enable = true,
        command = "clippy",
        features = features,
      },
    },
  },
}
