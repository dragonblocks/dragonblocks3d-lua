local camera = {
	pos = glm.vec3(0, 0, 0),
	front = glm.vec3(1, 0, 0),
	up = glm.vec3(0, 1, 0),
}

function camera:get_view_matrix()
	return glm.look_at(self.pos, self.pos + self.front, self.up)
end

return camera
