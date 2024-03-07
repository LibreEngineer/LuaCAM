local M={}
-- toolpath movement are represented with cam.geometry.path()
-- milling toolpaths are broken down into 6 types or sections,
-- radial, ramp, plunge, position, linear_rapid, & rapid
-- NOTE: things like slotmills set plunge and ramp to 0 for safety
-- these toolpath types are broken down into multiple primitives (must be directly supported by the machine's gcode)
-- primitives: linear, arc, cubic spline, quadratic spline, NURBS

return M
