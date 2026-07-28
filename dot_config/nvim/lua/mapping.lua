local M = require("mappings.maps")

local function keymap(mode, key, value)
  -- https://old.reddit.com/r/neovim/comments/z8pf1f/different_ways_to_config_keymaps/
  -- print(mode, key, value)
  vim.keymap.set(mode, key, value, { noremap = true, silent = true })
end


for _, i in pairs(M) do
  for mode, maps in pairs(i) do
    for bind, oo in pairs(maps) do
      -- lua does indexes starting at 1
      keymap({mode}, bind, oo[1])
    end
  end
end

vim.keymap.set(
  "n", "<tab>",
  function()
    vim.cmd("BufferLineCycleNext")
  end, {}
)

vim.keymap.set(
  "n", "<S-tab>",
  function()
    vim.cmd("BufferLineCyclePrev")
  end, {}
)
