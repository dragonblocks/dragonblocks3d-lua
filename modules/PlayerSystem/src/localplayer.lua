local LocalPlayer = Dragonblocks.create_class()
table.assign(LocalPlayer, PlayerSystem.Player)

function LocalPlayer:constructor()
	self:init()
	self:set_speed(4)
	self:set_fov(45)
	self:set_yaw(180)
	self:set_pitch(0)
	self:add_event_listener("after_set_position", function(event) self:set_position_callback(event) end)
	RenderEngine:add_event_listener("keypress", function(event) self:key_press_callback(event) end)
	RenderEngine:add_listen_key("w")
	RenderEngine:add_listen_key("a")
	RenderEngine:add_listen_key("s")
	RenderEngine:add_listen_key("d")
	RenderEngine:add_listen_key("space")
	RenderEngine:add_listen_key("left shift")
end

function LocalPlayer:key_press_callback(event)
	local keys = event.keys
	local speed = self.speed * event.dtime
	local yawvec, pitchvec = self.yaw_vector, self.pitch_vector
	local vertvec = glm.vec3(0, 1, 0)
	if keys["w"] then
		self:move( speed * yawvec)
	elseif keys["s"] then
		self:move(-speed * yawvec)
	end
	if keys["a"] then
		self:move(-speed * (yawvec % pitchvec):normalize())
	elseif keys["d"] then
		self:move( speed * (yawvec % pitchvec):normalize())
	end
	if keys["left shift"] then
		self:move(-speed * vertvec)
	elseif keys["space"] then
		self:move( speed * vertvec)
	end
end

function LocalPlayer:set_position_callback(event)
	RenderEngine.camera.pos = self.pos
end

function LocalPlayer:move(vec)
	self:set_position(self.pos + vec)
end

function LocalPlayer:set_fov(fov)
	self.fov = fov
	RenderEngine.fov = fov
end

function LocalPlayer:set_yaw(degrees)
	local radians = math.rad(degrees)
	self.yaw_vector = glm.vec3(math.sin(radians), 0, math.cos(radians)):normalize()
	RenderEngine.camera.front = self.yaw_vector
end

function LocalPlayer:set_pitch(degrees)
	local radians = math.rad(degrees)
	self.pitch_vector = glm.vec3(0, 1, 0)
	RenderEngine.camera.up = self.pitch_vector
end

return LocalPlayer
