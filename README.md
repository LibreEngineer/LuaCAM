
# LuaCAM
Use Lua to generate G-Codes.
Provides GUI and minimal geometry kernel in C.

## TODO
1. [ ] create geometry kernel in C API
2. [ ] create C API for Lua
3. [ ] flesh out luaCAM
4. [ ] create GUI


## Features
- First class support for [LinuxCNC](https://linuxcnc.org/docs/html/gcode/) and [RS274NGC](https://www.nist.gov/publications/nist-rs274ngc-interpreter-version-3)
- Provides ensureUnit(val, unit) method for safely inputing units
- Inline comment formatting
- Static analysis tools for G-Code using Machinespec files
- Machinespec file allows you to fully utilize and maintain the safety of your machines


## Design and Philosophy
LuaCAM is designed to replace traditional CAM systems and workflows for a (potentially) more efficient design.



## GUI
Here's a quick overview of the provided GUI.

### Features
- Workspaces for Toolpath, Tool, and Machine
- Builtin machine, tool, & fixture configurators
- Toolpath workspace directly tests and validates the output GCodes for a machine
- Machine simulation accurately simulates feedrate of machine



## File Formats
- "*.machinespec" = defines a machine's capabilities as well as its gcode
- "*.toolpath" = an IR (Intermediate Representation) format for gcode
  - designed to replace gcode in linuxCNC machines, for easy "shop-floor" programming
  - provides standard api & environment that is homogeneous across machines, to eliminate uncertainty

