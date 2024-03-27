#pragma once// This Header handles glfw inputs and defines callable actions in the LuaCAM editor
// GL crap
#include <GL/gl3w.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cglm/cglm.h>

void key_callback(GLFWwindow* window, int key, int scancode, int action, int mods);
