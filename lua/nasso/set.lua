vim.opt.nu = true
vim.opt.rnu = true

-- use 2 spaces to indent by default
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- e.g. indent new lines after a '{' or before a '}'
vim.opt.smartindent = true

-- show whitespace
vim.wo.list = true
vim.opt.listchars:append "space:·"

-- wrap lines because tailwind
vim.opt.wrap = true
vim.opt.linebreak = true

-- don't create annoying swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

-- always keep 8 lines above and below the cursor
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
