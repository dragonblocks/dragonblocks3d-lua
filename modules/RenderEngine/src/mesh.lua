local Mesh = Dragonblocks.create_class()

Mesh.EFFECT_GROW = 1
Mesh.EFFECT_FLYIN = 2
Mesh.EFFECT_ROTATE = 3
Mesh.list = {}

function Mesh:set_size(size)
	self.size = size
end

function Mesh:set_pos(pos)
	self.pos = pos
end

function Mesh:set_texture(texture)
	self.textures = {texture}
end

function Mesh:set_effect(effect, after)
	self.effect = effect
	self.effect_lasts =
		(effect == Mesh.EFFECT_GROW) and RenderEngine.mesh_effect_grow_time
		or
		(effect == Mesh.EFFECT_FLYIN) and RenderEngine.mesh_effect_flyin_time
	self.after_effect = after
end

function Mesh:add_to_scene()
	if self.effect then
		self.created = glfw.get_time()
	end
	table.insert(Mesh.list, self)
end

function Mesh:remove_from_scene()
	local i = table.indexof(Mesh.list, self)
	if i then
		table.remove(Mesh.list, i)
	end
end

function Mesh:apply_vertices(vertices)
	self.vertex_blob_count = #vertices / 5 / self.vertex_blob_size
	
	self.vao = gl.gen_vertex_arrays(1)
	self.vbo = gl.gen_buffers(1)
	
	gl.bind_vertex_array(self.vao)
	
	gl.bind_buffer("array", self.vbo)
	gl.buffer_data("array", gl.pack("float", vertices), "static draw")
	
	local fsize = gl.sizeof("float")
	
	local stride = 5 * fsize
	
	gl.vertex_attrib_pointer(0, 3, "float", false, stride, 0)
	gl.enable_vertex_attrib_array(0)
	gl.vertex_attrib_pointer(1, 2, "float", false, stride, 3 * fsize)	
	gl.enable_vertex_attrib_array(1)
	
	gl.unbind_buffer("array")
	gl.unbind_vertex_array()
	
	return vao
end

function Mesh:render(dtime)
	local pos, size = self.pos, self.size

	if self.effect then
		if self.effect_lasts then
			self.effect_lasts = self.effect_lasts - dtime
			if self.effect_lasts < 0 then
				if self.after_effect then
					self:after_effect()
				end
				self.effect = nil
				self.effect_lasts = nil
				self.after_effect = nil
				goto draw
			end
		end
		if self.effect == Mesh.EFFECT_GROW then
			size = size * math.pow(1 - self.effect_lasts / RenderEngine.mesh_effect_grow_time, 1)
		elseif self.effect == Mesh.EFFECT_FLYIN then
			pos = pos - glm.vec3(0, RenderEngine.mesh_effect_flyin_offset * self.effect_lasts / RenderEngine.mesh_effect_flyin_time, 0)
		end
	end
	
	::draw::
	
	local model_matrix = 1
		* glm.translate(pos)
		* glm.scale(size)
	
	gl.uniform_matrix4f(gl.get_uniform_location(RenderEngine.shaders, "model"), true, model_matrix)
	gl.active_texture(0)
	gl.bind_vertex_array(self.vao)
	for i = 1, self.vertex_blob_count do
		gl.bind_texture("2d", self.textures[i])
		gl.draw_arrays("triangles", (i - 1) * self.vertex_blob_size, self.vertex_blob_size)
	end
	gl.unbind_vertex_array()
	gl.unbind_texture("2d")
end

return Mesh
