RenderEngine:run("inputhandler")
RenderEngine:run("shaders")
RenderEngine:run("textures")
RenderEngine:run("window")

RenderEngine.cube_vertices = RenderEngine:run("cube_vertices")
RenderEngine.Mesh = RenderEngine:run("mesh")
RenderEngine.ChunkMesh = RenderEngine:run("chunk_mesh")
RenderEngine.camera = RenderEngine:run("camera")

function RenderEngine:init()
	self:init_glfw()
	self:create_window()
	self:init_glew()
	self:load_shaders()
	self:set_sky("#FFFFFF")
	self:add_render_task()
end

function RenderEngine:init_glew()
	gl.init()
end

function RenderEngine:add_render_task()
	Dragonblocks:add_task(function()
		self:render_loop()
	end)
end

function RenderEngine:render_loop(is_only_task)
	self.last_time = glfw.get_time()
	repeat
		self:render()
		if not is_only_task then
			coroutine.yield()
		end
	until glfw.window_should_close(self.window)
	os.exit()
end

function RenderEngine:update_projection_matrix()
	gl.uniform_matrix4f(gl.get_uniform_location(self.shaders, "projection"), true, glm.perspective(math.rad(self.fov), self.window_width / self.window_height, 0.01, 100))
end

function RenderEngine:update_view_matrix()
	gl.uniform_matrix4f(gl.get_uniform_location(self.shaders, "view"), true, self.camera:get_view_matrix())
end

function RenderEngine:render()
	local dtime = glfw.get_time() - self.last_time
	self.last_time = glfw.get_time()
	
	self:process_input(dtime)
	
	gl.clear_color(self.sky)
	gl.enable("depth test")
	gl.clear("color", "depth")
	
	gl.use_program(self.shaders)	
	
	self:update_view_matrix()
	
	for _, mesh in ipairs(self.Mesh.list) do
		mesh:render(dtime)
	end
	
	glfw.swap_buffers(self.window)
	glfw.poll_events()
end

function RenderEngine:set_sky(htmlcolor)
	local r, g, b = hex2rgb(htmlcolor)
	self.sky = {r, g, b, 1.0}
end

function RenderEngine:set_wireframe(v)
	gl.polygon_mode("front and back", (v and "line" or "fill"))
end

function RenderEngine:toggle_fullscreen()
	self.fullscreen = not self.fullscreen
	local monitor = glfw.get_primary_monitor()
	local mode = glfw.get_video_mode(monitor)
	glfw.set_window_monitor(self.window, self.fullscreen and monitor, 0, 0, mode.width, mode.height, 0)
end
