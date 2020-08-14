local ressource_path = Game:get_path() .. "/ressources"

BlockSystem:register_block({
	name = "game:stone",
	texture_path = ressource_path .. "/stone.png",
})

BlockSystem:register_block({
	name = "game:dirt",
	texture_path = ressource_path .. "/dirt.png",
})

BlockSystem:register_block({
	name = "game:grass",
	texture_path = ressource_path .. "/grass.png",
})

BlockSystem:register_block({
	name = "game:tree",
	texture_path = ressource_path .. "/tree.png",
})

BlockSystem:register_block({
	name = "game:leaves",
	texture_path = ressource_path .. "/leaves.png",
})
