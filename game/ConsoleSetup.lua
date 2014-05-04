-- settings for console output
-- this will include debug print

-- switches for what to print or not
-- flip on and off anytime
-- add a new switch by adding a string index
-- printDebug.["Name"]
local printDebugSettings = {}

-- switches
printDebugSettings["stuff"] = false

--------------------------------
-- Functions
----------------------------

-- alternative print with global switches
-- {"message", "typeName"}
function printDebug(data)

	if(printDebugSettings[data[2]]) then
		print(data[1])
	end 

end 






---------------------------
-- run on require
--------------------------------

-- switch to print to console
local printAtRuntime = true

-- allows printing?
if(printAtRuntime) then
	io.stdout:setvbuf("no")
end 