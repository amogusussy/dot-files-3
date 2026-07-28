-- https://github.com/radleylewis/nvim-lite/blob/master/init.lua

-- Git branch function with caching and Nerd Font icon
local cached_branch = ""
local last_check = 0
local function git_branch()
	local now = vim.loop.now()
	if now - last_check > 5000 then -- Check every 5 seconds
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
		last_check = now
	end
	if cached_branch ~= "" then
		return " \u{e725} " .. cached_branch .. " "
	end
	return ""
end

-- File type with Nerd Font icon
local function file_type()
	local ft = vim.bo.filetype
  local icons = require("other.icons")
	if ft == "" then
		return " \u{f15b} "
	end

	return ((icons[ft] or " \u{f15b} "))
	--return ((icons[ft] or " \u{f15b} ") .. ft)
end

-- Mode indicators with Nerd Font icons
local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = " NORMAL",
    i = " I",
    v = " V",
		V = " V-L",
    ["\22"] = " V-B",
    c = " CMD",
		s = " S",
    S = " S-L",
    ["\19"] = " S-B",
		R = " R",
    r = " R",
    ["!"] = " SH",
    t = " T",
	}
	return modes[mode] or (" " .. mode)
end
local function lsp_error()
  local error = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) or {}
  local num = #error
  if (num == 0) then
    return ""
  end
  return "  " .. num .. " "
end

local function lsp_warn()
  local warn = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) or {}
  local num = #warn
  if (num == 0) then
    return ""
  end
  return "  " .. num .. " "
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_type = file_type
_G.lsp_error = lsp_error
_G.lsp_warn = lsp_warn
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

local colorscheme = {
  -- tokyonight
  ["fg"] = "#c0caf5",
  --["bg"] = "#1a1b26",
  ["bg"] = "#161620",
  ["bold-bg"] = "#161620",
  ["grey"] = "#3b4261",
  ["light_grey"] = "#565f89",

  ["purple"] = "#bb9af7",
	["red"] = "#f7768e",
	["orange"] = "#ff9e64",
	["yellow"] = "#e0af68",
	["green"] = "#9ece6a",
	["blue"] = "#7aa2f7",
	["turquoise"] = "#2ac3de",
	["light_blue"] = "#73daca"
}


vim.api.nvim_set_hl(0, "StatusMode", { fg = colorscheme.bg, bg = colorscheme.blue, bold = true })
vim.api.nvim_set_hl(0, "StatusGit", { fg = colorscheme.blue, bg = colorscheme.grey, bold = true })

vim.api.nvim_set_hl(0, "LspError", { fg = colorscheme.red, bg = colorscheme.bg, bold = true })
vim.api.nvim_set_hl(0, "LspWarn", { fg = colorscheme.yellow, bg = colorscheme.bg, bold = true })
vim.api.nvim_set_hl(0, "Lang", { fg = colorscheme.bg, bg = colorscheme.green })
vim.api.nvim_set_hl(0, "StatusFile", { fg = colorscheme.light_grey, bg = colorscheme.bg })
vim.api.nvim_set_hl(0, "StatusSize", { fg = colorscheme.blue, bg = colorscheme.bg })
vim.api.nvim_set_hl(0, "StatusLineRight", { fg = colorscheme.blue, bg = colorscheme.bg })

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
  -- spacer
  -- line & col
  -- encoding
  -- lang
  -- lsp

	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
        vim.opt_local.statusline = table.concat({
          "%#StatusMode#",
          " %{v:lua.mode_icon()} ",

          "%#StatusGit#",
          "%{v:lua.git_branch()}",
          "", -- nf-pl-left_hard_divider


          "%#LspError#",
          " %{v:lua.lsp_error()}",
          "%#LspWarn#",
          "%{v:lua.lsp_warn()}",
          --"%#Lang#",
          --" ", -- nf-pl-left_hard_divider

          "%#StatusFile#",
          " %{v:lua.file_type()}",
          "%f %h%m%r", -- filename

          "%#StatusLineRight# ",
          "%=", -- Right-align everything after this
          " %l:%c ", -- nf-fa-clock_o for line/col
        })
		end,
	})
	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = "%f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
		end,
	})
end
setup_dynamic_statusline()
