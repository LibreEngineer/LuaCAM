
-- Info about material to calculate things like cutting force (https://www.machiningdoctor.com/glossary/specific-cutting-force-kc-kc1/)
local M={
}
setmetatable(M, {
  __call = function(tbl, args)
    print(tbl)
    print(args)
  end
})

return M
