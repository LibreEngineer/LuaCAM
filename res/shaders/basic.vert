#version 330 core
// VAO attributes:
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;
layout (location = 2) in vec2 aTexCoord;

out vec3 vecColor;// output color for the Fragment Shader
out vec2 TexCoord;

void main() {
    gl_Position = vec4(aPos, 1.0);
    vecColor = aColor;// pass color attribute to Fragment Shader
    TexCoord = aTexCoord;
}
