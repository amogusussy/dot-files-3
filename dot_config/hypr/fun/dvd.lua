local states = {}
local timer = nil
local DVD_W, DVD_H = 300, 300

-- dvd
local function spin(s)
	s.x = s.x + s.vx
	s.y = s.y + s.vy

	if s.x <= s.mx or s.x + s.w >= s.mx + s.mw then
		s.vx = -s.vx
		s.x = math.max(s.mx, math.min(s.x, s.mx + s.mw - s.w))
	end
	if s.y <= s.my or s.y + s.h >= s.my + s.mh then
		s.vy = -s.vy
		s.y = math.max(s.my, math.min(s.y, s.my + s.mh - s.h))
	end

  if s.y < 1080/2 then
    s.vy = s.vy + 5
  else
    s.vy = s.vy - 5
  end

  if s.x < 1920/2 then
    s.vx = s.vx + 5
  else
    s.vx = s.vx - 5
  end


  newh = 500*math.sin(s.t)
  neww = 500*math.cos(s.t)
  s.t = s.t + 0.1

	--hl.dispatch(hl.dsp.window.move({
		--window = "address:" .. s.address,
		--x = math.floor(s.x),
		--y = math.floor(s.y),
	--}))

  hl.dispatch(hl.dsp.window.resize({
    x = neww/s.w,
    y = newh/s.h,
    relative = true,
		window = "address:" .. s.address,
  }))
  s.w =neww
  s.h = newh
end

local function add_window(w)
	local m = hl.get_monitor_at({
		x = w.at.x,
		y = w.at.y,
	}) or hl.get_active_monitor()
	if not m then
		return
	end
	local was_tiled = not w.floating
	if was_tiled then
		hl.dispatch(hl.dsp.window.float({
			window = "address:" .. w.address,
			action = "toggle",
		}))
	end
	hl.dispatch(hl.dsp.window.resize({
		window = "address:" .. w.address,
		x = DVD_W,
		y = DVD_H,
	}))

	local s = {
		address = w.address,
		was_tiled = was_tiled,
		x = m.x + math.random(0, m.width - DVD_W),
		y = m.y + math.random(0, m.height - DVD_H),
		w = DVD_W,
		h = DVD_H,
		vx = 5 * (math.random(2) == 1 and 1 or -1),
		vy = 5 * (math.random(2) == 1 and 1 or -1),
		mx = m.x,
		my = m.y,
		mw = m.width,
		mh = m.height,
    t = 0
	}
	states[#states + 1] = s

	hl.dispatch(hl.dsp.window.move({
		window = "address:" .. w.address,
		x = math.floor(s.x),
		y = math.floor(s.y),
	}))
end

hl.on("window.open", function(e)
	if not timer then
		return
	end
	local addr = e.address or e
	hl.timer(function()
		local ws = hl.get_active_workspace()
		for _, w in ipairs(hl.get_windows() or {}) do
			if w.address == addr and ws and w.workspace and w.workspace.id == ws.id then
				for _, s in ipairs(states) do
					if s.address == addr then
						return
					end
				end
				add_window(w)
				return
			end
		end
	end, { timeout = 100, type = "oneshot" })
end)

-- toggling everything inside current workspace to floating for dvd, viceversa
hl.bind("SUPER + K", function()
	if timer then
		timer:set_enabled(false)
		timer = nil
		for _, s in ipairs(states) do
			if s.was_tiled then
				hl.dispatch(hl.dsp.window.float({ window = "address:" .. s.address, action = "unset" }))
			end
		end
		states = {}
		return
	end

	local current_workspace = hl.get_active_workspace()
	if not current_workspace then
		return
	end

	math.randomseed(os.time())
	states = {}

	for _, w in ipairs(hl.get_windows() or {}) do
		if not (w and w.workspace and w.workspace.id == current_workspace.id) then
			goto continue
		end
		add_window(w)
		::continue::
	end


	timer = hl.timer(function()
		for _, s in ipairs(states) do
			spin(s)
		end
	end, {
		timeout = 1000,
		type = "repeat",
	})
end)
