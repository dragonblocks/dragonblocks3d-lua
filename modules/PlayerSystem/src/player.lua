local Player = {}

function Player:init()
	Dragonblocks.create_event_interface(self)
	self.pos = glm.vec3(0, 0, 0)
end

function Player:set_position(pos)
	self:fire_event({
		type = "on_set_position",
		new_position = pos,
		cancel = false
	}, function(evt) self:raw_set_position(evt) end)
end

function Player:raw_set_position(event)
	local self = event.origin
	if not event.cancel then
		self.pos = event.new_position
	end
	self:fire_event({
		type = "after_set_position",
	})
end



return Player
