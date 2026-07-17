#pragma header

void main()
{
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    // ill learn how to actually make these later -egg

    gl_FragColor = vec4(1.0, 1.0, 1.0, color.a) * openfl_Alphav;
}