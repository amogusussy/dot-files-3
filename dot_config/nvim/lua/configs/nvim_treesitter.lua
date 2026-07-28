local ts = require('nvim-treesitter')

ts.setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}
ts.install({
  "bash",
  "c",
  "haskell",
  "javascript",
  "lua",
  "python",
  "rust",
  "typst",
}):wait(300000)
