vim.filetype.add({
  filename = {
    [".zshrc"] = "zsh",
    [".zshenv"] = "zsh",
    [".zprofile"] = "zsh",
  },
})

vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh", "zsh" },
})
vim.lsp.enable({"bashls"})
