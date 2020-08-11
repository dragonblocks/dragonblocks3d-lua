local ChunkMesh = Dragonblocks.create_class()
table.assign(ChunkMesh, RenderEngine.Mesh)

function ChunkMesh:create_vertices(chunk)
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
	for _, block in pairs(chunk.blocks) do
		for i, dir in ipairs(face_orientations) do
			local pos = block.pos
			if not chunk:get_block(pos + dir) then
				table.insert(self.textures, block.def.texture)
				self:add_face(block.pos, i)
			end
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
