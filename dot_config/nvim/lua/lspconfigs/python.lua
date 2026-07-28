vim.lsp.config("python-lsp-server", {
  cmd = { "pylsp", },
  filetypes = { "python" },
  root_dir = vim.fs.root(0, { ".git/", "pyproject.toml" }),
})

vim.lsp.config("ruff", {
  cmd = {"ruff", "server"},
  filetypes = { "python" },
  root_dir = vim.fs.root(0, { ".git/", "pyproject.toml" }),
})

vim.lsp.enable({"ty", "ruff"})
