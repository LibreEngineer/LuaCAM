local M={}-- defines some intrinsic LuaCAM systems
local table = require('table')-- lua table library

-- Globals: {{{
-- LuaCAM relies on these values being set in the global environment
CAM_DEFAULT_UNITS = {
  length="mm",
  angle="deg",
  speed="",
  torque="",
  volume="",
  surface_area="",
}
-- }}}

-- Units: {{{
-- all inputs that require a unit to be known will either use this system,
-- or check for a unit field/key in the root of the parent object (i.e. cam.tool)
local mt_unit = {
  __call = function(tbl, value, unit)
    if tbl[unit] == nil then
      M.log:err("You didn't enter an acceptable unit tag.")
      return
    end
    return {value, unit}
  end
}
-- unit tags
M.unit = {
  -- length = 1
  ["in"]=1,
  ["ft"]=1,
  ["m"]=1,
  ["cm"]=1,
  ["mm"]=1,
  -- angle = 2
  ["deg"]=2,
  ["rad"]=2,
  -- rotational speed = 3
  ["rpm"]=3,
  -- surface speed = 4
  ["sfm"]=3,
  -- feedrate = 4
  ["ipm"]=4,
  ["ipr"]=4,
  ["mmpr"]=4,
  -- torque = 5
  -- surface area = 7
  ["sq_in"]=5,
  ["sq_ft"]=5,
  ["sq_m"]=5,
  ["sq_cm"]=5,
  ["sq_mm"]=5,
  -- volume = 6
  ["cu_in"]=4,
  ["cu_ft"]=4,
  ["cu_m"]=4,
  ["cu_cm"]=4,
  ["cu_mm"]=4,

  -- Methods: {{{
  -- converts Degree Minute Second to "deg"
  -- fmt: [[%d'%d"%d]]
  dms = function(dms_str)
    local _, _, d, m, s = string.find(dms_str, [[(%d)'(%d)"(%d)]])
    return (d + m/60 + s/(60^2))
  end
  --}}}
}
setmetatable(M.unit, mt_unit)
--}}}

-- Logging: {{{
-- track indices of the 3 different log types (std, warn, error)
M.log_idx = {
  ['STD'] = {},
  ['WARN'] = {},
  ['ERROR'] = {},
}

local mt_log = {
  -- just like printing to stdout
  __call = function(tbl, str)
    table.insert(tbl, str)
    table.insert(M.log_idx['STD'], #M.log)
  end
}
-- sequential array of all logs
M.log = {
}
setmetatable(M.log, mt_log)

-- log error
function M.log:err(str)
    table.insert(self, "ERROR: "..str)
    table.insert(M.log_idx['ERROR'], #M.log)
end

-- log warning
function M.log:warn(str)
    table.insert(self, "WARN: "..str)
    table.insert(M.log_idx['WARN'], #M.log)
end

-- writes log to file or returns it as a string if no file was given
function M.dump_log(file)
  local log_str = ""
  for _,v in ipairs(M.log) do
    log_str = log_str .. v .. "\n"
  end
  if file then
    local fp = io.open(file, 'w')
    io.write(log_str)
    io.close(fp)
  else
    return log_str
  end
end
--}}}

return M
