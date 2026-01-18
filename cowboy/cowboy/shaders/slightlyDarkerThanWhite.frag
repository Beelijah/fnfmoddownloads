#pragma header

void main()
{
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);

    // ill learn how to actually make these later -egg

    if (color.a < 0.01) {
        discard;
    }

    gl_FragColor = vec4(0.9, 0.9, 0.9, color.a) * openfl_Alphav;
}