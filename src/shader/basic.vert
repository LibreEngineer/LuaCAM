#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;
layout (location = 2) in vec2 aTexCoord;

// pass attributes to the frag shader
out vec3 vertColor;
out vec2 TexCoord;

void main() {
    gl_Position = vec4(aPos, 1.0);
    // pass these to the fragment shader
    vertColor = aColor;
    TexCoord = aTexCoord;
}
