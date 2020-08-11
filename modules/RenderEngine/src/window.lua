function RenderEngine:framebuffer_size_callback(_, width, height)
	gl.viewport(0, 0, width, height)
	self:update_window_size(width, height)
end

function RenderEngine:init_glfw()
	glfw.window_hint("context version major", 3)
	glfw.window_hint("context version minor", 3)
	glfw.window_hint("opengl profile", "core")
end

function RenderEngine:create_window()
	self.window = glfw.create_window(500, 500, "Unnamed Window")
	glfw.make_context_current(self.window)
	self:update_window_size()
	glfw.set_framebuffer_size_callback(self.window, function (...) self:framebuffer_size_callback(...) end)	
end

function RenderEngine:set_window_title(title)
	glfw.set_window_title(self.window, title)
end

function RenderEngine:set_window_pos(x, y)
	glfw.set_window_pos(self.window, x, y)
end

function RenderEngine:set_window_size(width, height)
	glfw.set_window_size(self.window, width, height)
	self:update_window_size(width, height)
end

function RenderEngine:update_window_size(width, height)
	self.window_width, self.window_height = width, height
end
