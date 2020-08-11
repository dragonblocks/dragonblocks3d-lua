#version 330 core

in vec2 ourTexCoord;

out vec4 finalColor;

uniform sampler2D ourTexture;

void main()
{
	finalColor = texture(ourTexture, ourTexCoord);
}
