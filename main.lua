-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

display.setStatusBar(display.HiddenStatusBar)

--呼叫composer函式庫
--然後直接到game_menu.lua
local composer = require( "composer" )
local scene = composer.newScene()
composer.gotoScene("game_menu")
