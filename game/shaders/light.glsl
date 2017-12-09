struct LightSource {
	vec2 position;
	vec4 color;
	number brightness;
	number range;
};

extern LightSource lights[128];

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
	vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
	
	number totalBrightness = 0;
	vec4 totalColor = vec4(0);
	number lightsAffecting = 0;
	
	for(int i=0;i<128;++i) {
		number tempRange = distance(screen_coords, lights[i].position);
		if (tempRange <= lights[i].range) {
			lightsAffecting++;
			totalBrightness = totalBrightness + (lights[i].brightness * (1 - (tempRange/lights[i].range)));
			totalColor = totalColor + lights[i].color;
		}
	}
	
	//totalBrightness = totalBrightness / lightsAffecting;
	totalColor = totalColor / lightsAffecting;
	totalColor.a = 1/lightsAffecting;
	
	vec4 result = pixel * color * (totalColor * totalBrightness);
	result.a = pixel.a;
	
	return result;
}