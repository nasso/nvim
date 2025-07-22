-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- space is the leader, so we disable its default behaviour
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- make j and k behave expectedly on wrapped lines
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- jk/kj to exit insert mode
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
vim.keymap.set('i', 'jK', '<Esc>', { silent = true })
vim.keymap.set('i', 'Jk', '<Esc>', { silent = true })
vim.keymap.set('i', 'JK', '<Esc>', { silent = true })
vim.keymap.set('i', 'kj', '<Esc>', { silent = true })
vim.keymap.set('i', 'Kj', '<Esc>', { silent = true })
vim.keymap.set('i', 'kJ', '<Esc>', { silent = true })
vim.keymap.set('i', 'KJ', '<Esc>', { silent = true })

-- <C-[hjkl]> to move around windows
vim.keymap.set({ 'n', 'i', 'v' }, '<C-h>', '<C-w><C-h>', { silent = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-j>', '<C-w><C-j>', { silent = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-k>', '<C-w><C-k>', { silent = true })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-l>', '<C-w><C-l>', { silent = true })

-- make it so that :W == :w and :Q == :q
vim.cmd "cnoreabbrev W w"
vim.cmd "cnoreabbrev Q q"

-- move lines around with J and K when selected
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z", { silent = true })

-- <C-c> to <Esc> so that it still applies multi-cursor edits
vim.keymap.set("i", "<C-c>", "<Esc>", { silent = true })

-- <leader>t to toggle dark/light mode
vim.keymap.set(
  'n',
  '<leader>t',
  function()
    if vim.o.background == 'dark' then
      vim.o.background = 'light'
    else
      vim.o.background = 'dark'
    end
  end,
  { desc = 'Toggle dark mode' }
)
