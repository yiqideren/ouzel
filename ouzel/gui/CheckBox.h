// Copyright (C) 2016 Elviss Strazdins
// This file is part of the Ouzel engine.

#pragma once

#include "gui/Widget.h"
#include "events/Event.h"
#include "events/EventHandler.h"

namespace ouzel
{
    namespace gui
    {
        class CheckBox: public Widget
        {
        public:
            CheckBox(const std::string& normalImage, const std::string& selectedImage, const std::string& pressedImage, const std::string& disabledImage, const std::string& tickImage);
            virtual ~CheckBox();

            virtual void setEnabled(bool enabled) override;

            virtual void setChecked(bool newChecked);
            virtual bool isChecked() const { return checked; }

        protected:
            bool handleUI(Event::Type type,const UIEvent& event);

            void updateSprite();

            scene::SpritePtr normalSprite;
            scene::SpritePtr selectedSprite;
            scene::SpritePtr pressedSprite;
            scene::SpritePtr disabledSprite;
            scene::SpritePtr tickSprite;

            EventHandler eventHandler;

            bool pointerOver = false;
            bool pressed = false;
            bool checked = false;
        };
    } // namespace gui
} // namespace ouzel
