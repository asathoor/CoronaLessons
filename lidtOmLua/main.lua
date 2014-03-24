-- Corona Lidt om Lua
-- eksempel baseret paa http://developer.coronalabs.com/resources/corona-quick-start-guide 
-- eksemplet er tilpasset en iPhone5

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


-- lav en table
minTable = { "Mojn Do", "Allo", "Anyong ha-seyo", "Hello", "Ave" }


-- teksten editeres (teksten kommer EFTER baggrunden, fordi Lua afvikles i rækkefølgen fra top mod bund i koden)
--myText = display.newText( "Hvilke dyr?", 333, 250, native.systemFont, 65 )


-- lav teksten om til noget fra tablellen
-- hvad er forskellen paa denne syntaks om PHP?
myText = display.newText( minTable[3], 333, 250, native.systemFont, 65 )

-- øvelse A: tilføj flere værdier til minTable, og vis dem op skærmen

-- øvelse B: brug et loop og skriv og placer en hel table ud på skærmen
-- 		tip: brug et loop
--		http://lua.gts-stolberg.de/en/schleifen.php

-- øvelse C: lav nogle beregninger ved at lægge oprette mindst 3 variable.
--		tip: nytekst = display.newText( ... )

-- øvelse D: strenge samles sådan x = A .. B
A = "Santa "
B = "Claus "
C = 23
-- myText = display.newText( A .. B .. C, 333, 250, native.systemFont, 65 )

-- design-fis
myText:setTextColor( 255,0,255 )
myText.yScale = 3.0
myText.yScale = 3.0
myText.rotation = 12