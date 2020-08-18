local timeout = Dragonblocks.create_class()

timeout.list = {}

function timeout:constructor(sec, func, ...)
	self.exp, self.func, self.args = socket.gettime() + sec, func, table.pack(...)
	table.insert(timeout.list, self)
end

function timeout:clear()
	self.cleared = true
end

function Dragonblocks.set_timeout(sec, func, ...)
	return timeout(sec, func, ...)
end

function Dragonblocks:clear_timeout()
	self:clear()
end

Dragonblocks:add_task(function()
	while true do
		local tolist = timeout.list
		local tm = socket.gettime()
		timeout.list = {}
		for _, to in pairs(tolist) do
			if not to.cleared then
				if to.exp <= tm then
					to.func(table.unpack(to.args))
				else
					table.insert(timeout.list, to)
				end
			end
		end
		coroutine.yield()
	end
end)
