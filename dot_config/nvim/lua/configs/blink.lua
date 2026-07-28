local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

local source_priority = {
  lsp = 4,
  path = 3,
  snippets = 2,
  buffer = 1
}

local fuzzysorts = {
  function(a, b)
    local a_priority = source_priority[a.source_id]
    local b_priority = source_priority[b.source_id]
    if a_priority ~= b_priority then return a_priority > b_priority end
  end,
  -- defaults
  'score',
  'sort_text'
}

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
      },
			completion = {
				documentation = { auto_show = false },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = fuzzysorts,
      },
      appearance = {
        highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        kind_icons = {
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      }
		})
	end,
})
