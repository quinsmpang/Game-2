-- settings for console output
-- this will include debug print

-- switches for what to print or not
-- flip on and off anytime
-- add a new switch by adding a string index
-- printDebug.["Name"]


local printDebugSettings = {}

-- switches
printDebugSettings["stuff"] = false
printDebugSettings["mathTest"] = false
printDebugSettings["animation"] = false
printDebugSettings["Health"] = false
printDebugSettings["Collision"] = false
printDebugSettings["Collision2"] = false
printDebugSettings["Collision3"] = false
printDebugSettings["CollisionList"] = false


--------------
-- Functions
--------------

-- alternative print with global switches
-- {"message", "typeName"}
function printDebug(data)

	if(printDebugSettings[data[2]]) then
		print(data[1])
	end 

end 






-------------------
-- Run on Require
-------------------

-- switch to print to console
local printAtRuntime = true

-- allows printing?
if(printAtRuntime) then
	io.stdout:setvbuf("no")
end 



-- notes
-------------------
-- should probly add global switches for love.graphic.print as well
-- will do that later