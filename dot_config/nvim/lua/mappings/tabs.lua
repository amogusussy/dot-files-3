local M = {}

local function nextTab()
  -- if at end, go to beginning
  print("hello")
  vim.cmd("BufferLineCycleNext")
end

local function prevTab()
  -- if at beginning, go to end
  vim.cmd("BufferLineCyclePrev")
end


local function tabClose()
  vim.cmd("tabc")
end

M.tabs = {
  n = {
    ["<tab>"] = {
      --"BufferLineCycleNext",
      nextTab,
      "Goto next buffer",
    },
    ["<S-tab>"] = {
      --"BufferLineCyclePrev",
      prevTab,
      "Goto next buffer",
    },
    ["<leader>x"] = {
      tabClose,
      "Close tab"
    },
  }
}


return M
