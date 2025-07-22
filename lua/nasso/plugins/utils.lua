return {
  {
    -- toggle comments with gc
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
    -- some plugins by tpope depend on this for `.` support
    'tpope/vim-repeat',
  },
  {
    -- plugin to "work with variations of a word"
    -- - smart abbreviations
    -- - case preserving substitutions with :S[ubvert]
    -- - case conversions
    'tpope/vim-abolish',
  },
  {
    -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
    'tpope/vim-surround',
  },
  {
    -- a bunch of commands like [x, ]x, [f, ]f, [y, ]y etc...
    'tpope/vim-unimpaired',
  },
  {
    --    ┌────────────────────────────────────────────────┐
    -- ┌──│this cool ass plugin lets me do this shit easily│───┐
    -- │  └────────────────────────────────────────────────┘   │
    -- │      │     │       │    │        │        │     │     │
    -- ▼      ▼     ▼       ▼    ▼        ▼        ▼     ▼     ▼
    'jbyuki/venn.nvim',
    keys = "<leader>v",
    config = function()
      local function toggle()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)

        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd [[setlocal ve=all]]
          -- draw a line on HJKL keystokes
          vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { noremap = true, buffer = true })
          vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { noremap = true, buffer = true })
          vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", { noremap = true, buffer = true })
          vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { noremap = true, buffer = true })
          -- draw a box by pressing "f" with visual selection
          vim.keymap.set("v", "f", ":VBox<CR>", { noremap = true, buffer = true })
        else
          vim.cmd [[setlocal ve=]]
          vim.keymap.del("n", "J", { buffer = true })
          vim.keymap.del("n", "K", { buffer = true })
          vim.keymap.del("n", "L", { buffer = true })
          vim.keymap.del("n", "H", { buffer = true })
          vim.keymap.del("v", "f", { buffer = true })
          vim.b.venn_enabled = nil
        end
      end

      vim.keymap.set("n", "<leader>v", toggle, { noremap = true })
    end
  },
}
