-- AnimationComponent.lua

-- purpose
--------------------
-- control animations for an object
-- when to play them, how fast, names, etc


local AnimationComponent = {}

-------------------
-- Static Info
-------------------
AnimationComponent.Info = Info:New
{
	objectType = "AnimationComponent",
	dataType = "Graphics",
	structureType = "Static"
}


---------------
-- Object
---------------


function AnimationComponent:New(data)

	-- Fails
	if(data.parent == nil) then
		print("parent required!")
		return
	end 
	
	local o = {}

	------------------
	-- Info
	------------------
	o.Info = Info:New
	{
		name = data.name or "...",
		objectType = "AnimationComponent",
		dataType = "Graphics",
		structureType = "Component"
	}

	-------------
	-- Vars
	-------------

	-- table and list of animations this object has
	o.animations = {}
	o.animations.index = {}

	-- current animation
	-- does not have to be playing, may be paused
	o.selectedAnimation = nil

	-- auto play animations
	o.playAnimationsByState = Bool:DataOrDefault(data.playAnimationsByState, true)
	o.state = "idle"

	o.parent = data.parent
	----------------
	-- Functions
	----------------

	function o:Add(data)

		data.animation.parent = self.parent
		self.animations[data.name] = data.animation
		self.animations.index[#self.animations.index+1] = data.name

		if(#self.animations.index == 1) then
			self.selectedAnimation = self.animations[data.name]
			self.selectedAnimation.draw = true
		end

		if(#self.animations.index > 1) then
			self.animations[data.name].draw = false
		end 


		for i=1, #self.animations.index do
			print(self.animations.index[i])
			print(self.animations[self.animations.index[i]].draw)
		end 
		print("----------")


	end

	-- set state of animation component
	-- this is layer above play to help control animations
	-- simple for now, but will have more conditions later
	function o:State(name)
		if(name == self.state) then
			return
		end 

		if(self.animations[name] == nil) then
			printDebug{"no animation by that name...", "AnimationComponent"}
			return
		end 

		self.state = name
		self:Play(self.state)
	end 

	-- play animation by given name
	function o:Play(name)
		print("playing animation")

		-- hide old animation
		self.selectedAnimation.active = false
		self.selectedAnimation.draw = false

		-- start new animation
		print(name)
		self.selectedAnimation = self.animations[name]
		self.selectedAnimation.active = true
		self.selectedAnimation.pause = false
		self.selectedAnimation.draw = true

	end 

	-- pause the selected animation
	function o:Pause()
		self.selectedAnimation.pause = true
	end 

	function o:PrintDebugText()

		DebugText:TextTable
		{
			{text = "", obj = "AnimationComponent" },
			{text = "Animation Component"},
			{text = "---------------------"},
			{text = self.state}
		}

	end 


	----------
	-- End
	----------
	ObjectManager:Add{o}

	return o

end 

----------------
-- Static End
----------------

ObjectManager:AddStatic(AnimationComp)

return AnimationComponent




-- Notes
-----------------------------------
-- need directional variations per animation
-- throw in table of some sort that figures it out

-->NEED
-- backwards loading of animations
-- an animation should know what Sprites and SpriteSheet it needs
-- an object should load resources it needs
-- these resources can be shared by other objects
-- will need some sort of graphics manager for this