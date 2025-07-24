local cmd = {
  "clangd",
  "--clang-tidy",
  "--background-index",
  "--offset-encoding=utf-8",
  "--log=error",
}

if vim.env.LSP_CLANGD_QUERY_DRIVER then
  cmd[#cmd + 1] = "--query-driver=" .. vim.env.LSP_CLANGD_QUERY_DRIVER
end

return {
  cmd = cmd,
  root_markers = { ".clangd", "compile_commands.json" },
}
