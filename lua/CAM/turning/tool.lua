local M={}
-- generic milling tool
-- accounts for tool and holder
M.tool = {
  capability="milling",
  type="",-- the tool methods will set this
  -- see: '../init.lua'
  unit="",-- if left blank, will use CAM_DEFAULT_UNITS table
  desc = {
    title="",-- ex: "6-32UNC Threadmill"
    url="",
    vendor="",
    uuid=0,
    notes="",-- any extra information
  },
  -- the used offsets will change depending on machine settings
  geometry = {
    -- these values will work on any milling tool
    gauge_len=0,-- only used if not set in machine
    stickout=0,
    flutes=0,
    flute_len=0,--
    flute_diam=0,-- the effective cutting diameter
    shank_diam=0,
    -- describes the general bounds of the holder
    -- values should be larger than the actual holder to account for margin of error
    holder = {
      -- defines a cylinder with a chamfer on the bottom face
      length=0,
      major_diameter=0,
      minor_diameter=0,
      taper=0,-- taper from minor diameter
    }
  },
  -- parameters to send to the toolpath
  tp_params = {
    -- [1]=min_rpm, [2]=max_rpm
    rpm={0,0},
    chipload=0,
    -- the feeds for different types of cutting moves
    -- non-cutting feeds are set in the toolpath
    feed = {
      radial=0,
      ramp=0,
      plunge=0,
    },
  },
}
M.tool_types = {
  -- millin'
  "endmill",-- radius and flat end mills
  "facemill",-- facemills and flycutters
  "engraver",-- engravers and chamfer mills
  "slotmill",-- for slotmills and slitting saws
  "threadmill",-- both single and multi-flute threadmills
  "formmill",-- uses geometry.path2d()
  -- drillin'
  "twistdrill",
  "spotdrill",
  "centerdrill",
  "tap",
}

function M.endmill()--{{{
end--}}}

return M
