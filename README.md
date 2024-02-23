
# LuaCAM
Use Lua to generate G-Codes.
Provides GUI and minimal geometry kernel in C.

## TODO
1. [ ] create geometry kernel
2. [ ] create GUI
3. [ ] create lua C API
4. [ ] flesh out lua CAM lib


## GUI Features
- first class support for [LinuxCNC](https://linuxcnc.org/docs/html/gcode/)
- workspaces for Toolpath, Tool, and Machine
- builtin machine configurator
- Toolpath workspace directly tests the output GCodes


## File Formats
- "*.machinespec" = defines a machine for luaCAM

