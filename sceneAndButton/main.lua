-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- denne main lua rummer diverse elementer til spiludvikling.
-- knapper, drag & drop, physics, collision detection etc.
-- denne fil er kodet til en iPhone.
-- (C) GPLv4 - Per Thykjær Jensen 2014 - all rights reserved.
-----------------------------------------------------------------------------------------

-- hide the status bar, shouldnt this just be on by default?
display.setStatusBar(display.HiddenStatusBar)


-- farver: brug kun websafe colors

-- widgets (knapper mv.)
local widget = require("widget")

-- fysiske ting
local physics = require( "physics" ) -- henter fysik
physics.start() -- fysik startes

display.setStatusBar ( display.HiddenStatusBar )
local storyboard = require ( "storyboard" )
local statusTekst = "test"

-- storyboard.gotoScene("menu")

-- gem statusbar
display.setStatusBar( display.HiddenStatusBar ) 

-- globale variable
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen


-- firkanter
squares = {}

squares[4] = display.newRect( 0, 0, _W, _H)
squares[4].x = display.contentWidth/2
squares[4].y = display.contentHeight/2
squares[4]:setFillColor(10/255, 10/255, 60/255)

-- farver: rgb men som % af 255 - derfor 10/ 255 ...

squares[3] = display.newRect( 0, 0, 100, 30 )
squares[3].x = 0
squares[3].y = 400
squares[3]:setFillColor(30/255,30/255,100/255)

squares[1] = display.newRect( 0, 0, 300, 10)
squares[1].x = _W * .3
squares[1].y = _H/2
squares[1]:setFillColor(136/255,136/255,194/255)

squares[2] = display.newRect( 0, 0, 300, 55 )
squares[2].x = _W/2 
squares[2].y = _H/2
squares[2]:setFillColor(10/255, 10/255, 60/255)
 
-- KASSEN
-- en kasse som kan kaldes via en funktion

function tegnKasse()

	kasse = display.newRect( 0, 0, math.random(300)+10, math.random(100)+5 )
	kasse.x = math.random(500) + 1
	kasse.y = math.random(100) + 1
	kasse:setFillColor(math.random(255) / 255,math.random(255) / 255, 0, math.random(255)/255 )
	kasse.rotation = 15

-- denne kasse tilføjes physics
physics.addBody(
	kasse, 
	{
		density = 1.1, 
		friction = 0.3, 
		bounce = 1.2
	} 
)

end -- slut på tegnKasse()

-- ANIMATION via transition
-- her er masser af muligheder for at eksperimentere

local square = display.newRect( 0, 0, 100, 100 )
square:setFillColor(255,102,0)

local w,h = display.contentWidth, display.contentHeight

local listener1 = function( obj )
    print( "Transition 1 completed on object: " .. tostring( obj ) )
    square:setFillColor(102,0,153)
end

local listener2 = function( obj )
    print( "Transition 2 completed on object: " .. tostring( obj ) )
    square:setFillColor(255,0,255)
    -- her kunne man require en anden scene via storyboard
end

-- og derefter gør vi kassen fysisk
physics.addBody(
	square,
	{
		friction = 0.8
	}
)
square.bodyType = "static"

-- (1) move square to bottom right corner; subtract half side-length
transition.to( square, { time=1500, alpha=0, x=math.random(1,500), y=(math.random(100,400)), onComplete=listener1 } )

-- (2) fade square back in after 2.5 seconds
transition.to( square, { time=500, delay=2500, alpha=1.0, onComplete=listener2 } )

-- PHYSICS
-- jordens overflade

local ground = display.newRect(_W, _H, 1020,10)
ground:setFillColor(0,255,0)

-- ethvert display element kan tilføjes sådan:
physics.addBody( ground, {friction = 0.5} )
ground.bodyType = "static"

 
-- DRAG AND DROP
-- drag url http://thatssopanda.com/corona-sdk-tutorials/dragging-an-object-in-corona-sdk/
-- create a circle and put it in the center of the screen
local circle = display.newCircle( display.contentWidth*0.5,display.contentHeight*0.5, 75)
circle:setFillColor( 0,10,0 )
 
-- touch listener function
function circle:touch( event )
  if event.phase == "began" then

    -- first we set the focus on the object
    display.getCurrentStage():setFocus( self, event.id )
    self.isFocus = true

    -- then we store the original x and y position
    self.markX = self.x
    self.markY = self.y
    
    visTekst("Cirkelen flyttes nu ... ")
 
  elseif self.isFocus then
 
    if event.phase == "moved" then
      -- then drag our object
      self.x = event.x - event.xStart + self.markX
      self.y = event.y - event.yStart + self.markY
      
      
    elseif event.phase == "ended" or event.phase == "cancelled" then
      -- we end the movement by removing the focus from the object
      display.getCurrentStage():setFocus( self, nil )
      self.isFocus = false
      
      -- fjerner tekst ved drop
      status:removeSelf()
      status = nil
      
    end
 
  end
  
-- return true so Corona knows that the touch event was handled propertly
 return true
end
 
-- finally, add an event listener to our circle to allow it to be dragged
circle:addEventListener( "touch", circle )

-- status tekst
function visTekst(besked)

		status = display.newText(
		besked,
		350,
		30,
		native.systemFont,
		25
	)

end

-- CIRKEL DRAG & DROP

physics.addBody(
	circle,
	{
		friction = 0.8
	}
)
circle.bodyType = "static"


-- status for kollisioner
hit = 0

-- viser status for kollisioner
etHit = display.newText(
			hit,
			100,
			60,
			native.systemFont,
			25
		)
		

-- collision
local function onCollision( event )

    if ( event.phase == "began" ) then

        hit = hit +1
        
        etHit:removeSelf() -- sletter den gamle hitstatus
        etHit = nil -- gør variablen til nil
        
        etHit = display.newText(
			hit,
			100,
			60,
			native.systemFont,
			25
		)
		square:applyLinearImpulse( 0.5, 1, square.x, square.y	 )

    elseif ( event.phase == "ended" ) then

		-- noget sker her ...

    end
end

Runtime:addEventListener( "collision", onCollision )

-- KNAPPER 
-- Kræver at widget library indlæses først. se l. 8

local trykket = nil

local function handleButtonEvent(event)

	if ( "ended" == event.phase ) then
	
		tegnKasse()
	
        local trykket = display.newText(
        	"Nogen trykkede på knappen",
        	200,
			300,
			native.systemFont,
			12
        )
	end

end

local minKnap = widget.newButton
{
	width = 70,
	height = 70,
	defaultFile = "default.png",
	overFile = "over.png",
	label = "Tryk her",
	labelColor = { default = { 0, 0, 0 }, over = { 0, 0, 0} },
	onEvent = handleButtonEvent
}
minKnap.x = 160