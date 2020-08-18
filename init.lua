#! /usr/bin/env lua
lfs = require("lfs")
socket = require("socket")
lsqlite3 = require("lsqlite3")
gl = require("moongl")
glfw = require("moonglfw")
glm = require("moonglmath")
image = require("moonimage")
perlin = require("util/perlin")
string.split = require("util/string_split")
table.indexof = require("util/table_indexof")
table.assign = require("util/table_assign")
hex2rgb = require("util/hex2rgb")

require("src/init")

