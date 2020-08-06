local module_ref = {}

function module_ref:preinit()
	self._dependencies = {}
	self._started = false
	local depfile = io.open(self._path .. "/dependencies.txt")
	if depfile then
		local data = depfile:read()
		depfile:close()
		self._dependencies = data:split("\n")
	end
	
end

function module_ref:init()
	self._started = true
end

function module_ref:run_script(s)
	return require(self._path .. "src/" .. s)
end

function module_ref:start()
	_G[self._name] = self
	self:run_script("init")
	print("Started module " .. self._name)
end

function module_ref:get_path()
	return self._path
end

function module_ref:get_data_path()
	local p = self._data_path
	if not lfs.attributes(p, "mode") then
		lfs.mkdir(p)
	end
end

local module_manager = {}

module_manager.module_path = "modules/"
module_manager.data_path = "data/"

function module_manager:init()
	if not lfs.attributes(self.data_path, "mode") then
		lfs.mkdir(self.data_path)
	end
	self._modules = {}
	for modulename in lfs.dir(self.module_path) do
		if modulename:sub(1, 1) ~= "." then
			local m = ObjectMgr.create()
			m._name = modulename
			m._path = self.module_path .. modulename .. "/"
			m._data_path = self.data_path .. modulename .. "/"
			m:add_proto(module_ref)
			m:preinit()
			self._modules[modulename] = m
		end
	end
end

function module_manager:start_module(name)
	local m = self._modules[name]
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
