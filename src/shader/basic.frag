#version 330 core
out vec4 FragColor;// an output color must be specified in the frag shader

in vec3 vertColor;
in vec2 TexCoord;

uniform sampler2D Texure0;
uniform sampler2D Texure1;

void main() {
    // texture() maps a Texture onto a Texture Coordinate
    FragColor = mix(texture(Texure0, TexCoord), texture(Texure1, TexCoord), 0.2) * vec4(vertColor, 1.0);
    // mix(x, y, 0.0) returns x
    // mix(x, y, 0.5) returns (x/2 + y/2)
    // mix(x, y, 1.0) returns y
}
