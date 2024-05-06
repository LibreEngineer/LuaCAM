
# LuaCAM
This is the Lua library for LuaCAM.

## Module Design
- Module at the root of CAM, define all the common functions and structures.
- The post processor step is integrated into the machine construct/object, whatever the hell you want to call it.
- all feeds and speeds are passed from the tool into the toolpath
- all toolpath params support callbacks as inputs
- all linking moves are passed through callbacks
- editor module is used to access the gui editor

## Code Style
- strings meant as identifiers (like file/module names) or table indexes should be written with single quotes
- strings meant to be printed or read by the user should be written with double quotes
- function parenthesis may only be removed when inputting a table as the only argument
```lua
local function func(tbl)
  print(tbl[1])
end
func{
  "hello world"
}
```
- generic variables:
  - 'i' = index
  - 'k' = key
  - 'v' = value
  - 'tbl' = table
- special variables:
  - 'M' = module table to return
  - 'proto' = local table of the module's prototypes


## Workflow
Notes:
- An integral part of luaCAM is that you generate the resultant brep geometry of a toolpath before you run it
```txt
1. Import model(s)
2. Identify/Generate stock model
(per toolpath)
3. Initialize a toolpath
4. Generate resultant brep geometry from stock
5. Machine to generated geometry
```

## Toolpath Types
- cmm
- milling
- turning
- additive (see: https://www.carbon3d.com/resources/blog/the-7-types-of-additive-manufacturing)
- cutter (waterjet, laser, plasma)
- wire (edm)
- sinker (edm)

## Jargon
These are the jargon words and abbreviations used throughout the CAM module, in alphabetical order.
abcdefghijklmnopqrstuvwxyz
- FPR = feed per revolution
- ID = inner diameter
- LOC = length of cut | flute length
- OD = outter diameter
- SFM = surface feed per minute
- WOC = width of cut
