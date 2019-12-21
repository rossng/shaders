#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    
    vec2 sun_pos = vec2(0.5, 0.2) + vec2(0.2 * sin(u_time / 10.0), 0.2 * cos(u_time / 5.0));
    
    float distance_from_sun = sqrt((sun_pos.x - st.x) * (sun_pos.x - st.x) + (sun_pos.y - st.y) * (sun_pos.y - st.y));

    vec3 sun_color = vec3(0.88,0.62,0.42);
    vec3 sky_color = vec3(0.4,0.35,0.56);
    
    vec3 color = mix(sun_color, sky_color, distance_from_sun);
    
    vec3 sea_color = vec3(0.22,0.21,0.25);
    float sea_pct = 1.0 - step(0.25, st.y);
    
    color = mix(color, sea_color, sea_pct);
    
    vec3 cloud_color = vec3(0.91,0.87,0.67);
    float cloud_height = sin(st.x * 3.14 * 3.0) / 50.0 + 1.2 - sin(st.x * 3.14 * 2.0) / 20.0;
    float cloud_pct = smoothstep(cloud_height - 0.5, cloud_height, st.y);
    color = mix(color, cloud_color, cloud_pct);
    
    gl_FragColor = vec4(color, 1.0);
}
