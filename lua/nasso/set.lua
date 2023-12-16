-- colours!
vim.opt.termguicolors = true

-- line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- vertical rulers
vim.opt.colorcolumn = "81,101,121"

-- use 2 spaces to indent by default
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- highlight search results
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- e.g. indent new lines after a '{' or before a '}'
vim.opt.smartindent = true

-- wrap lines because tailwind
vim.opt.wrap = true
vim.opt.linebreak = true

-- don't create annoying swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- always keep 8 lines above and below the cursor
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- menuone: always show completion menu even when only one match is found
-- noselect: don't select an item from the completion menu automatically
vim.opt.completeopt = "menuone,noselect"

-- show whitespace characters other than regular spaces
vim.wo.list = true
