-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- INTRODUCTION TO LUA / CORONA SDK
-- Game bits and pieces
-- by Per Thykjaer Jensen

local x = display.contentWidth
local y = display.contentHeight

-----------------------------------------------------------------------------------------
-- ANIMATION VIA SPRITE SHEET AND TRANSITIONS
-----------------------------------------------------------------------------------------
 
-- set the size of the frames and of the total sheet
local sheetData = { width=140, height=140, numFrames=4, sheetContentWidth=280, sheetContentHeight=280 }

-- define name of imageSheet
local monster = graphics.newImageSheet( "monsterDance2.png", sheetData )

-- the sequence defined
local sequenceData = {
    { name = "normalRun", start=1, count=4, time=800 },
    { name = "fastRun", frames={ 1,4,1,4 }, time=250 }
  }

-- display on screen
local animation = display.newSprite( monster, sequenceData )

-- Transition.to will move and manipulate your sprite
transition.to(animation, { time = 3000, alpha = 0.5, x = 20, y = 600})

-- run animation
animation:play()

-----------------------------------------------------------------------------------------
-- ANIMATION EKSPORTERET FRA ADOBE FLASH
-- Højreklik på scenen og vælg export to sprite sheet
-----------------------------------------------------------------------------------------

local flashSheet = { 
	width=244, 
	height=294, 
	numFrames=35, 
	sheetContentWidth=2048, 
	sheetContentHeight=2048 
	}

local flashImage = graphics.newImageSheet( "sprite.png", flashSheet )

local flashSequence = {
    { name = "normalRun", start=1, count=35, time=800 },
  }

local animation2 = display.newSprite( flashImage, flashSequence )

transition.to(animation2, { time = 3000, alpha = 1, x = 800, y = 700})

animation2:play()


-----------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------

-- button ... first initiate widget
local widget = require( "widget" )

-- function to be used by the button
local function knapSluppet()
	
	-- size of tiles and tilesheet
	local sheetData = { width=140, height=140, numFrames=4, sheetContentWidth=280, sheetContentHeight=280 }

	-- define name of imageSheet
	local dance2 = graphics.newImageSheet( "monsterDance2.png", sheetData )

	-- the sequence defined
	local sequenceData = {
    	{ name = "normalRun", start=1, count=4, time=400 }
  	}

	-- display on screen
	local animation = display.newSprite( dance2, sequenceData )

	-- move animation drop point
	animation.x = 10

	-- Transition.to will move and manipulate your sprite
	transition.to(animation, { time = math.random() * 4000, alpha = 0, x = math.random()* 1000, y = math.random()* 1000 })

	-- run animation
	animation:play()
	animation2:pause()
	
end

-- Create the widget
local button1 = widget.newButton
{
    left = 600,
    top = 400,
    id = "button1",
    label = "<<- CLICK HERE PLEASE ->>",
    onRelease = knapSluppet
}

-- and you can style the buttons even more ...

button1._view._label.size = 66
button1.rotation = -20


