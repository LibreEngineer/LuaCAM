#!/usr/bin/env lua
local cam = require('CAM')
local unit = cam.unit
print(_LOADED)
cam.log("hello world")

-- the geometric primitives
-- used for suplemental geometry and to represent toolpaths
cam.geometry.surface()
cam.geometry.path()
cam.geometry.path2d()

print(unit(1, 'in'))

cam.log("goodbye")
cam.dump_log()
