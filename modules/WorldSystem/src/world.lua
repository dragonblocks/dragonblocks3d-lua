local World = Dragonblocks.create_class()

function World:constructor()
	self.map = WorldSystem.Map()
end

return World
