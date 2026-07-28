local term_buf = nil
local term_win = nil

local function toggle_floating_term()
  -- close terminal if its already open. i.e. toggle
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  local is_new = false
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[term_buf].bufhidden = "hide"
    is_new = true
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  term_win = vim.api.nvim_open_win(term_buf, true, {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  })

  if is_new then
    vim.fn.termopen(vim.o.shell)
  end

  vim.cmd("startinsert")
end

-- Normal mode toggle
vim.keymap.set("n", "<M-i>", toggle_floating_term, { noremap = true, silent = true })

-- Terminal mode toggle
vim.keymap.set("t", "<M-i>", function()
  vim.cmd("stopinsert")
  toggle_floating_term()
end, { noremap = true, silent = true })

-- Optional escape
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
