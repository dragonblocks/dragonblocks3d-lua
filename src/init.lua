Dragonblocks = {}

require("src/class")
require("src/events")
require("src/taskmgr")
require("src/modulemgr")
require("src/serialisation")

print("Started Dragonblocks core")

Dragonblocks:read_modules()
Dragonblocks:start_module(arg[1])
Dragonblocks:start_tasks()
