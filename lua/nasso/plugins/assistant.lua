return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          accept = "<A-l>",
          next = "<A-]>",
          prev = "<A-[>",
        }
      }
    end
  }
}
