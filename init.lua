#! /usr/bin/env lua
lfs = require("lfs")
socket = require("socket")
lsqlite3 = require("lsqlite3")
gl = require("moongl")
glfw = require("moonglfw")
image = require("moonimage")
glm = require("moonglmath")
string.split = require("util/string_split")
table.indexof = require("util/table_indexof")
table.assign = require("util/table_assign")
hex2rgb = require("util/hex2rgb")

require("src/init")

