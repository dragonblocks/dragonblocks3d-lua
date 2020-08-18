local Chunk = Dragonblocks.create_class()

local size = 16
local size_squared = math.pow(size, 2)

function Chunk.get_pos_hash(pos)
	local x, y, z = pos.x, pos.y, pos.z
	if x > 15 or y > 15 or z > 15 or x < 0 or y < 0 or z < 0 then return end
	return x + size * y + size_squared * z
end

function Chunk:constructor(pos, blocks)
	self.pos, self.blocks = pos, blocks
end

function Chunk:add_block(pos, def)
	local pos_hash = Chunk.get_pos_hash(pos)
	if pos_hash then
		self.blocks[pos_hash] = WorldSystem.Block(pos, def)
		self:update_mesh()
	end
end

function Chunk:remove_block(pos)
	local pos_hash = Chunk.get_pos_hash(pos)
	if pos_hash then
		self.blocks[pos_hash] = nil
		self:update_mesh()
	end
end

function Chunk:get_block(pos)
	local pos_hash = Chunk.get_pos_hash(pos)
	if pos_hash then return self.blocks[pos_hash] end
end

function Chunk:update_mesh()
	if #self.blocks == 0 then return end
	local mesh = RenderEngine.ChunkMesh()
	mesh:set_pos(self.pos * 16 + glm.vec3(8, 8, 8))
	mesh:set_size(glm.vec3(1, 1, 1))
	mesh:create_faces(self.blocks)
	if not self.mesh then
		mesh:set_effect(RenderEngine.Mesh.EFFECT_FLYIN)
	end
	if self.mesh then
		self.mesh:remove_from_scene()
	end
	self.mesh = mesh
	mesh:add_to_scene()
end

return Chunk
