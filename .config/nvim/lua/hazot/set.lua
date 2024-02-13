vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = ""

vim.opt.autoread = true

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false

vim.opt.cursorline = true

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = { '*.md', '*.tex' },
    group = group,
    command = 'setlocal wrap'
})

-- Enable incrementing hex numbers and letters
vim.api.nvim_set_option("nrformats", "hex,alpha")
