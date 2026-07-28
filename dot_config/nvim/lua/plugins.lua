vim.pack.add({
  {
    src = "https://github.com/nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },
  { src = "https://github.com/nvim-tree/nvim-web-devicons", },
  { src = "https://github.com/saghen/blink.lib", },
  { src = "https://github.com/akinsho/toggleterm.nvim", },
  { src = "https://github.com/folke/tokyonight.nvim", },
  { src = "https://github.com/neovim/nvim-lspconfig", },
  { src = "https://github.com/lukas-reineke/indent-blankline.nvim", },
  { src = "https://github.com/folke/trouble.nvim", cmd = "Trouble", },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("v1"), },
  { src = "https://github.com/L3MON4D3/LuaSnip", },
  { src = "https://github.com/rafamadriz/friendly-snippets", },
  { src = "https://github.com/lewis6991/gitsigns.nvim", },
  { src = "https://github.com/nvim-telescope/telescope.nvim", },
  { src = "https://github.com/nvim-lua/plenary.nvim", },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", },
  { src = "https://github.com/akinsho/bufferline.nvim", },
  { src = "https://github.com/sphamba/smear-cursor.nvim", },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", },
  { src = "https://github.com/hedyhli/outline.nvim", },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local packages = {
  "toggleterm.nvim",
  "nvim-cmp",
}

for _, name in ipairs(packages) do
  vim.cmd("packadd " .. name)
end
