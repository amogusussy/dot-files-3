local M = {}

local builtin = require('telescope.builtin')

M.tabs = {
  n = {
    ["ff"] = {
      builtin.find_files,
      { desc = 'Telescope find files'},
    },
    ['fg'] = {
      builtin.live_grep,
      { desc = 'Telescope live grep' }
    },
    ['<leader>fb'] = {
      builtin.buffers,
      { desc = 'Telescope buffers' }
    },
    ['<leader>fh'] = {
      builtin.help_tags,
      { desc = 'Telescope help tags' }
    },
  }
}
return M
