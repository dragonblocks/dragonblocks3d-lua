local Block = Dragonblocks.create_class()

function Block:constructor(def, pos)
	self.def, self.pos = def, pos
end

return Block
