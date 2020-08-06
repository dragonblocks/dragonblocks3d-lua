local event_interface = {}

function event_interface:init()
	self:clear_event_listeners()
end

function event_interface:fire_event(eventtype, event)
	event = event or {}
	event.type = eventtype
	event.origin = self
	local listeners = self._event_listeners[eventtype]
	if listeners then
		for _, listener in ipairs(listeners) do
			listener(event)
		end
	end
end

function event_interface:add_event_listener(eventtype, eventlistener)
	self._event_listeners[eventtype] = self._event_listeners[eventtype] or {}
	table.insert(self._event_listeners[eventtype], eventlistener)
end
	
function event_interface:remove_event_listener(eventtype, eventlistener)
	local listeners = self._event_listeners[eventtype]
	if listeners then
		for k, listener in ipairs(listeners) do
			if listener == eventlistener then
				table.remove(k)
				return self:removeEventListener(eventtype, eventlistener)
			end
		end
	end
end

function event_interface:clear_event_listeners()
	self._event_listeners = {}
end

return event_interface
