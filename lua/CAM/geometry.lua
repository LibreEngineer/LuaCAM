local M={}-- interface to the C geometry kernel

-- Coord: {{{
-- provide methods for managing coordinates
M.coord = {
}
--}}}

-- Surface: {{{
-- the building blocks of geometry.brep
M.surface = {
}
--}}}

-- Path: {{{
M.path = {
}
setmetatable(M.path, {
  __call = function()
    print("this function returns a path object")
  end
})
-- ensures the path is 2d
function M.path:flatten()
end
--}}}

-- Brep: {{{
M.brep = {
}
setmetatable(M.brep, {
  -- initializes a brep object
  __call = function()
  end
})
--}}}

-- File Imports: {{{
local string = require('string')

function M.import_dxf(file)
  print(string.format("imported dxf file: '%s'", file))
end

function M.import_svg(file)
  print(string.format("imported svg file: '%s'", file))
end

function M.import_path(file)
  print(string.format("imported path file: '%s'", file))
end

function M.import_brep(file)
  print(string.format("imported brep file: '%s'", file))
end

function M.import_step(file)
  print(string.format("imported step file: '%s'", file))
end
-- }}}

return M
