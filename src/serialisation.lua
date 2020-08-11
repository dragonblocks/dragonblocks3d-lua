function Dragonblocks:serialize()
	local data = "{"
	for k, v in pairs(self) do
		local kdata, vdata
		local ktype, vtype = type(k), type(v)
		local serialize_pair = true
		if ktype == "number" then
			kdata = "[" .. k .. "]"
		elseif ktype == "string" then
			if k:sub(1, 1) == "_" then
				serialize_pair = false
			else
				kdata = "[\"" .. k .. "\"]"
			end
		else
			serialize_pair = false
		end
		if vtype == "table" then
			vdata = serializer.serialize(v)
		elseif vtype == "string" then
			vdata = "\"" .. v .. "\""
		elseif vtype == "number" then
			vdata = v
		elseif vtype == "boolean" then
			vdata = v and "true" or "false"
		else
			serialize_pair = false
		end
		if serialize_pair then
			data = data .. kdata .. "=" .. vdata .. ","
		end
	end
	return data .. "}"
end

function Dragonblocks:deserialize(raw)
	if not raw then
		raw = self
		self = {}
	end
	raw = "return" .. raw
	local f = loadstring(raw)
	local data = f and f()
	if type(data) == "table" then
		table.assign(self, raw)
	end
	return self
end
