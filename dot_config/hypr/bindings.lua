local G = require("globals")

-- Set programs that you use
local terminal = G.terminal
local terminal_start = G.terminal .. " -e %s"
local fileManager = G.fileManager
local menu = G.menu
local mod = "SUPER"

for i = 1, 10 do
    local key = i % 10
    hl.bind(
      mod .. " + " .. key,
      hl.dsp.focus({
        workspace = i,
        on_current_monitor = true,
      })
    )
    hl.bind(
      mod .. " + SHIFT + " .. key,
      hl.dsp.window.move({
        workspace = i,
        follow = false,
      }
    ))
end

hl.bind(mod .. " + Return",        hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + Q",             hl.dsp.window.close())
hl.bind(mod .. " + E",             hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + Space",         hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + A",             hl.dsp.exec_cmd(string.format(terminal_start, "pulsemixer")))
hl.bind(mod .. " + F",             hl.dsp.window.fullscreen())

-- Move focus with mod + {h,j,k,l}
hl.bind(mod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))

hl.bind(mod .. " + K", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mod .. " + J", hl.dsp.window.cycle_next({ next = true }))

-- dragging to resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

---------------
---- MEDIA ----
---------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- see ~/.local/bin/audio
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("audio play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("audio next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("audio prev"), { locked = true })


hl.bind(mod .. " + F12", hl.dsp.exec_cmd('grim -g "$(slurp)"'), { locked = true })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        repeat_delay = 200,
        repeat_rate = 50,
        kb_layout  = "us",
        follow_mouse = 1,
        sensitivity = 0.5,
        touchpad = { natural_scroll = false, },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
