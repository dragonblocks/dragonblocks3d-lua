local module_ref = {}

function module_ref:preinit()
	self._dependencies = {}
	self._started = false
	local depfile = io.open(self._path .. "/.txt")
	if depfile then
		local data = depfile:read()
		depfile:close()
		self._dependencies = data:split("\n")
	end
end

function module_ref:init()
	self._started = true
end

function module_ref:start()
	_G[self._name] = self
	require(self._path .. "src/init")
end

local module_manager = {}

module_manager.module_path = "modules/"

function module_manager:init()
	self._modules = {}
	for modulename in lfs.dir(self.module_path) do
		if modulename:sub(1, 1) ~= "." then
			local m = ObjectMgr.create()
			m._name = modulename
			m._path = self.module_path .. modulename .. "/"
			m:add_proto(module_ref)
			m:preinit()
			self._modules[modulename] = m
		end
	end
end

function module_manager:start_module(name)
	local m = self._modules[name]
	if not m then
		error("Failed to start module '" .. name .. "'.")
	elseif m._started then
		return
	end
	for _, dep in ipairs(m._dependencies) do
		self:start_module(dep)
	end
	m:start()
end

return module_manager
