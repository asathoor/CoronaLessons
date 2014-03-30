-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- INTRODUCTION TO LUA / CORONA SDK
-- Game bits and pieces
-- by Per Thykjaer Jensen

-----------------------------------------------------------------------------------------
-- IMAGES, GEOMETRY ETC.
-----------------------------------------------------------------------------------------

local x = display.contentWidth
local y = display.contentHeight

--rectangle
local rect = display.newRect( 0, 0, 1980, 1980 )
rect.x = display.contentWidth / 2
rect.y = display.contentHeight / 2
rect:setFillColor(23,0,0)

-- background
-- local bg = display.newImage( "bg3.png")
-- bg.x = display.contentWidth / 2
-- bg.y = display.contentHeight / 2


--text
local myText = display.newText( "Hej Verden!", 300, 400, native.systemFont, 34 )

--circle
local myCircle = display.newCircle( 100, 100, 560 )
myCircle:setFillColor( 0.1,0.2,1 )

--standard image
-- local myImage = display.newImage( "computerClassUML.png", 240, 120)

-----------------------------------------------------------------------------------------
-- ANIMATION VIA SPRITE SHEET AND TRANSITIONS
 -----------------------------------------------------------------------------------------
 
-- set the size of the frames and of the total sheet

-- size of tiles and tilesheet
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
-- BUTTONS
-----------------------------------------------------------------------------------------

-- button ... first initiate widget
local widget = require( "widget" )

-- function to be used by the button
local function knapSluppet()
	-- display.newText( "Yep, the button works all right.", 600, 300, native.systemFont, 45 )

	-- button initiates a new animation instance
	
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
	
	--ends animation

end

-- Create the widget
local button1 = widget.newButton
{
    left = 600,
    top = 500,
    id = "button1",
    label = "<<- CLICK HERE PLEASE ->>",
    onRelease = knapSluppet
}

-- and you can style the buttons even more ...

button1._view._label.size = 66
button1.rotation = -20


-- DATABASE
-- sqlite sample (using a local database)

-- inkluderer databasefilen

print("\nHenter sqlite og filen med databasen")

require "sqlite3"
local path = system.pathForFile("almanak.db", system.ResourceDirectory)
db = sqlite3.open( path )--print the sqlite version to the terminal
print( "\nSqlite version: " .. sqlite3.version() )

-- hvis app lukkes lukkes db ogsaa
function onSystemEvent( event )
if( event.type == "applicationExit" ) then
db:close()
end
end

print("\nHenter databasens posteringer")

-- henter poster fra databasen
function visData()
	local SQL = "SELECT * FROM dato"
	local tempTable = {}

	for row in db:nrows(SQL) do
		tempTable = row
		print("Den " .. row.dag .. "." .. row.maaned .. ". \nBla. bla. bla. ")
	end

	return tempTable
end

-- and execute ...
visData()
