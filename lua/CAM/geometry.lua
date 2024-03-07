local math = require('math')
local M={}-- interface with the C geometry kernel

-- converts spherical to cartesian
-- see: https://en.wikipedia.org/wiki/Spherical_coordinate_system
function M.spherical(r, theta, phi)
end

-- returns a surface object
function M.surface()
  print("this function returns a surface object")
end

-- returns a path object
function M.path()
  print("this function returns a path object")
end

-- returns a 2d path object
function M.path2d()
  print("this function returns a 2d path object")
end

return M
