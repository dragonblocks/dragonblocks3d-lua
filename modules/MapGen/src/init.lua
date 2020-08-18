local stone = BlockSystem:get_def("game:stone")
local dirt = BlockSystem:get_def("game:dirt")
local grass = BlockSystem:get_def("game:grass")
local leaves = BlockSystem:get_def("game:leaves")
local tree = BlockSystem:get_def("game:tree")

local grass_layer_start, grass_layer_end = 0, 30
local grass_layer_height = grass_layer_end - grass_layer_start

function MapGen.generate(minp, maxp)
	local data = {}
	local minx, miny, minz, maxx, maxy, maxz = minp.x, minp.y, minp.z, maxp.x - 1, maxp.y - 1, maxp.z - 1
	for x = minx, maxx do
		for z = minz, maxz do
			local grass_layer = math.floor(grass_layer_start + grass_layer_height * perlin:noise(x / grass_layer_height, z / grass_layer_height))
			for y = miny, maxy do
				local pos = glm.vec3(x - minx, y - miny, z - minz)
				local block
				if y <= grass_layer - 5 then
					block = stone
				elseif y <= grass_layer - 1 then
					block = dirt
				elseif y <= grass_layer then
					block = grass
				end 
				if block then
					data[WorldSystem.Chunk.get_pos_hash(pos)] = WorldSystem.Block(pos, block)
				end
			end
		end
	end
	return data
end

local tree_blocks = {
	glm.vec3( 0,  0,  0),
	glm.vec3( 0,  1,  0),
	glm.vec3(-1,  2, -1),
	glm.vec3(-1,  2,  0),
	glm.vec3(-1,  2,  1),
	glm.vec3( 0,  2, -1),
	glm.vec3( 0,  2,  0),
	glm.vec3( 0,  2,  1),
	glm.vec3( 1,  2, -1),
	glm.vec3( 1,  2,  0),
	glm.vec3( 1,  2,  1),
	glm.vec3(-1,  3, -1),
	glm.vec3(-1,  3,  0),
	glm.vec3(-1,  3,  1),
	glm.vec3( 0,  3, -1),
	glm.vec3( 0,  3,  0),
	glm.vec3( 0,  3,  1),
	glm.vec3( 1,  3, -1),
	glm.vec3( 1,  3,  0),
	glm.vec3( 1,  3,  1),
	glm.vec3(-1,  4, -1),
	glm.vec3(-1,  4,  0),
	glm.vec3(-1,  4,  1),
	glm.vec3( 0,  4, -1),
	glm.vec3( 0,  4,  0),
	glm.vec3( 0,  4,  1),
	glm.vec3( 1,  4, -1),
	glm.vec3( 1,  4,  0),
	glm.vec3( 1,  4,  1),
}

function MapGen:add_tree(chunk, tree_pos)
	for i, p in ipairs(tree_blocks) do
		local block = leaves
		if i < 3 then
			block = tree
		end
		local pos = tree_pos + p
		if chunk:get_pos_hash(pos) then
			chunk:add_block(pos, block)
		end
	end
end
