-- valid strings:
--
-- f1, f2, f3, f4, f5, f6, f7, f8, f9, f10,
-- f11, f12, f13, f14, f15, f16, f17, f18, f19, f20,
--
-- pad., pad*, pad+, pad/, pad-, pad=,
-- pad0, pad1, pad2, pad3, pad4, pad5, pad6, pad7, pad8, pad9,
-- padclear, padenter,
--
-- home, end, pageup, pagedown, help,
-- left, right, down, up,
--
-- return, tab, space, delete, forwarddelete, escape,
-- shift, cmd, alt,  ctrl,
-- rightshift, rightcmd, rightalt, rightctrl
-- capslock, fn

local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)	
end

-- remap('capslock', pressFn({'rightctrl'}))

-- remap({'ctrl'}, 'space', pressFn('l'))
remap({'rightctrl'}, 'delete', pressFn('forwarddelete'))

remap({'rightctrl'}, 'h', pressFn('left'))
remap({'rightctrl'}, 'j', pressFn('down'))
remap({'rightctrl'}, 'k', pressFn('up'))
remap({'rightctrl'}, 'l', pressFn('right'))

remap({'rightctrl', 'shift'}, 'h', pressFn({'ctrl'}, 'left'))
remap({'rightctrl', 'shift'}, 'j', pressFn({'ctrl'}, 'down'))
remap({'rightctrl', 'shift'}, 'k', pressFn({'ctrl'}, 'up'))
remap({'rightctrl', 'shift'}, 'l', pressFn({'ctrl'}, 'right'))

remap({'rightctrl', 'cmd'}, 'h', pressFn({'cmd'}, 'left'))
remap({'rightctrl', 'cmd'}, 'j', pressFn({'cmd'}, 'down'))
remap({'rightctrl', 'cmd'}, 'k', pressFn({'cmd'}, 'up'))
remap({'rightctrl', 'cmd'}, 'l', pressFn({'cmd'}, 'right'))

remap({'rightctrl', 'alt'}, 'h', pressFn({'alt'}, 'left'))
remap({'rightctrl', 'alt'}, 'j', pressFn({'alt'}, 'down'))
remap({'rightctrl', 'alt'}, 'k', pressFn({'alt'}, 'up'))
remap({'rightctrl', 'alt'}, 'l', pressFn({'alt'}, 'right'))

-- remap({'rightctrl', 'shift', 'cmd'}, 'h', pressFn({'shift', 'cmd'}, 'left'))
-- remap({'rightctrl', 'shift', 'cmd'}, 'j', pressFn({'shift', 'cmd'}, 'down'))
-- remap({'rightctrl', 'shift', 'cmd'}, 'k', pressFn({'shift', 'cmd'}, 'up'))
-- remap({'rightctrl', 'shift', 'cmd'}, 'l', pressFn({'shift', 'cmd'}, 'right'))

-- remap({'rightctrl', 'shift', 'alt'}, 'h', pressFn({'shift', 'alt'}, 'left'))
-- remap({'rightctrl', 'shift', 'alt'}, 'j', pressFn({'shift', 'alt'}, 'down'))
-- remap({'rightctrl', 'shift', 'alt'}, 'k', pressFn({'shift', 'alt'}, 'up'))
-- remap({'rightctrl', 'shift', 'alt'}, 'l', pressFn({'shift', 'alt'}, 'right'))

-- remap({'rightctrl', 'cmd', 'alt'}, 'h', pressFn({'cmd', 'alt'}, 'left'))
-- remap({'rightctrl', 'cmd', 'alt'}, 'j', pressFn({'cmd', 'alt'}, 'down'))
-- remap({'rightctrl', 'cmd', 'alt'}, 'k', pressFn({'cmd', 'alt'}, 'up'))
-- remap({'rightctrl', 'cmd', 'alt'}, 'l', pressFn({'cmd', 'alt'}, 'right'))

-- remap({'rightctrl', 'cmd', 'alt', 'shift'}, 'h', pressFn({'cmd', 'alt', 'shift'}, 'left'))
-- remap({'rightctrl', 'cmd', 'alt', 'shift'}, 'j', pressFn({'cmd', 'alt', 'shift'}, 'down'))
-- remap({'rightctrl', 'cmd', 'alt', 'shift'}, 'k', pressFn({'cmd', 'alt', 'shift'}, 'up'))
-- remap({'rightctrl', 'cmd', 'alt', 'shift'}, 'l', pressFn({'cmd', 'alt', 'shift'}, 'right'))
