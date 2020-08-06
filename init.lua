#! /usr/bin/env lua
lfs = require("lfs")
socket = require("socket")
lsqlite3 = require("lsqlite3")
gl = require("moongl")
glfw = require("moonglfw")
require("util/objectmgr")
require("util/split")
require("util/indexof")

Dragonblocks = ObjectMgr.create()

require("src/init")

Dragonblocks:init()

Dragonblocks:start_module(arg[1])

Dragonblocks:start_tasks()
