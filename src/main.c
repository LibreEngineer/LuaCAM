// libc headers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
// GL crap
#include <GL/gl3w.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>
#include <cglm/cglm.h>
// STB
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
// Custom
#include "util.h"
#include "input.h"

void error_callback(int error, const char* description);
void framebuffer_size_callback(GLFWwindow* window, int width, int height);

// the entry point for the gui program
int main() {
    // Initialization: {{{
    GLFWwindow* window;
    glfwSetErrorCallback(error_callback);
    if (!glfwInit())
        return -1;

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    window = glfwCreateWindow(640, 480, "Hello World", NULL, NULL);
    if (!window) {
        glfwTerminate();
        return -1;
    }
    glfwSetKeyCallback(window, key_callback);// key_callback() is implemented in input.c
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
    glfwMakeContextCurrent(window);

    if (gl3wInit()) {
        fprintf(stderr, "failed to initialize OpenGL\n");
        return -1;
    }
    if (!gl3wIsSupported(3, 3)) {
        fprintf(stderr, "OpenGL 3.2 not supported\n");
        return -1;
    }
    printf(ANSI_COLOR_CYAN"OpenGL %s, GLSL %s\n"ANSI_COLOR_RESET, glGetString(GL_VERSION),
        glGetString(GL_SHADING_LANGUAGE_VERSION));
    //}}}

    // OpenGL Data: {{{
    // Create Shader Program: {{{
    GLuint vertexShader = CompileShader("src/shader/basic.vert", GL_VERTEX_SHADER);
    GLuint fragmentShader = CompileShader("src/shader/basic.frag", GL_FRAGMENT_SHADER);
    GLuint shaderProgram = LinkShaderProgram(vertexShader, 0, fragmentShader);
    puts(ANSI_COLOR_RESET);
    // these aren't needed anymore since they are already linked into shaderProgram
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    // }}}

    float vertices[] = {
        // positions         // colors           // texture coords
        0.5f,  0.5f, 0.0f,   1.0f, 0.0f, 0.0f,   1.0f, 1.0f, // top right
        0.5f, -0.5f, 0.0f,   0.0f, 1.0f, 0.0f,   1.0f, 0.0f, // bottom right
       -0.5f, -0.5f, 0.0f,   0.0f, 0.0f, 1.0f,   0.0f, 0.0f, // bottom left
       -0.5f,  0.5f, 0.0f,   1.0f, 1.0f, 0.0f,   0.0f, 1.0f  // top left
    };
    GLuint indices[] = {
        0, 1, 3,
        1, 2, 3
    };
    // OpenGL's Intrisic Objects
    uint VAO, EBO, VBO;
    // Create Vertex Array Object to save vertex attribute configuration
    glGenVertexArrays(1, &VAO);
    glBindVertexArray(VAO);// configure VAO below
    // Create Element Buffer Object to properly index vertex buffer
    glGenBuffers(1, &EBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    // Create Buffer Object to store vertices on the GPU
    glGenBuffers(1, &VBO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    // Configure Attributes
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);// attrib[0] = position
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(3*sizeof(float)));
    glEnableVertexAttribArray(1);// attrib[0] = position
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(6*sizeof(float)));
    glEnableVertexAttribArray(2);// attrib[0] = position
                                 //
    // Unbind Objects
    glBindBuffer(GL_ARRAY_BUFFER, 0);// unbind VBO since it's already associated w/ the VAO
    glBindVertexArray(0);// unbind the VAO after it's configured (so another vao can be configured)

    // Textures: {{{
    GLuint texture0, texture1;
    glGenTextures(1, &texture0);
    glGenTextures(1, &texture1);
    // Configure texture0
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texture0);// bind texture so it can be configured
    // texture params
    float borderColor[] = { 1.0f, 1.0f, 0.0f, 1.0f };
    glTexParameterfv(GL_TEXTURE_2D, GL_TEXTURE_BORDER_COLOR, borderColor);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_MIRRORED_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_MIRRORED_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);// mipmaps only work for minification
    int width, height, nrChannels;
    unsigned char* texData = stbi_load("res/textures/wooden_container.jpg", &width, &height, &nrChannels, 0);
    if (texData) {
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, texData);
        glGenerateMipmap(GL_TEXTURE_2D);
    } else {
        ERROR("Texture data wasn't loaded properly for texture0.");
    }
    stbi_image_free(texData);
    // }}}
    // }}}

    // Program loop
    glfwSwapInterval(1);
    //glfwSetInputMote(window, GLFW_Cursor, GLFW_CURSOR_DISABLED);

    glEnable(GL_DEPTH_TEST);
    double dt = 0.0;
    double lastFrame = 0.0;
    do{
        // Update
        dt = glfwGetTime() - lastFrame;
        lastFrame += dt;
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        // ensure these are bound
        glUseProgram(shaderProgram);
        glBindTexture(GL_TEXTURE_2D, texture0);
        glBindVertexArray(VAO);

        // Draw
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);

        // Render (Swap Buffers & Process Events)
        glfwSwapBuffers(window);
        glfwPollEvents();
    }while (!glfwWindowShouldClose(window));

    glfwTerminate();
    return 0;
}


// GLFW Callbacks: {{{
// Update viewport size when window is resized
void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
    glViewport(0, 0, width, height);
}

// GLFW will call this when an error is met
void error_callback(int error, const char* description) {
    fprintf(stderr, "Error: %s\n", description);
}
// }}}
