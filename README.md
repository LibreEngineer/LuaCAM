
# LuaCAM
Use Lua as an IR language to generate G-Codes.
Provides GUI and minimal geometry kernel in C.

## TODO
- [serpent.lua](https://luarocks.org/modules/paulclinger/serpent) for data serialization
1. [ ] create C API for Lua
  1a. [ ] configure build system
2. [ ] create geometry kernel in C API
3. [ ] flesh out luaCAM
4. [ ] create GUI
5. [ ] solidify api before integrating into LinuxCNC


## Features
- First class support for [LinuxCNC](https://linuxcnc.org/docs/html/gcode/) and [RS274NGC](https://www.nist.gov/publications/nist-rs274ngc-interpreter-version-3)
- Provides unit "tuple" to ensure units are always correct, i.e. {12.34, unit["mm"]}
- The control defintion for a machine allows you to use non-traditional languages like [OpenSBP](https://www.opensbp.com/https://www.opensbp.com/https://www.opensbp.com/) or [TPL](https://tplang.org/)
- Inline comment formatting
- Static analysis tools for G-Code using Machinespec files
- Machdef files allows you to fully utilize and maintain the safety of your machines
- Toolpaths are designed to maintain constant velocity and chipload


## Design and Philosophy
LuaCAM is designed to replace traditional CAM systems and workflows for a more efficient design.
It treats CNC programs like software development.
Tools are categorized by the machining strategy they support. Tools can only support one machining strategy.


## LuaCAM Editor
Here's a quick overview of the provided GUI editor.

### Features
- Workspaces for Toolpath, Tool, and Machine
- Builtin LSP, with OTB support for [NeoVim](http://neovim.io/)
- Builtin machine, tool, & fixture configurators
- Toolpath workspace directly tests and validates the output GCodes using the control definition
- Machine simulation accurately simulates feedrate of machine
- Extends [ldoc](https://github.com/lunarmodules/ldoc) to support image/icon popups


## File Formats
- "*.lon" = lua object notation, a lua module that must return a single table
- "*.3dpath" = lua file with special environment to represent LuaCAM's geometry.path object
- "*.toolpath" = extends the 3dpath file format to specifically represent toolpaths, similar to [tpl](https://tplang.org/)
- "*.machdef" = file format to define a machine's kinematics
- "*.ctrldef" = file format to define a machine's controller
- "*.tools.<fmt>" = a tool library saved in a plain text format; fmt = ("lua"|"lon"|"txt"|"csv"|"xml")
- "*.tooldb" = a tool library saved in a binary database file, preferably SQLite

