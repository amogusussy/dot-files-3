vim.opt.number = true
vim.opt.relativenumber = true

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.cmd("colorscheme tokyonight-night")


vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 1 -- indent width
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.api.nvim_create_user_command('H', function(opts)
  vim.cmd('vertical botright help ' .. opts.args)
end, { nargs = '*', complete = 'help' })


local cmp = require("cmp")
cmp.setup(require("configs.cmpconfig"))

require("configs.blink")
require("configs.bufferline")
require("configs.gitsigns")
require("configs.icons")
require("configs.luasnip")
require("configs.outline")
require("configs.render_markdown")
require("configs.telescope")
require("configs.nvim_treesitter")
require("configs.cmpconfig")
