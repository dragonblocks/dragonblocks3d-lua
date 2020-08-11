function RenderEngine:load_shaders()
	local path = self:get_path() .. "/shaders/"
	local program, vsh, fsh = gl.make_program({vertex = path .. "vertex.glsl", fragment = path .. "fragment.glsl"})
	gl.delete_shaders(vsh, fs)
	self.shaders = program
	
	self.view_matix_location = gl.get_uniform_location(self.shaders, "view")
	self.projection_matix_location = gl.get_uniform_location(self.shaders, "projection")
end
