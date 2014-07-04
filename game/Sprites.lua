-- load sprites here
-- just messy shit for now
-- no biggie

local Animation = require("Animation")

local Sprites = {}


------------------
-- Functions
------------------

-- make a single frame
local function MakeFrame(data)
	local f = {}

	------------
	-- Create
	------------

	f.x = data.x or 0
	f.y = data.y or 0
	f.width = data.width or 1
	f.height = data.height or 1
	f.imageWidth = data.imageWidth or 128
	f.imageHeight = data.imageHeight or 128
	f.sheet = Sprites.currentSheet

	f.frame = love.graphics.newQuad(f.x, f.y, f.width, f.height, f.imageWidth, f.imageHeight)

	-------------
	-- Function
	-------------

	function f:Draw(objectData)

		if(objectData.color) then
			love.graphics.setColor(objectData.color)
		else
			love.graphics.setColor({255,255,255,255})
		end 

		love.graphics.draw(self.sheet, self.frame, objectData.x, objectData.y, objectData.angle, objectData.xScale, objectData.yScale)

	end 

	return f
end

-- make multiple frames
local function MakeFrames(data)

	local frames = {}

	local yFrame = 0 
	local xFrame = 0

	for i=0, data.totalFrames-1 do
		local f = {}

		f.x = data.x + (data.width * xFrame)
		f.y = data.y + (data.height * yFrame)
		f.width = data.width or 1
		f.height = data.height or 1
		f.imageWidth = data.imageWidth or 128
		f.imageHeight = data.imageHeight or 128

		frames[#frames + 1] = MakeFrame(f)

		printDebug{"xFrame:" .. xFrame .. ", yFrame:" .. yFrame, "animation"}
	
		xFrame = xFrame + 1

		if(data.x + (data.width * xFrame) >= data.imageWidth) then
			xFrame = 0
			yFrame = yFrame + 1
		end 

	end 

	printDebug{"frames:" .. #frames, "animation"}

	return frames

end 

------------------
-- Robot dude
------------------
Sprites.dude = {}
Sprites.dude.red = {}
Sprites.dude.blue = {}
Sprites.dude.sheet = love.graphics.newImage("graphics/dude.png")
Sprites.dude.sheet:setFilter("nearest", "nearest")
Sprites.currentSheet = Sprites.dude.sheet

Sprites.dude.idle = MakeFrame
{
	x = 0,
	y = 0,
	width = 32,
	height = 32,
	imageWidth = 128,
	imageHeight = 128,	
}

Sprites.dude.blue.idle = MakeFrame
{
	x = 32,
	y = 0,
	width = 32,
	height = 32,
	imageWidth = 128,
	imageHeight = 128,	
}

-- bullet
Sprites.dude.bullet = MakeFrame
{
	x = 0,
	y = 32,
	width = 32,
	height = 32,
	imageWidth = 128,
	imageHeight = 128
}

Sprites.dude.bulletBlue = MakeFrame
{
	x = 32,
	y = 32,
	width = 32,
	height = 32,
	imageWidth = 128,
	imageHeight = 128
}



------------------
-- Pawn
------------------
Sprites.pawn = {}


-- create sprite sheet
Sprites.pawn.sheet = love.graphics.newImage("graphics/pawnSheet.png")
Sprites.pawn.sheet:setFilter("nearest", "nearest")


-- create frames
-- these exist to be used
-- you can add frames to a table to make an animation

-- the sprite sheet that you want to make frames from needs to be set
-- so that the frame can set it to its parent
Sprites.currentSheet = Sprites.pawn.sheet

Sprites.pawn.idle = MakeFrame
{
	x = 0,
	y = 0,
	width = 64,
	height = 64,
	imageWidth = 128,
	imageHeight = 128,
}

Sprites.pawn.attack = MakeFrame
{
	x = 0,
	y = 64,
	width = 64,
	height = 64,
	imageWidth = 128,
	imageHeight = 128
}

Sprites.pawn.walk = MakeFrame
{
	x = 64,
	y = 0,
	width = 64,
	height = 64,
	imageWidth = 128,
	imageHeight = 128
}

Sprites.pawn.damage = MakeFrame
{
	x = 64,
	y = 64,
	width = 64,
	height = 64,
	imageWidth = 128,
	imageHeight = 128	
}

Sprites.pawn.multi = MakeFrames
{
	totalFrames = 4,
	x = 0,
	y = 0,
	width = 64,
	height = 64,
	imageWidth = 128,
	imageHeight = 128	
}

-- Animations
Sprites.pawn.animation1 = Animation:New
{
	name = "stuff",

	sheet = Sprites.pawn.sheet,
	frames =	{
							-- multiple frames all in one table
							--Sprites.pawn.multi[1],
							--Sprites.pawn.multi[2],
							--Sprites.pawn.multi[3],
							--Sprites.pawn.multi[4]

							-- individual frames in seperate variables
							Sprites.pawn.walk, 
							Sprites.pawn.damage, 
							Sprites.pawn.attack, 
							Sprites.pawn.idle
						},

	delays = {10, 10, 10, 10},
	speed = 1,
}



return Sprites





--Notes

--