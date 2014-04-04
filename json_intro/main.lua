-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- importerer biblioteket
local json = require "json"

-- t er en Lua table
-- normalt ville man importere strengen fra nettet
-- eller fra en lokal sqlite database
local t = { 
    ["name1"] = "value1",
    ["name2"] = { 1, false, true, 23.54, "a \021 string" },
    name3 = json.null
}

-- Lua table kodes til json
-- kan fx bruges til udveksling af data via 
-- php og MySql
local encode = json.encode (t)
print ("\n\nHer er json objektet:\n\n" .. encode)  --> {"name1":"value1","name3":null,"name2":[1,false,true,23.54,"a \u0015 string"]}

-- Decode oversaetter et json objekt til en Lua table
local decode = json.decode( encode )

-- hvis Du kender tabellen kan en raekke printes ud saadan:
print( decode.name2[4] )  --> 23.54

-- LOOP GENNEM TABLE
-- ... men et loop er smartere
-- Lidt Lua lingo:
-- # = table length
-- decode = a lua table
-- name2 = table name

for i=1,#decode.name2 do
	print(decode.name2[i])
end

-- Eksperiment:
-- udskriv tabellen til skaermen
-- tip: .. display.newText