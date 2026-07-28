local monitors = {
  "HDMI-A-2",
  "DP-1"
}
local shift = 0

for _, monitor in ipairs(monitors) do
  hl.monitor({
      output   = monitor,
      mode     = "preferred",
      position = shift .. "x0",
      scale = 1
  })
  shift = shift + 1920
end
