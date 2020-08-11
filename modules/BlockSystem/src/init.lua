BlockSystem.blocks = {}

function BlockSystem:register_block(def)
	local id = table.insert(self.blocks, def)
	def.id = id
	self.blocks[def.name] = def
end

function BlockSystem:get_def(key)
	return self.blocks[key]
end

function BlockSystem:init_textures()
	RenderEngine:init_texture_args()
	for _, def in ipairs(self.blocks) do
		def.texture = RenderEngine:create_texture(def.texture_path)
	end
end
