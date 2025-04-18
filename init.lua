hs.loadSpoon("EmmyLua")

local hotkey = require("hs.hotkey")
local window = require("hs.window")
local alert = require("hs.alert")

hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "r", function()
	hs.reload()
end)

hotkey.bind({ "cmd", "alt", "ctrl" }, "f", function()
	local win = window.focusedWindow()
	if win then
		win:maximize()
	else
		alert.show("No focused window")
	end
end)
