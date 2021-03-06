-- Life.lua

-- Purpose
----------------------------
-- basic component for destroying objects when they get too old
-- this is for simple objects like lines, boxes, etc
-- this is not a health component for players/enemies


local Life = {}

------------------
-- Static Info
------------------

Life.Info = Info:New
{
	objectType = "Life",
	dataType = "Gameplay",
	structureType = "Static"
}

---------------------
-- Static Functions
---------------------

--{life, maxLife, drain, parent}
function Life:New(data)

	local o = {}

	-----------
	-- Fails
	-----------
	if(data.parent == nil) then
		printDebug{"Fail: Life requires data.parent", "Fail"}
		return
	end 

	------------------
	-- Info
	------------------
	o.Info = Info:New
	{
		name = data.name or "...",
		objectType = "Life",
		dataType = "Component",
		structureType = "Object"
	}

	
	----------------
	-- Vars
	----------------
	o.life = data.life or 100
	o.maxLife = data.maxLife or o.life
	o.drain = data.drain or nil

	if(data.drain == nil) then
		o.drain = true
	else
		o.drain = data.drain
	end 

	o.parent = data.parent or nil


	------------------
	-- Functions
	------------------

	function o:Update()
		self:Drain()
		self:CheckDead()
	end 


	-- lowers the life over time --> default behavior
	-- called on Update
	function o:Drain()

		if(self.drain) then
			self.life = self.life - 1
		end 

	end 

	-- check the life, if depleted, destroy
	function o:CheckDead()
		
		if(self.life <= 0) then
			ObjectManager:Destroy(self.parent)
		end 

	end 

	-- this will cause the parent
	-- to be destroyed next frame
	function o:Kill()
		self.life = 0
	end 

	-- increase life
	function o:Add(v)
		self.life = self.life + v
	end

	-- decrease life
	function o:Sub(v)
		self.life = self.life - v
	end 

	-- return life to original max
	function o:Reset()
		self.life = self.maxLife
	end

	function o:Destroy()
		ObjectManager:Destroy(self.Info)
	end 


	ObjectManager:Add{o}

	return o

end


ObjectManager:AddStatic(Life)

return Life




-- Notes
---------------------------------------
-- I think only particles use this component right now