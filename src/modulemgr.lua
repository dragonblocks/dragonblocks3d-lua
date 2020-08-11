local Module = Dragonblocks.create_class()

function Module:constructor(name)
	self._name = name
	self._dependencies = {}
	self._started = false
	local depfile = io.open(self:get_path() .. "/dependencies.txt")
	if depfile then
		local data = depfile:read("*a")
		depfile:close()
		self._dependencies = data:split("\n")
	end
end

function Module:run(s)
	return require(self:get_path() .. "/src/" .. s)
end

function Module:start()
	_G[self._name] = self
	self:run("init")
	self._started = true
	print("Started module " .. self._name)
end

function Module:get_path()
	return "modules/" .. self._name 
end

function Module:get_data_path()
	local p = "data/" .. self._name
	if not lfs.attributes(p, "mode") then
		lfs.mkdir(p)
	end
	return p
end

function Dragonblocks:read_modules()
	if not lfs.attributes("data", "mode") then
		lfs.mkdir(self.data_path)
	end
	self.modules = {}
	for modulename in lfs.dir("modules") do
		if modulename:sub(1, 1) ~= "." then
			local m = Module(modulename)
			self.modules[modulename] = m
		end
	end
end

function Dragonblocks:start_module(name)
	local m = self.modules[name]
	if not m then
		error("Module '" .. name .. "' not found.")
	elseif m._started then
		return
	end
	for _, dep in ipairs(m._dependencies) do
		self:start_module(dep)
	end
	m:start()
end

return module_manager
