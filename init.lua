#! /usr/bin/env lua
require("lfs")
require("socket")
require("lsqlite3")
require("moongl")
require("moonglfw")
require("util/objectmgr")
require("util/split")
require("util/indexof")

Dragonblocks = ObjectMgr.create()

require("src/init")

Dragonblocks:init()

Dragonblocks:start_module(arg[1] or "Menu")
