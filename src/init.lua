Dragonblocks.event_interface = require("src/event_interface")
Dragonblocks.class = require("src/class")
Dragonblocks.task_manager = require("src/task_manager")
Dragonblocks.module_manager = require("src/module_manager")
Dragonblocks.serializer = require("src/serializer")

Dragonblocks:add_proto(Dragonblocks.module_manager)
Dragonblocks:add_proto(Dragonblocks.task_manager)
Dragonblocks:add_proto(Dragonblocks.serializer)

Dragonblocks:register_event_interface(Dragonblocks)

print("Started Dragonblocks core")
