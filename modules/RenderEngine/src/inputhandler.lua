RenderEngine.listen_keys = {}
Dragonblocks.create_event_interface(RenderEngine)

function RenderEngine:process_input(dtime)
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

function RenderEngine:add_listen_key(key)
	self.listen_keys[key] = true
end

function RenderEngine:remove_listen_key(key)
	self.listen_keys[key] = nil
end
