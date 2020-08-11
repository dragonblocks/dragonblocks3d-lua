function RenderEngine:init_texture_args()
	local base_filter = (self.bilinear_filter and "linear" or "nearest")
	local mipmap = (self.mipmap and " mipmap nearest" or "")
	self.texture_min_filter = base_filter .. mipmap
	self.texture_mag_filter = base_filter
end

function RenderEngine:create_texture(path)
	local texture = gl.gen_textures(1)

	gl.bind_texture("2d", texture)
	gl.texture_parameter("2d", "min filter", self.texture_min_filter)
	gl.texture_parameter("2d", "mag filter", self.texture_mag_filter)
	gl.texture_parameter("2d", "wrap s", "repeat")
	gl.texture_parameter("2d", "wrap t", "repeat")
	
	local data, width, height, channels = image.load(path)
	
	if not data then
		error("Failed to load texture '" .. path .. "'")
	end
	
	gl.texture_image("2d", 0, "rgb", "rgba", "ubyte", data, width, height)
	if self.mipmap then
		gl.generate_mipmap("2d")
	end
	
	gl.unbind_texture("2d")
	data, width, height, channels = nil
	
	return texture
end
