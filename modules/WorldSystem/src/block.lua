local Block = Dragonblocks.create_class()

function Block:constructor(pos, def)
	self.pos, self.def = pos, def
end

return Block
