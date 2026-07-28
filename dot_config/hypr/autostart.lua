local G = require("globals")

local commands = {
  "hyprpaper",
  G.home_dir .. "/.config/fabric/bar.sh"
}

hl.on("hyprland.start", function ()
  for _, cmd in ipairs(commands) do
    hl.exec_cmd(cmd)
  end

  hl.dispatch(hl.dsp.workspace.swap_monitors( {
    monitor1 = "DP-1",
    monitor2 = "HDMI-A-2",
  }))
end)
