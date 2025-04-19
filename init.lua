hs.loadSpoon("EmmyLua")

local hotkey = require("hs.hotkey")
local window = require("hs.window")
local alert = require("hs.alert")

local layout = {
	leftHalf = hs.geometry.rect(0, 0, 0.5, 1),
	leftThird = hs.geometry.rect(0, 0, 0.33, 1),
	rightHalf = hs.geometry.rect(0.5, 0, 0.5, 1),
	rightThird = hs.geometry.rect(0.67, 0, 0.33, 1),
	full = hs.geometry.rect(0, 0, 1, 1),
}

local function moveToUnit(rect)
	local win = window.focusedWindow()
	if win then
		win:moveToUnit(rect)
	else
		alert.show("No focused Window")
	end
end

local function isWindowMathes(unitrect)
	local win = window.focusedWindow()
	if win then
		local frame = win:frame()
		local screen = win:screen()
		return frame == screen:fromUnitRect(unitrect)
	else
		alert.show("No focused Window")
	end
end

local function moveScreenLeft()
	local win = window.focusedWindow()
	if win then
		local screen = win:screen()
		local westScreen = screen.toWest(screen)
		win:moveOneScreenWest()
		return westScreen ~= nil
	else
		alert.show("No focused Window")
	end
end

local function moveScreenRight()
	local win = window.focusedWindow()
	if win then
		local screen = win:screen()
		local eastScreen = screen.toWest(screen)
		win:moveOneScreenEast()
		return eastScreen ~= nil
	else
		alert.show("No focused Window")
	end
end

hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "r", function()
	hs.reload()
end)

hotkey.bind({ "cmd", "alt", "ctrl" }, "f", function()
	moveToUnit(layout.full)
end)

hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "left", function()
	if isWindowMathes(layout.rightThird) then
		moveToUnit(layout.rightHalf)
	elseif isWindowMathes(layout.rightHalf) then
		moveToUnit(layout.full)
	elseif isWindowMathes(layout.full) then
		moveToUnit(layout.leftHalf)
	elseif isWindowMathes(layout.leftHalf) then
		moveToUnit(layout.leftThird)
	end
end)

hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "right", function()
	if isWindowMathes(layout.leftThird) then
		moveToUnit(layout.leftHalf)
	elseif isWindowMathes(layout.leftHalf) then
		moveToUnit(layout.full)
	elseif isWindowMathes(layout.full) then
		moveToUnit(layout.rightHalf)
	elseif isWindowMathes(layout.rightHalf) then
		moveToUnit(layout.rightThird)
	end
end)

hotkey.bind({ "cmd", "alt", "ctrl" }, "left", function()
	moveScreenLeft()
end)

hotkey.bind({ "cmd", "alt", "ctrl" }, "right", function()
	moveScreenRight()
end)
