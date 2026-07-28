vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = "check",
      },
      diagnostics = {
        enable = false,
      }
    }
  }
})
-- vim.lsp.enable({"rust_analyzer"})
