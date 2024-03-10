
# LuaCAM
Use Lua as an IR language to generate G-Codes.
Provides GUI and minimal geometry kernel in C.

## TODO
1. [ ] create C API for Lua
2. [ ] create geometry kernel in C API
3. [ ] flesh out luaCAM
4. [ ] create GUI


## Features
- First class support for [LinuxCNC](https://linuxcnc.org/docs/html/gcode/) and [RS274NGC](https://www.nist.gov/publications/nist-rs274ngc-interpreter-version-3)
- Provides ensureUnit(val, unit) method for safely inputing units
- Inline comment formatting
- Static analysis tools for G-Code using Machinespec files
- Machinespec files allows you to fully utilize and maintain the safety of your machines


## Design and Philosophy
LuaCAM is designed to replace traditional CAM systems and workflows for a (potentially) more efficient design.
It treats CNC programs like software development.
Tools are categorized by the machining strategy they support. Tools can only support one machining strategy.


## GUI
Here's a quick overview of the provided GUI.

### Features
- Workspaces for Toolpath, Tool, and Machine
- Builtin machine, tool, & fixture configurators
- Toolpath workspace directly tests and validates the output GCodes for a machine
- Machine simulation accurately simulates feedrate of machine

## File Formats
- "*.path" = lua file with special environment to represent LuaCAM's geometry.path object
- "*.toolpath" = extends the path file to specifically represent toolpaths, similar to [tpl](https://tplang.org/)
- "*.machinespec" = lua file to define a machine's capabilities and gcode
- "*.tools" = a csv file containing tool definitions

