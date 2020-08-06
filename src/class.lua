local class = {}

local instance_metatable = {
	__index = function(t, k)
		if k == "_call" then return end
		local f = rawget(t._class, k)
		if type(f) == "function" then
			return f
		end
	end
}

function class:_call(...)
	local o = {class = self}
	setmetatable(o, instance_metatable)
	if o.constructor then
		o:constructor(table.unpack(...))
	end
end 

return class
