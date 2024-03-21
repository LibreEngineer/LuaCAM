
local M={
  capability="",
  type="",
  unit="",-- if left blank, will use CAM_DEFAULT_UNITS table
  desc = {
    title="",-- ex: "6-32UNC Threadmill"
    url="",
    vendor="",
    uuid=0,
    notes="",-- any extra information
  },
  geometry={},
  tp_params={},
}
setmetatable(M, {
  __call = function()
  end
})

return M
