// Copyright (C) 2016 Elviss Strazdins
// This file is part of the Ouzel engine.

#include "RendererOGLMacOS.h"
#include "utils/Utils.h"

namespace ouzel
{
    namespace graphics
    {
        RendererOGLMacOS::~RendererOGLMacOS()
        {
            if (openGLContext)
            {
                [openGLContext release];
            }

            if (pixelFormat)
            {
                [pixelFormat release];
            }
        }

        void RendererOGLMacOS::free()
        {
            RendererOGL::free();

            if (openGLContext)
            {
                [openGLContext release];
                openGLContext = Nil;
            }

            if (pixelFormat)
            {
                [pixelFormat release];
                pixelFormat = Nil;
            }
        }

        bool RendererOGLMacOS::init(const WindowPtr& window,
                                  uint32_t newSampleCount,
                                  TextureFiltering newTextureFiltering,
                                  bool newVerticalSync)
        {
            free();

            // Create pixel format
            NSOpenGLPixelFormatAttribute openGL3Attributes[] =
            {
                NSOpenGLPFADoubleBuffer,
                NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion3_2Core,
                NSOpenGLPFAColorSize, 24,
                NSOpenGLPFAAlphaSize, 8,
                //NSOpenGLPFADepthSize, 32, // set depth buffer size
                0
            };

            pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:openGL3Attributes];

            if (pixelFormat)
            {
                apiMajorVersion = 3;
                apiMinorVersion = 2;
                log(LOG_LEVEL_INFO, "Using OpenGL 3.2");
            }
            else
            {
                log(LOG_LEVEL_INFO, "Failed to crete OpenGL 3.2 pixel format");

                NSOpenGLPixelFormatAttribute openGL2Attributes[] =
                {
                    NSOpenGLPFADoubleBuffer,
                    NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersionLegacy,
                    NSOpenGLPFAColorSize, 24,
                    NSOpenGLPFAAlphaSize, 8,
                    //NSOpenGLPFAMultisample,
                    0
                };

                pixelFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:openGL2Attributes];

                if (pixelFormat)
                {
                    apiMajorVersion = 2;
                    apiMinorVersion = 0;
                    log(LOG_LEVEL_INFO, "Using OpenGL 2");
                }
            }

            if (!pixelFormat)
            {
                log(LOG_LEVEL_ERROR, "Failed to crete OpenGL 2 pixel format");
                return Nil;
            }

            // Create OpenGL context
            openGLContext = [[NSOpenGLContext alloc] initWithFormat:pixelFormat shareContext:NULL];

            [openGLContext makeCurrentContext];
            
            return RendererOGL::init(window, newSampleCount, newTextureFiltering, newVerticalSync);
        }

        bool RendererOGLMacOS::present()
        {
            [openGLContext makeCurrentContext];

            if (!RendererOGL::present())
            {
                return false;
            }

            [openGLContext flushBuffer];

            return true;
        }

        void RendererOGLMacOS::setSize(const Size2& newSize)
        {
            RendererOGL::setSize(newSize);

            dirty = true;
        }

        bool RendererOGLMacOS::update()
        {
            if (dirty)
            {
                [openGLContext update];
            }

            return RendererOGL::update();
        }
    } // namespace graphics
} // namespace ouzel
