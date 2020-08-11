local Chunk = Dragonblocks.create_class()

local size = 16
local size_squared = math.pow(size, 2)

function Chunk:constructor()
	self.blocks = {}
	MapGen:generate(self)
	if Client then
		Client.graphics:create_chunk_meshes(self)
	end
end

function Chunk:get_pos_hash(pos)
	local x, y, z = pos.x, pos.y, pos.z
	if x > 15 or y > 15 or z > 15 or x < 0 or y < 0 or z < 0 then return end
	return x + size * y + size_squared * z
end

function Chunk:add_block(pos, def)
	local block = WorldSystem.Block(def, pos)
	self.blocks[self:get_pos_hash(pos)] = block
end

function Chunk:remove_block(pos)
	self.blocks[self:get_pos_hash(pos)] = nil
end

function Chunk:get_block(pos)
	return self.blocks[self:get_pos_hash(pos)]
end

return Chunk
