local langfiles = {
  "harper",
  "js",
  "lua",
  "python",
  "rust",
  "typst",
  "c",
  "haskell",
  "bash",
  "css",
}

for _, lang in ipairs(langfiles) do
  -- print("Doing " .. lang)
  require("lspconfigs." .. lang)
end
