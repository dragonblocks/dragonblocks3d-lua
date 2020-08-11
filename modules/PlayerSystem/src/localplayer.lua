local LocalPlayer = Dragonblocks.create_class()
table.assign(LocalPlayer, PlayerSystem.Player)

function LocalPlayer:constructor()
	self:init()
	self:set_speed(10)
	self:set_fov(45)
	self:set_yaw(180)
	self:set_pitch(0)
	self:add_event_listener("after_set_position", function(event) self:set_position_callback(event) end)
	RenderEngine:add_event_listener("keypress", function(event) self:key_press_callback(event) end)
	RenderEngine:add_event_listener("mousemove", function(event) self:mouse_move_callback(event) end)
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
	local hvec, vvec = self.horizontal_look, RenderEngine.camera.up
	if keys["w"] then
		self:move( speed * hvec)
	elseif keys["s"] then
		self:move(-speed * hvec)
	end
	if keys["a"] then
		self:move(-speed * (hvec % vvec):normalize())
	elseif keys["d"] then
		self:move( speed * (hvec % vvec):normalize())
	end
	if keys["left shift"] then
		self:move(-speed * vvec)
	elseif keys["space"] then
		self:move( speed * vvec)
	end
end

function LocalPlayer:mouse_move_callback(event)
	self.yaw = self.yaw - event.x
	self.pitch = self.pitch - event.y
	self:update_look()
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

function LocalPlayer:set_yaw(yaw)
	self.yaw = math.rad(yaw)
	self:update_look()
end

function LocalPlayer:set_pitch(pitch)
	self.pitch = math.rad(pitch)
	self:update_look()
end

function LocalPlayer:update_look()
	self.horizontal_look = glm.vec3(math.sin(self.yaw), 0, math.cos(self.yaw)):normalize()
	RenderEngine.camera.front = glm.vec3(math.sin(self.yaw or 0), math.sin(self.pitch or 0), math.cos(self.yaw or 0)):normalize()
end

return LocalPlayer
