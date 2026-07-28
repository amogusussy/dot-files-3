local function merge(...)
  -- https://stackoverflow.com/questions/68839873/how-can-i-merge-two-tables-like-this-lua
  local result = {}
  for _, t in ipairs{...} do
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

vim.g.mapleader = "<Space>"

local M = merge(
  require("mappings.general"),
  require("mappings.tabs"),
  require("mappings.nvim-tree"),
  --require("mappings.telescope"),
{})



vim.keymap.set("n", "<tab>", function()
  vim.print("hello")
  vim.cmd("BufferLineCyclePrev")
end, { desc = "Overriding Prev buffer" })

return M
