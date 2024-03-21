#!/bin/bash
local c = {
  target="shdrsrc.h",-- the path to the headerfile to generate
  comment="this is an auto generated headerfile to include the shaderfiles as strings",-- @ the top of the file
  search_recursively=true,
  ignore_shaders = { -- list of shaders not to search
    "",
  },
}


