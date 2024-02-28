package = "luaCAM"
version = "dev"
source = {
   url = "git+https://github.com/LibreEngineer/LuaCAM"
}
description = {
   summary = "",
   detailed = [[]],
   homepage = "https://github.com/LibreEngineer/LuaCAM",
   license = "*** please specify a license ***"
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
