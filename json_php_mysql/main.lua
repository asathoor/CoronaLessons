-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- JSON, PHP, MYSQL EKSEMPEL
-- Eksempel paa brug af json objekter i Lua / Corona

local json = require ("json")
--local afkode = {}
-- networkListener
-- "lytter" efter respns fra www

local function networkListener( event )
 
  if ( event.isError ) then
  	-- hvis der ikke er kontakt til www el. lign.
    print( "Network error!")
  else
  
  	-- event.response er svar fra serveren
    local t = event.response
    
 	-- print data fra net som raat json obj   
    print ("\n\n json objektet t = \n\n" .. t)

	-- local afkode = json.decode( t ) til lua tabel
	local afkode = (json.decode( t ))

	-- print("\n\n -- afkode -- \n ")
	print(afkode)

	print("\n\n --- DECODE --- \n\n")
		
		-- afkode er en multidimensionelt table
		-- derfor (kan gøres meget mere elegant med et ekstra loop:
		-- 
		-- OPGAVE A)
		-- Skriv et mere elegant loop!
		-- 		tip: loop i loop ...
		
		for i=1, #afkode do
			print("\n\n")
			print(afkode[i][3])
			print(afkode[i][2])
			print(afkode[i][4])
    	end
	end

end

-- sender en request til en url
network.request( "http://www.multimusen.dk/test/json.php", "GET", networkListener )
