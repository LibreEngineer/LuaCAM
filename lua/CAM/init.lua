local table = require('table')
local M={}

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

function M.log:err(str)
    table.insert(self, "ERROR: "..str)
    table.insert(M.log_idx['ERROR'], #M.log)
end

function M.log:warn(str)
    table.insert(self, "WARN: "..str)
    table.insert(M.log_idx['WARN'], #M.log)
end

-- writes log to file or returns it as a string
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

-- Units: {{{
local mt_unit = {
  __call = function(tbl, n, unit, unit_type)
    if tbl[unit] ~= unit_type then
      M.log:err("You didn't enter an acceptable unit tag.")
      return
    end
    return {n, unit}
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
  -- velocity = 3
  ["sfm"]=3,
  -- volume = 4
  ["cu_in"]=4,
  ["cu_ft"]=4,
  ["cu_cm"]=4,
  ["cu_mm"]=4,
  -- surface area = 5
  ["sq_in"]=5,
  ["sq_ft"]=5,
  ["sq_cm"]=5,
  ["sq_mm"]=5,
}
setmetatable(M.unit, mt_unit)
--}}}

return M
