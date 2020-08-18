function Dragonblocks:create_class()
	local class = self or {}
	setmetatable(class, {
		__call = function(_, ...)
			local o = {}
			setmetatable(o, {__index = class})
			if o.constructor then
				o:constructor(...)
			end
			return o
		end
	})
	return class
end
