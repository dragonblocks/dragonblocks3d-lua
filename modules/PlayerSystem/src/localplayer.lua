local LocalPlayer = Dragonblocks.create_class()
table.assign(LocalPlayer, PlayerSystem.Player)

function LocalPlayer:constructor()
	self:init()
	self:set_fov(45)
	self:add_event_listener("after_set_position", function(event) self:set_position_callback(event) end)
end

function LocalPlayer:set_position_callback(event)
	-- Move Camera & Report to Server
end

function LocalPlayer:move(vec)
	self:set_position(self.pos + vec)
end

function LocalPlayer:set_fov(fov)
	self.fov = fov
	RenderEngine.fov = fov
end

return LocalPlayer
