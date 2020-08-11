function RenderEngine:framebuffer_size_callback(_, width, height)
	gl.viewport(0, 0, width, height)
	self.window_width, self.window_height = width, height
	self:update_projection_matrix()
end

function RenderEngine:cursor_pos_callback(_, x, y)
	local last_x, last_y = self.cursor_x or x, self.cursor_y or y
	self.cursor_delta_x, self.cursor_delta_y = x - last_x, y - last_y
	self.cursor_x, self.cursor_y = x, y
end

function RenderEngine:init_glfw()
	glfw.window_hint("context version major", 3)
	glfw.window_hint("context version minor", 3)
	glfw.window_hint("opengl profile", "core")
end

function RenderEngine:create_window()
	self.window = glfw.create_window(500, 500, "Unnamed Window")
	glfw.make_context_current(self.window)
	glfw.set_input_mode(self.window, "cursor", "disabled")
	glfw.set_framebuffer_size_callback(self.window, function (...) self:framebuffer_size_callback(...) end)	
	glfw.set_cursor_pos_callback(self.window, function (...) self:cursor_pos_callback(...) end)	
end

function RenderEngine:set_window_title(title)
	glfw.set_window_title(self.window, title)
end

function RenderEngine:set_window_pos(x, y)
	glfw.set_window_pos(self.window, x, y)
end

function RenderEngine:set_window_size(width, height)
	glfw.set_window_size(self.window, width, height)
end
