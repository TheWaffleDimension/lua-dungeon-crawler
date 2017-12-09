// simple fragment shader

// 'time' contains seconds since the program was linked.
extern float time;

extern sampler2D tex;
extern sampler2D tex2;

float radius = .5;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
	float t = clamp(time / 6., 0., 1.);

	vec2 coords = texture_coords;
	vec2 dir = coords - vec2(.5);
	
	float dist = distance(coords, vec2(.5));
	vec2 offset = dir * (sin(dist * 80. - time*15.) + .5) / 30.;

	vec2 texCoord = coords + offset;
	vec4 diffuse = texture2D(tex, texCoord);

	vec4 mixin = texture2D(tex2, texCoord);

 	gl_FragColor = mixin * t + diffuse * (1. - t);
}