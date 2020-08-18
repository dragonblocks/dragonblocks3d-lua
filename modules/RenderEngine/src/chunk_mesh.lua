local ChunkMesh = Dragonblocks.create_class()
table.assign(ChunkMesh, RenderEngine.Mesh)

function ChunkMesh:create_faces(blocks)
	self.vertices = {}
	self.textures = {}
	self.vertex_blob_size = 6
	local face_orientations = {
		glm.vec3( 0,  0, -1),
		glm.vec3( 0,  0,  1),
		glm.vec3(-1,  0,  0),
		glm.vec3( 1,  0,  0),
		glm.vec3( 0, -1,  0),
		glm.vec3( 0,  1,  0),
	}
	local bc = 0
	for _, block in pairs(blocks) do
		for i, dir in ipairs(face_orientations) do
			local pos = block.pos
			local dir_pos_hash = WorldSystem.Chunk.get_pos_hash(pos + dir)
			if not dir_pos_hash or not blocks[dir_pos_hash] then
				table.insert(self.textures, block.def.texture)
				self:add_face(block.pos - glm.vec3(7.5, 7.5, 7.5), i)
			end
		end
		bc = bc + 1
		if bc == 64 then
			bc = 0
			coroutine.yield()
		end
	end
	self:apply_vertices(self.vertices)
end

function ChunkMesh:add_face(pos, facenr)
	local cube_vertices = RenderEngine.cube_vertices
	local pos_modifier = {pos.x, pos.y, pos.z}
	local offset = (facenr - 1) * 6
	for vertex_index = offset, offset + 5 do
		for attribute_index = 1, 5 do	
			local k = vertex_index * 5 + attribute_index
			local v = cube_vertices[k]
			if attribute_index <= 3 then
				v = v + pos_modifier[attribute_index]
			end
			table.insert(self.vertices, v)
		end
	end
end

return ChunkMesh
