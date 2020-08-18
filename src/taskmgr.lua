Dragonblocks.tasks = {}

function Dragonblocks:add_task(f)
	local t = coroutine.create(f)
	table.insert(self.tasks, t)
	return t
end

function Dragonblocks:step()
	local t_start = socket.gettime()
	local tasks = self.tasks
	self.tasks = {}
	for _, t in ipairs(tasks) do
		if coroutine.status(t) ~= "dead" and coroutine.resume(t) then
			table.insert(self.tasks, t)
		end
	end
	self.tps = 1 / (socket.gettime() - t_start)
end

function Dragonblocks:start_tasks()
	repeat self:step()
	until #self.tasks == 0
end
