local graphics = {}

function graphics:init()
	RenderEngine:init()
	
	RenderEngine.bininear_filter = false
	RenderEngine.mipmap = true
	RenderEngine.mouse_sensitivity = 0.7
	RenderEngine.pitch_move = false
	RenderEngine.mesh_effect_grow_time = 0.25
	RenderEngine.mesh_effect_flyin_time = 0.25
	RenderEngine.mesh_effect_flyin_offset = 10
	RenderEngine.mesh_effect_rotate_speed = 1
	
	RenderEngine:set_wireframe(false)

	RenderEngine:set_window_title("Dragonblocks 3D")
	RenderEngine:set_window_size(1250, 750)
	RenderEngine:set_window_pos(50, 50)
	
	RenderEngine:set_sky("#87CEEB")
	
	RenderEngine:toggle_fullscreen()
	
	BlockSystem:init_textures()
end

return graphics
