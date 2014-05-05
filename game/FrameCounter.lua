-- calculates and displays FPS

local FrameCounter = {}


-- switches
FrameCounter.active = true
FrameCounter.printDeltaTime = false

-- variables
FrameCounter.x = 10
FrameCounter.y = 10
FrameCounter.color = {0, 255, 0, 255}


local time = 0
local frameCount = 0
local fps = 0
local updateRate = 4


function FrameCounter:Update(dt)

	if(self.active == false) then
		return
	end


	frameCount = frameCount + 1
	time = time + dt

	if(time > 1/updateRate) then
		fps = frameCount / dt
		frameCount = 0
		time =  time - (1/updateRate)
	end 

end 


-- draw the fps to screen
function FrameCounter:Draw()
	if(self.active == false) then
		return
	end 

	love.graphics.setColor(self.color)
	love.graphics.print("FPS:" .. math.floor(fps), self.x, self.y)

	if(self.printDeltaTime) then
		love.graphics.print("DT:" .. deltaTime, self.x, self.y+16)
	end 

end 


return FrameCounter