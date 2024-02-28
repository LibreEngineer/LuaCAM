
# LuaCAM
Use Lua to generate G-Codes.
Provides GUI and minimal geometry kernel in C.

## TODO
1. [ ] create geometry kernel in C API
2. [ ] create GUI
4. [ ] flesh out luaCAM lua lib
3. [ ] create lua C API


## Features
- First class support for [LinuxCNC](https://linuxcnc.org/docs/html/gcode/)
- Provides ensureUnit(val, unit) method for inputing units
- Custom G-Code comment formatting
- Extensive suite of testing software; Never break a machine again
- Machinespec file allows you to fully utilize your machines


## GUI
Here's a quick overview of the provided GUI.

### Features
- Workspaces for Toolpath, Tool, and Machine
- Builtin machine configurator
- Toolpath workspace directly tests and validates the output GCodes for a machine
- Machine simulation accurately simulates feedrate of machine


## File Formats
- "*.machinespec" = defines a machine's capabilities as well as its gcode
- "*.toolpath" = an IR (Intermediate Representation) format for gcode
  - designed to replace gcode for linuxCNC machines, for easy "shop-floor" programming
  - provides standard api & environment that is homogeneous across machines

