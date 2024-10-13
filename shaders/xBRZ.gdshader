/**
* hq2x and hq4x filter.
* https://www.shadertoy.com/view/MslGRS
* https://github.com/libretro/common-shaders/blob/master/scalehq/shaders/4xScaleHQ.cg
* https://github.com/libretro/common-shaders/blob/master/scalehq/shaders/2xScaleHQ.cg
*/
shader_type canvas_item;

uniform int type = 0; // 0:none, 1:hq2x, 2:hq4x

void fragment(){
	vec4 color = texture(TEXTURE, UV);
	vec2 uv = UV;
	vec4 c = color;


	float x = 0.5 * TEXTURE_PIXEL_SIZE.x;
	float y = 0.5 * TEXTURE_PIXEL_SIZE.y;

	

	vec2 dg1 = vec2( x, y);
	vec2 dg2 = vec2(-x, y);

	

	vec2 ddx = vec2(x,0.0);
	vec2 ddy = vec2(0.0,y);
	const vec4 dt = vec4(1.0);
	if (type==2){
		
		float mx = 1.0; // start smoothing wt.
		const float k = -1.10; // wt. decrease factor
		const float max_w = 0.75; // max filter weigth
		const float min_w = 0.03; // min filter weigth
		const float lum_add = 0.33; // effects smoothing
		
		vec2 sd1 = dg1*0.5;
		vec2 sd2 = dg2*0.5;
		
		vec4 t1 = vec4(uv-sd1,uv-ddy);
		vec4 t2 = vec4(uv-sd2,uv+ddx);
		vec4 t3 = vec4(uv+sd1,uv+ddy);
		vec4 t4 = vec4(uv+sd2,uv-ddx);
		vec4 t5 = vec4(uv-dg1,uv-dg2);
		vec4 t6 = vec4(uv+dg1,uv+dg2);
		
		vec4 i1 = texture(TEXTURE, t1.xy);
		vec4 i2 = texture(TEXTURE, t2.xy);
		vec4 i3 = texture(TEXTURE, t3.xy);
		vec4 i4 = texture(TEXTURE, t4.xy);

		vec4 o1 = texture(TEXTURE, t5.xy);
		vec4 o3 = texture(TEXTURE, t6.xy);
		vec4 o2 = texture(TEXTURE, t5.zw);
		vec4 o4 = texture(TEXTURE, t6.zw);

		vec4 s1 = texture(TEXTURE, t1.zw);
		vec4 s2 = texture(TEXTURE, t2.zw);
		vec4 s3 = texture(TEXTURE, t3.zw);
		vec4 s4 = texture(TEXTURE, t4.zw);
		
		float ko1 = dot(abs(o1-c),dt);
		float ko2 = dot(abs(o2-c),dt);
		float ko3 = dot(abs(o3-c),dt);
		float ko4 = dot(abs(o4-c),dt);

		float k1=min(dot(abs(i1-i3),dt),max(ko1,ko3));
		float k2=min(dot(abs(i2-i4),dt),max(ko2,ko4));

		float w1 = k2; if(ko3<ko1) w1*=ko3/ko1;
		float w2 = k1; if(ko4<ko2) w2*=ko4/ko2;
		float w3 = k2; if(ko1<ko3) w3*=ko1/ko3;
		float w4 = k1; if(ko2<ko4) w4*=ko2/ko4;

		c=(w1*o1+w2*o2+w3*o3+w4*o4+0.001*c)/(w1+w2+w3+w4+0.001);
		w1 = k*dot(abs(i1-c)+abs(i3-c),dt)/(0.125*dot(i1+i3,dt)+lum_add);
		w2 = k*dot(abs(i2-c)+abs(i4-c),dt)/(0.125*dot(i2+i4,dt)+lum_add);
		w3 = k*dot(abs(s1-c)+abs(s3-c),dt)/(0.125*dot(s1+s3,dt)+lum_add);
		w4 = k*dot(abs(s2-c)+abs(s4-c),dt)/(0.125*dot(s2+s4,dt)+lum_add);

		w1 = clamp(w1+mx,min_w,max_w);
		w2 = clamp(w2+mx,min_w,max_w);
		w3 = clamp(w3+mx,min_w,max_w);
		w4 = clamp(w4+mx,min_w,max_w);
		
		color = vec4((w1*(i1+i3)+w2*(i2+i4)+w3*(s1+s3)+w4*(s2+s4)+c)/(2.0*(w1+w2+w3+w4)+1.0));
	}else if (type==1){
		
		const float mx = 0.325;      // start smoothing wt.
		const float k = -0.250;      // wt. decrease factor
		const float max_w = 0.25;    // max filter weigth
		const float min_w =-0.05;    // min filter weigth
		const float lum_add = 0.25;  // effects smoothing
		
		vec4 t1 = vec4(uv-dg1,uv-ddy);
		vec4 t2 = vec4(uv-dg2,uv+ddx);
		vec4 t3 = vec4(uv+dg1,uv+ddy);
		vec4 t4 = vec4(uv+dg2,uv-ddx);
		
		vec4 c00 = texture(TEXTURE, t1.xy); 
		vec4 c10 = texture(TEXTURE, t1.zw); 
		vec4 c20 = texture(TEXTURE, t2.xy); 
		vec4 c01 = texture(TEXTURE, t4.zw); 
		vec4 c21 = texture(TEXTURE, t2.zw); 
		vec4 c02 = texture(TEXTURE, t4.xy); 
		vec4 c12 = texture(TEXTURE, t3.zw); 
		vec4 c22 = texture(TEXTURE, t3.xy); 

		float md1 = dot(abs(c00 - c22), dt);
		float md2 = dot(abs(c02 - c20), dt);

		float w1 = dot(abs(c22 - c), dt) * md2;
		float w2 = dot(abs(c02 - c), dt) * md1;
		float w3 = dot(abs(c00 - c), dt) * md2;
		float w4 = dot(abs(c20 - c), dt) * md1;

		float t1_ = w1 + w3;
		float t2_ = w2 + w4;
		float ww = max(t1_, t2_) + 0.0001;

		c = (w1 * c00 + w2 * c20 + w3 * c22 + w4 * c02 + ww * c) / (t1_ + t2_ + ww);

		float lc1 = k / (0.12 * dot(c10 + c12 + c, dt) + lum_add);
		float lc2 = k / (0.12 * dot(c01 + c21 + c, dt) + lum_add);

		w1 = clamp(lc1 * dot(abs(c - c10), dt) + mx, min_w, max_w);
		w2 = clamp(lc2 * dot(abs(c - c21), dt) + mx, min_w, max_w);
		w3 = clamp(lc1 * dot(abs(c - c12), dt) + mx, min_w, max_w);
		w4 = clamp(lc2 * dot(abs(c - c01), dt) + mx, min_w, max_w);

		color = vec4(w1 * c10 + w2 * c21 + w3 * c12 + w4 * c01 + (1.0 - w1 - w2 - w3 - w4) * c);
	}
	COLOR = color;
}