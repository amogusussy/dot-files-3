local HOME_DIR = os.getenv("HOME")
local THEME_NAME = "tokyonight"

return {
  home_dir = HOME_DIR,
  terminal = "alacritty --config-file=" .. HOME_DIR .. "/.config/alacritty/" .. THEME_NAME .. ".toml",
  fileManager = "dolphin",
  menu        = "rofi -show drun",
}
