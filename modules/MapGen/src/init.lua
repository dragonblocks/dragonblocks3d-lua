local stone = BlockSystem:get_def("game:stone")
local dirt = BlockSystem:get_def("game:dirt")
local grass = BlockSystem:get_def("game:grass")
local leaves = BlockSystem:get_def("game:leaves")
local tree = BlockSystem:get_def("game:tree")

math.randomseed(os.time())

function MapGen:generate(chunk)
	local grass_layer_table, old_grass_layer_table
	local grass_layer
	for x = 0, 15 do
		grass_layer_table, old_grass_layer_table = {}, grass_layer_table
		grass_layer = old_grass_layer_table and old_grass_layer_table[1] or 8 + math.random(5)
		for z = 0, 15 do
			local old_grass_layer = old_grass_layer_table and old_grass_layer_table[z] or grass_layer
			grass_layer = math.floor((grass_layer + old_grass_layer) / 2)
			if math.random(3) == 1 then
				grass_layer = grass_layer + math.random(3) - 2
			end
			grass_layer = glm.clamp(grass_layer, 0, 15)
			grass_layer_table[z] = grass_layer
			if math.random(25) == 1 then
				chunk:add_block(glm.vec3(x, grass_layer, z), dirt)
				self:add_tree(chunk, glm.vec3(x, grass_layer + 1, z))
			else
				chunk:add_block(glm.vec3(x, grass_layer, z), grass)
			end
			local dirt_start, dirt_end = grass_layer - 1, math.max(grass_layer - 5, 0)
			local stone_start, stone_end = grass_layer - 6, 0
			if dirt_start >= 0 then
				for y = dirt_start, dirt_end, -1  do
					chunk:add_block(glm.vec3(x, y, z), dirt)
				end
			end
			if stone_start >= 0 then
				for y = stone_start, stone_end, -1  do
					chunk:add_block(glm.vec3(x, y, z), stone)
				end
			end
		end
	end
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
