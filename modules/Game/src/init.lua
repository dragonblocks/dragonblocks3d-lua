local ressource_path = Game:get_path() .. "/ressources/"

BlockSystem:register_block({
	name = "game:stone",
	texture_path = ressource_path .. "stone.png",
})

BlockSystem:register_block({
	name = "game:dirt",
	texture_path = ressource_path .. "dirt.png",
})
