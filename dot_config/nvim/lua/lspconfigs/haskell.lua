vim.lsp.config("haskell-language-server", {
  cmd = { "haskell-language-server" },
  filetypes = { "haskell", "hs" },
})
vim.lsp.enable({"haskell-language-server"})
