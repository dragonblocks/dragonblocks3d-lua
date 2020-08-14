local graphics = {}

function graphics:init()
	RenderEngine:init()
	
	RenderEngine.bininear_filter = false
	RenderEngine.mipmap = false
	RenderEngine.mouse_sensitivity = 0.7
	--RenderEngine.pitch_move = true
	RenderEngine.mesh_effect_grow_time = 0.25
	RenderEngine.mesh_effect_flyin_time = 0.5
	RenderEngine.mesh_effect_flyin_offset = 20
	RenderEngine.mesh_effect_rotate_speed = 1
	
	RenderEngine:set_wireframe(false)

	RenderEngine:set_window_title("Dragonblocks 3D")
	RenderEngine:set_window_size(1250, 750)
	RenderEngine:set_window_pos(50, 50)
	
	RenderEngine:set_sky("#87CEEB")
	
	BlockSystem:init_textures()
end

function graphics:create_chunk_meshes(chunk)
	local mesh = RenderEngine.ChunkMesh()
	mesh:set_pos(glm.vec3(0, 0, 0))
	mesh:set_size(glm.vec3(1, 1, 1))
	mesh:set_texture(BlockSystem:get_def("game:dirt").texture)
	mesh:create_vertices(chunk)
	mesh:set_effect(RenderEngine.Mesh.EFFECT_FLYIN)
	mesh:add_to_scene()
end

return graphics
