local events = {}

function events:fire_event(event, callback)
	event = event or {}
	event.origin = self
	local listeners = self.event_listeners[event.type]
	if listeners and #listeners > 0 then
		for _, listener in ipairs(listeners) do
			listener(event)
		end
	end
	if callback then
		callback(event)
	end
end

function events:add_event_listener(eventtype, eventlistener)
	self.event_listeners[eventtype] = self.event_listeners[eventtype] or {}
	table.insert(self.event_listeners[eventtype], eventlistener)
end
	
function events:remove_event_listener(eventtype, eventlistener)
	local listeners = self.event_listeners[eventtype]
	if listeners then
		for k, listener in ipairs(listeners) do
			if listener == eventlistener then
				table.remove(k)
				return self:removeEventListener(eventtype, eventlistener)
			end
		end
	end
end

function events:clear_event_listeners()
	self.event_listeners = {}
end

function Dragonblocks:create_event_interface()
	self = self or {}
	table.assign(self, events)
	self:clear_event_listeners()
	return self
end
