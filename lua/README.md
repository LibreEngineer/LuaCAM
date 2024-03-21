
# LuaCAM
This is the Lua library for LuaCAM.

## Design
- Lua files at the root of 'CAM/', define all the common functions and structures.
- All subdirectories of 'CAM/' are used to define machine-specific algorithms and uses.
- In LuaCAM toolpaths are based on the tool and not the the machine type.
- The post processor step is integrated into the machine construct/object, whatever the hell you want to call it.
