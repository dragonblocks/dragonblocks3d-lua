glfw.window_hint("context version major", 3)
glfw.window_hint("context version minor", 3)
glfw.window_hint("opengl profile", "core")

function RenderEngine.reshape(_, width, height)
	gl.viewport(0, 0, width, height)
end

function RenderEngine:open_window()
	self.window = glfw.create_window(50, 50, "Unnamed Window")
	glfw.make_context_current(self.window)
	gl.init()
	glfw.set_framebuffer_size_callback(self.window, RenderEngine.reshape)
end

function RenderEngine:set_window_title(title)
	glfw.set_window_title(self.window, title)
end

function RenderEngine:render()
	glfw.poll_events()
	gl.clear_color(1.0, 0.5, 0.2, 1.0)
	gl.clear("color", "depth")
	glfw.swap_buffers(self.window)
	coroutine.yield()
end

function RenderEngine:render_loop()
	repeat RenderEngine:render()
	until glfw.window_should_close(self.window)
end

function RenderEngine:add_render_task()
	Dragonblocks:add_task(function() RenderEngine:render_loop() end)
end

RenderEngine:init()
