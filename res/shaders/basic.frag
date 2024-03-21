#version 330 core
out vec4 FragColor;

// from Vertex Shader
in vec3 vecColor;
in vec2 TexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), 0.2) * vec4(vecColor, 1.0);
}
