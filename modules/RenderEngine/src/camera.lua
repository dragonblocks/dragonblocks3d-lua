local camera = {
	pos = glm.vec3(0, 0, 0),
	up = glm.vec3(0, 1, 0),
	world_up = glm.vec3(0, 1, 0),
	front = glm.vec3(0, 0, -1),
}

function camera:get_view_matrix()
	return glm.look_at(self.pos, self.pos + self.front, self.up)
end

function camera:update(yaw, pitch)
	yaw, pitch = math.rad(yaw), math.rad(glm.clamp(pitch, -89.0, 89.0))
	self.front = glm.vec3(math.cos(yaw)*math.cos(pitch), math.sin(pitch), math.sin(yaw)*math.cos(pitch)):normalize()
	--self.front = glm.vec3(math.cos(yaw), math.sin(pitch), math.sin(yaw)):normalize()
	self.right = (self.front % self.world_up):normalize()
	self.up = (self.right % self.front):normalize()
end

return camera
