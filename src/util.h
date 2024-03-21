#pragma once
// libc
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
// GL crap
#include <GL/gl3w.h>
#include <GLFW/glfw3.h>
#include <GL/gl.h>
#include <cglm/cglm.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_RESET   "\x1b[0m"

typedef unsigned int uint;

void ERROR(const char* errStr) {
    fprintf(stderr, ANSI_COLOR_RED "ERROR: " ANSI_COLOR_RESET "%s\n", errStr);
}

void WARN(const char* warnStr) {
    fprintf(stderr, ANSI_COLOR_YELLOW "WARN: " ANSI_COLOR_RESET "%s\n", warnStr);
}

void INFO(const char* infoStr) {
    fprintf(stderr, ANSI_COLOR_YELLOW "INFO: " ANSI_COLOR_RESET "%s\n", infoStr);
}

char* readFile(const char* filepath) {
    char* fbuff;
    long fsize;
    FILE* fp = fopen(filepath, "r");
    if (fp) {
        fseek(fp, 0L, SEEK_END);// get file size (bytes)
        fsize = ftell(fp) + 1;// save a spot for null char
        fseek(fp, 0L, SEEK_SET);// return to begining
        fbuff = memset(malloc(fsize), '\0', fsize);// initialize fbuff with null char
        fread(fbuff, 1, fsize - 1, fp);// read file into fbuff
    } else {
        fprintf(stderr, "ERROR: Failed to read file " ANSI_COLOR_GREEN "`%s`" ANSI_COLOR_RESET, filepath);
    }
    fclose(fp);
    return fbuff;
}

#define INFO_LOG_SIZE 1024

// shaderType must be one of these:
// GL_VERTEX_SHADER
// GL_GEOMETRY_SHADER
// GL_FRAGMENT_SHADER
GLuint CompileShader(const char* filepath, GLuint shaderType) {
    GLuint shaderID = glCreateShader(shaderType);
    const char* src = readFile(filepath);
    int success;
    char infoLog[INFO_LOG_SIZE];
    char shaderTag[20];
    switch (shaderType) {
        case GL_VERTEX_SHADER:
            strcpy(shaderTag, "Vertex");
            break;
        case GL_GEOMETRY_SHADER:
            strcpy(shaderTag, "Geometry");
            break;
        case GL_FRAGMENT_SHADER:
            strcpy(shaderTag, "Fragment");
            break;
        default:
            ERROR("You input an invalid shaderType in CompileShader().");
            return -1;
            break;
    }
    glShaderSource(shaderID, 1, &src, NULL);
    glCompileShader(shaderID);
    // handle errors
    glGetShaderiv(shaderID, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shaderID, INFO_LOG_SIZE, NULL, infoLog);
        fprintf(stderr, ANSI_COLOR_RED "\nError" ANSI_COLOR_RESET ": %s Shader Compilation Failed.\n%s",
                shaderTag, infoLog);
    } else {
        printf(ANSI_COLOR_GREEN "%s Shader: \"%s\" Compiled Successfully!\n" ANSI_COLOR_RESET, shaderTag, filepath);
    }
    return shaderID;
}

// the input shader arguments are listed in the order they are called in the pipeline for consistency
GLuint LinkShaderProgram(GLuint vertexShader, GLuint geometryShader, GLuint fragmentShader) {
    GLuint programID = glCreateProgram();
    int success;
    char infoLog[INFO_LOG_SIZE];
    // Link Shader Program
    if (vertexShader)
        glAttachShader(programID, vertexShader);
    if (geometryShader)
        glAttachShader(programID, geometryShader);
    if (fragmentShader)
        glAttachShader(programID, fragmentShader);
    if (!vertexShader && !fragmentShader && !geometryShader) {
        ERROR("You didn't input a valid vertex, fragment, or geometry shader in LinkShaderProgram().");
        INFO("Most likely, the shaders didn't exist.");
        return -1;
    }
    glLinkProgram(programID);
    // handle errors
    glGetProgramiv(programID, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(programID, INFO_LOG_SIZE, NULL, infoLog);
        fprintf(stderr, ANSI_COLOR_RED "\nError" ANSI_COLOR_RESET ": Failed to Link Shader Program.\n%s", infoLog);
    } else {
        printf(ANSI_COLOR_GREEN "Shader Program Linked Successfully!\n" ANSI_COLOR_RESET);
    }
    return programID;
}
