local ObjectRef = {}

function ObjectRef:init()
	for _, p in ipairs(self._proto) do
		if p ~= ObjectRef and p.init then
			p.init(self)
		end
	end
end

function ObjectRef:add_proto(p)
	table.insert(self._proto, p)
end

ObjectMgr = {}

ObjectMgr.metatable = {
	__index = function(t, k)
		for _, p in ipairs(t._proto) do
			local v = p[k]
			if v then
				return v
			end
		end
	end,
	__call = function(t, ...)
		return t:_call()
	end,
	__tostring = function(t)
		return t.serialize and t:serialize() or "<not serializable>"
	end,
}

function ObjectMgr.create()
	local o = {}
	o._proto = {ObjectRef}
	setmetatable(o, ObjectMgr.metatable)
	return o
end
