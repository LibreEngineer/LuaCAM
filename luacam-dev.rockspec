package = "luaCAM"
version = "dev"-- for the current git commit
source = {
   url = "git+https://github.com/LibreEngineer/LuaCAM"
}
description = {
   summary = "",
   detailed = [[]],
   homepage = "https://github.com/LibreEngineer/LuaCAM",
   license = "*** WTFPL ***"
}
dependencies = {
  "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      main = {
         sources = "src/main.c"
      }
   }
}
