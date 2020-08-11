RenderEngine.listen_keys = {}
Dragonblocks.create_event_interface(RenderEngine)

function RenderEngine:process_input(dtime)
	self:process_key_input(dtime)
	self:process_mouse_input(dtime)
end

function RenderEngine:process_key_input(dtime)
	local keys_pressed = {}
	local was_key_pressed = false
	for key in pairs(self.listen_keys) do
		if glfw.get_key(self.window, key) == "press" then
			keys_pressed[key] = true
			was_key_pressed = true
		end
	end
	if was_key_pressed then
		self:fire_event({
			type = "keypress",
			keys = keys_pressed,
			dtime = dtime
		})
	end
end

function RenderEngine:process_mouse_input(dtime)
	local dx, dy = self.cursor_delta_x or 0, self.cursor_delta_y or 0
	if math.abs(dx) > 0 or math.abs(dy) > 0 then
		self:fire_event({
			type = "mousemove",
			dtime = dtime,
			x = dx * self.mouse_sensitivity,
			y = dy * self.mouse_sensitivity,
		})		
	end
	self.cursor_delta_x, self.cursor_delta_y = 0, 0
end

function RenderEngine:add_listen_key(key)
	self.listen_keys[key] = true
end

function RenderEngine:remove_listen_key(key)
	self.listen_keys[key] = nil
end
