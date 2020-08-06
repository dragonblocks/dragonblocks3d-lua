function table.indexof(list, val)
	for i, v in ipairs(list) do
		if v == val then
			return i
		end
	end
	return -1
end 
