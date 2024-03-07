-- metatable for M
local mt_M={
  -- can only set capability once & only through this method (function)
  -- type can only be set/updated through methods
  __call = function(tbl, capability, type)
  end
}

-- the generic tool definition table
local M={
}
setmetatable(M, mt_M)

return M
