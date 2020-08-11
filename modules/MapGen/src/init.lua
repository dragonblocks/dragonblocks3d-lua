local stone = BlockSystem:get_def("game:stone")
local dirt = BlockSystem:get_def("game:dirt")

local air_probability = 2
local random_blocks = {stone, dirt}
local random_blocks_num = #random_blocks + air_probability

function MapGen:generate(chunk)
	for x = 0, 15 do
		for y = 0, 15 do
			for z = 0, 15 do
				local block = random_blocks[math.random(random_blocks_num)]
				if block then
					chunk:add_block(glm.vec3(x, y, z), block)
				end
			end
		end
	end
end
