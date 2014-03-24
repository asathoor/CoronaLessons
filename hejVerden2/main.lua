-- Corona Hej Verden 
-- eksempel baseret paa http://developer.coronalabs.com/resources/corona-quick-start-guide 

-- baggrund
-- background = display.newImage( "images/monkey.png" )

-- skalering af baggrund (den magiske formular)
application =
{
	content =
	{
		width = 320,
		height = 480,
		scale = "letterbox",
		xAlign = "center",
		yAlign = "top"
	},
}

-- baggrund hentes frem
background = display.newImage( "images/monkey.png", true )

-- baggrund centreres
background.x = display.contentWidth / 2
background.y = display.contentHeight / 2

-- teksten editeres (teksten kommer EFTER baggrunden, fordi Lua afvikles i rækkefølgen fra top mod bund i koden)
myText = display.newText( "Hvilke dyr?", 333, 250, native.systemFont, 65 )

-- eksperimenter
myText:setTextColor( 255,255,255 )
myText.yScale = 3.0
myText.yScale = 3.0
myText.rotation = 12