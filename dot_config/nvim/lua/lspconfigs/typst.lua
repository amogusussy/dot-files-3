vim.lsp.config("tinymist", {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  flags = { debounce_text_changes = 150 },
  settings = {
    rust = {
      semanticTokens = false,
    },
	}
})
vim.lsp.enable({"tinymist"})
