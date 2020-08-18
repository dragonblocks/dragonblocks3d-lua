local Map = Dragonblocks.create_class()

local size = 1000
local size_squared = math.pow(size, 2)


function Map.get_pos_hash(pos)
	local x, y, z = pos.x, pos.y, pos.z
	if x > 999 or y > 999 or z > 999 or x < -999 or y < -999 or z < -999 then return end
	return x + size * y + size_squared * z
end 

function Map.get_chunk_pos(pos)
	return glm.vec3(math.floor(pos.x / 16), math.floor(pos.y / 16), math.floor(pos.z / 16))
end

function Map.get_block_pos(pos)
	return pos * 16
end

function Map.get_chunk_pos_and_block_pos(pos)
	local chunk_pos = Map.get_chunk_pos(pos)
	local block_pos = pos - Map.get_block_pos(chunk_pos)
	return chunk_pos, block_pos
end

function Map:constructor()
	self.chunks = {}
end

function Map:get_block(pos)
	local chunk, block_pos = self:get_chunk_and_block_pos(pos)
	if chunk then return chunk:get_block(block_pos) end
end

function Map:add_block(pos, block)
	local chunk, block_pos = self:get_chunk_and_block_pos(pos)
	if chunk then return chunk:add_block(block_pos, block) end
end

function Map:remove_block(pos)
	local chunk, block_pos = self:get_chunk_and_block_pos(pos)
	if chunk then return chunk:remove_block(block_pos) end
end

function Map:create_chunk(pos, data)
	local pos_hash = Map.get_pos_hash(pos)
	if not pos_hash then return end
	local minp = Map.get_block_pos(pos)
	local maxp = minp + glm.vec3(16, 16, 16)
	local data = data or MapGen.generate(minp, maxp)
	local chunk = WorldSystem.Chunk(pos, data)
	self.chunks[pos_hash] = chunk
	Dragonblocks:add_task(function()
		chunk:update_mesh()
	end)
end

function Map:create_chunk_if_not_exists(pos, data)
	if not self:get_chunk(pos) then self:create_chunk(pos, data) end
end

function Map:get_chunk(pos)
	local pos_hash = Map.get_pos_hash(pos)
	if pos_hash then return self.chunks[pos_hash] end
end

function Map:get_chunk_and_block_pos(pos)
	local chunk_pos, block_pos = Map.get_chunk_pos_and_block_pos(pos)
	local chunk = self:get_chunk(chunk_pos)
	return chunk, block_pos
end

return Map
