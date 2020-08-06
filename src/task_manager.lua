local task_manager = {}

function task_manager:init()
	self._tasks = {}
end

function task_manager:add_task(f)
	local t = coroutine.create(f)
	table.insert(self._tasks, t)
	return t
end

function task_manager:step()
	local t_start = socket.gettime()
	local tasks = self._tasks
	self._tasks = {}
	for _, t in ipairs(tasks) do
		if coroutine.resume(t) then
			table.insert(self._tasks, t)
		end
	end
	self.tps = 1 / (socket.gettime() - t_start)
end

function task_manager:start_tasks()
	repeat self:step()
	until #self._tasks == 0
end

function task_manager:register_event_interface(e)
	e._task_manager = self
end

return task_manager
