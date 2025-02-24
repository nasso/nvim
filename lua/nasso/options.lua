-- i hate the right click menu
vim.opt.mousemodel = "extend"

-- colours!
vim.opt.termguicolors = true

-- keep just one status line for all window splits
vim.opt.laststatus = 3

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

-- case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- e.g. indent new lines after a '{' or before a '}'
vim.opt.smartindent = true

-- wrap lines because tailwind
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "└► "

-- always keep some lines before and after the cursor when scrolling
vim.opt.scrolloff = 10

-- don't create annoying swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- sign column
vim.opt.signcolumn = "yes"

-- include '@' in the list of characters that can appear in file names
vim.opt.isfname:append("@-@")

-- update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- menuone: always show completion menu even when only one match is found
-- noselect: don't select an item from the completion menu automatically
vim.opt.completeopt = "menuone,noselect"

-- show whitespace characters other than regular spaces
vim.wo.list = true

-- make `.h` files always be C by default (this line by c++ hate gang)
vim.g.c_syntax_for_h = true

-- highlight selection on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function() vim.highlight.on_yank { higroup = 'IncSearch' } end,
})

-- highlight current line on the active buffer (thanks tj)
vim.opt.cursorline = true
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- custom title
vim.go.title = true
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  group = vim.api.nvim_create_augroup("title-cwd", { clear = true }),
  callback = function()
    local name = vim.fs.basename(vim.fn.getcwd())
    vim.go.titlestring = "nvim:" .. name .. "/"
  end,
})
