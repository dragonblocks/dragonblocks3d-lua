local graphics = {}

function graphics:init()
	RenderEngine:init()
	
	RenderEngine.bininear_filter = false
	RenderEngine.mipmap = false
	RenderEngine.mouse_sensitivity = 0.7
	--RenderEngine.pitch_move = true
	RenderEngine.mesh_effect_grow_time = 0.25
	RenderEngine.mesh_effect_flyin_time = 1
	RenderEngine.mesh_effect_flyin_offset = 20
	--RenderEngine.mesh_effect_rotate_speed = 
	
	RenderEngine:set_wireframe(false)

	RenderEngine:set_window_title("Dragonblocks 3D")
	RenderEngine:set_window_size(1250, 750)
	RenderEngine:set_window_pos(50, 50)
	
	RenderEngine:set_sky("#87CEEB")
	
	BlockSystem:init_textures()
end

function graphics:create_chunk_meshes(chunk)
	for _, block in pairs(chunk.blocks) do
		self:create_block_mesh(block, false)
	end
end

function graphics:create_block_mesh(block, grow)
	local mesh = RenderEngine.Mesh()
	mesh:set_pos(block.pos)
	mesh:set_size(glm.vec3(1, 1, 1))
	mesh:set_texture(block.def.texture)
	mesh:make_cube()
	if grow then
		mesh:set_effect(RenderEngine.Mesh.EFFECT_GROW)
	end
	mesh:add_to_scene()
end

return graphics
