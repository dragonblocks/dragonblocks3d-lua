local LocalPlayer = Dragonblocks.create_class()
table.assign(LocalPlayer, PlayerSystem.Player)

function LocalPlayer:constructor()
	self:init()
	self:set_speed(10)
	self:set_fov(86.1)
	self:set_yaw(-90)
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
	local camera = RenderEngine.camera
	local front, right, up = camera.front, camera.right, camera.up
	if not RenderEngine.pitch_move then
		front = glm.vec3(front.x, 0, front.z):normalize()
		up = glm.vec3(0, up.y, 0):normalize()
	end
	if keys["w"] then
		self:move( speed * front)
	elseif keys["s"] then
		self:move(-speed * front)
	end
	if keys["d"] then
		self:move( speed * right)
	elseif keys["a"] then
		self:move(-speed * right)
	end
	if keys["space"] then
		self:move( speed * up)
	elseif keys["left shift"] then
		self:move(-speed * up)
	end
end

function LocalPlayer:mouse_move_callback(event)
	self.yaw = self.yaw + event.x
	self.pitch = self.pitch - event.y
	self:update_camera()
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
	self.yaw = yaw
	self:update_camera()
end

function LocalPlayer:set_pitch(pitch)
	self.pitch = pitch
	self:update_camera()
end

function LocalPlayer:update_camera()
	RenderEngine.camera:update(self.yaw or 0, self.pitch or 0)	
end

return LocalPlayer
