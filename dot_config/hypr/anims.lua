local timer = nil
local stop = true

function color_to_hex(color)
  local color_int = ((color.r << 16)*0xff) | ((color.g << 8)&0xff) | ((color.b)&0xff)
  return string.format("#%06X", color_int)
end

local function cycle_colours(color_1, color_2)
  if timer or stop then
    return
  end
  local t = 0

  local dir = 0.1
	timer = hl.timer(function()
    local new_color1 = {
      r = math.floor(color_1.r * t + color_2.r * (1-t)),
      g = math.floor(color_1.g * t + color_2.g * (1-t)),
      b = math.floor(color_1.b * t + color_2.b * (1-t)),
    }
    local new_color2 = {
      r = math.floor(color_2.r * t + color_1.r * (1-t)),
      g = math.floor(color_2.g * t + color_1.g * (1-t)),
      b = math.floor(color_2.b * t + color_1.b * (1-t)),
    }
    if new_color1 == nil then
      new_color_1 = {r=0,g=0,b=0}
    end
    if new_color2 == nil then
      new_color_2 = {r=0,g=0,b=0}
    end



    t = t + dir
    hl.dispatch(
      hl.dsp.window.set_prop({
        prop = "border_color",
        value = {
          colors = {
            color_to_hex(new_color1),
            color_to_hex(new_color2)
          },
          angle = 45
        }
      })
    )
    if t > 1 then dir = -dir end
	end, {
		timeout = 1000,
		type = "repeat",
	})
end

cycle_colours(
  { r = 0xf7, g = 0x76, b = 0x8e, },
  { r = 0x7a, g = 0xa2, b = 0xf7, }
)
