-- Map
-- base test map with tiles that show terrain and respond to player movement


local Box = require("Box")
local ObjectUpdater = require("ObjectUpdater")
local Color = require("Color")
local Map = {}

Map.tileWidth = 64
Map.tileHeight = 32

Map.width = 10
Map.height = 6

Map.opacity = 150

Map.x = Map.tileWidth * 2
Map.y = Map.tileHeight * 5

Map.xStart = ((Map.x - (Map.x % Map.tileWidth)) / Map.tileWidth) + 1
Map.yStart = ((Map.y - (Map.y % Map.tileHeight)) / Map.tileHeight) + 1


Map.tiles = 
{ 
	x = {}, 
}



-- create a single tile
function Map:MakeTile(data)

	local object = {}

	object.box = Box:New
	{
		x = data.x,
		y = data.y,
		width = data.width,
		height = data.height,
		color = Color.white,
		fill = false
	}

	object.box.color[4] = self.opacity


	--------------
	-- Variables
	--------------

	object.y = data.y
	object.yOffset = 0
	object.objectOnTop = false
	object.cushion = 6


	--------------
	-- Functions
	--------------

	function object:VerticalCushion()
		if(object.objectOnTop) then
			self.yOffset = self.cushion
		else

			if(self.yOffset > 0) then
				self.yOffset = self.yOffset * 0.9
			end 
		end

		self.objectOnTop = false

	end

	function object:Offset()
		self.box.y = self.y + self.yOffset
	end 

	--------------
	-- Manage
	--------------

	-- add to map
	if(self.tiles.x[data.xIndex] == nil) then
		self.tiles.x[data.xIndex] = {}

		if(self.tiles.x[data.xIndex].y == nil) then
			self.tiles.x[data.xIndex].y = {}			
		end 

	end 

	self.tiles.x[data.xIndex].y[data.yIndex] = object

	-- add to object manager
	ObjectUpdater:Add{object}

	return object
end


-- create the base test map
function Map:Create()

	for x=1, self.width do
		for y=1, self.height do

			self:MakeTile
			{
				x = (self.x + (x-1) * Map.tileWidth + (1 * x)) ,
				y = (self.y + (y-1) * Map.tileHeight + (1 * y)),
				width = Map.tileWidth - 1,
				height = Map.tileHeight - 1,
				xIndex = x,
				yIndex = y
			}

		end 	
	end 



function Map:GetTile(x,y)
	return self.tiles.x[x].y[y]
end 

function Map:ObjectInTile(obj)

	local x = obj.mapX - self.xStart + 1
	local y = obj.mapY - self.yStart + 1


	--print(x .. " " .. y)

	if(x < 1 or y < 1 ) then
	
		return
	end 

	if(x > self.width or y > self.height) then
	
		return
	end

	local tile = self:GetTile(x, y)
	
	tile.box.color = Color[obj.playerColor]
	tile.box.color[4] = self.opacity
	tile.objectOnTop = true

end 


end 


function Map:PrintDebugText()	
	DebugText:TextTable
	{
		{text = ""},
		{text = "Map"},
		{text = "---------"},
		{text = #self.tiles.x},
		{text = #self.tiles.x[1].y},

		{text = self.xStart .. " "  .. self.yStart}


	}
end



function Map:Update()

	self:PrintDebugText()

	for x=1, #self.tiles.x do
		for y=1, #self.tiles.x[x].y do

			local tile = self.tiles.x[x].y[y]
			
			tile:VerticalCushion()
			tile:Offset()

		end 
	end 

end 

Map:Create()





return Map