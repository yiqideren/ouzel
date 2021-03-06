// Copyright (C) 2016 Elviss Strazdins
// This file is part of the Ouzel engine.

#pragma once

#include "utils/Types.h"
#include "utils/Noncopyable.h"

namespace ouzel
{
    class Engine;

    namespace scene
    {
        class SceneManager: public Noncopyable
        {
            friend Engine;
        public:
            virtual ~SceneManager();

            void draw();

            void setScene(const ScenePtr& newScene);
            const ScenePtr& getScene() const { return scene; }

        protected:
            SceneManager();

            ScenePtr scene;
            ScenePtr nextScene;
        };
    } // namespace scene
} // namespace ouzel
