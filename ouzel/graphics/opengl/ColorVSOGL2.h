// Copyright (C) 2016 Elviss Strazdins
// This file is part of the Ouzel engine.

const uint8_t COLOR_VERTEX_SHADER_OGL2[] =
    "#version 120\n"
    "attribute vec3 in_Position;\n"
    "attribute vec4 in_Color;\n"
    "uniform mat4 modelViewProj;\n"
    "varying vec4 ex_Color;\n"
    "void main(void)\n"
    "{\n"
    "    gl_Position = modelViewProj * vec4(in_Position, 1.0);\n"
    "    ex_Color = in_Color;\n"
    "}";
