hs.loadSpoon("EmmyLua")

local hotkey = require("hs.hotkey")
local window = require("hs.window")
local alert = require("hs.alert")
local layout = require("hs.layout")

local function moveToUnit(rect)
	local win = window.focusedWindow()
	if win then
		win:moveToUnit(rect)
	else
		alert.show("No focused Window")
	end
end

local function isWindowMaximized()
	local win = window.focusedWindow()
	if win then
		local frame = win:frame()
		local screen = win:screen()
		return frame == screen:fromUnitRect(hs.layout.maximized)
	else
		alert.show("No focused Window")
	end
end

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

hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "left", function()
	if isWindowMaximized() then
		moveToUnit(layout.left50)
	end
end)

hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "right", function()
	if isWindowMaximized() then
		moveToUnit(layout.right50)
	end
end)
