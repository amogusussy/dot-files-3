local M = {}
local api = require("nvim-tree.api")

require("nvim-tree").setup({
  filters = { dotfiles = false },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  on_attach = function(bufnr)
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
    end
    api.config.mappings.default_on_attach(bufnr)

    -- fix issues with tabbing when tree is selected
    -- vim.keymap.set("n", "<CR>", api.node.open.tab, opts("Open: New Tab"))
    vim.keymap.set("n", "<Tab>", "<cmd>tabnext<CR>", opts("Next Tab"))
    vim.keymap.set("n", "<S-Tab>", "<cmd>tabprevious<CR>", opts("Prev Tab"))
  end,
})

M.tabs = {
  n = {
    ["<C-n>"] = {
      api.tree.toggle,
      "Toggle nvim-tree"
    },
    ["<C-t>"] = {
      api.tree.change_root_to_parent,
    },
    ["?"] = {
      api.tree.toggle_help,
    },
    ["<Tab>"] = {
      "<cmd>tabnext<CR>",
    },
    ["<S-Tab>"] = {
      "<cmd>tabprevious<CR>",
    }
  }
}

return M
