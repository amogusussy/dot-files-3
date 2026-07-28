local bufferline = require("bufferline")

bufferline.setup {
  options = {
    themable = true,
    indicator = {
        style = 'icon',
    },
    diagnostics = "nvim_lsp",
    color_icons = true,
    show_close_icon = false,
  },
  highlights = {
    fill = {
      bg = "#161620",  -- the background behind all tabs
    },
  },
}
