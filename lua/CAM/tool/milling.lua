local M={}

local mt_tool_types = {
  __call = function(tbl, separator)
    if separator == nil then
      separator = ", "
    end
    local str=nil
    for _,v in ipairs(tbl) do
      str = str..v..separator
    end
    return str
  end
}
M.tool_types = {
  -- millin'
  "endmill",-- radius and flat end mills
  "facemill",-- facemills and flycutters
  "engraver",-- engravers and chamfer mills
  "slotmill",-- for slotmills and slitting saws
  "threadmill",
  "formmill",-- uses geometry.path2d()
  -- drillin'
  "twistdrill",
  "spotdrill",
  "centerdrill",
  "tap",
}
setmetatable(M.tool_types, mt_tool_types)



return M
