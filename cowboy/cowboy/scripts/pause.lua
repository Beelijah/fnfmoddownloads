-- learned substate stuff from here v
-- https://gamebanana.com/tools/16857

-- you might see this in another mod, but that's not the topic of this one...
-- script by scrambled_egg3

local disablePauseMenu = false

local selectionTransitionTime = 0.35
local selectionIntensity = 25
local selectedButton = 'resume'
local transitionTime = 0.15
local selectionTime = 0.25
local canClickMouse = true
local hasAddedIcon = false
local canPause = true
local isMobile = false
local BPM = 98

function onCreatePost()
    if not disablePauseMenu then
        makeLuaSprite('pauseBack', 'black', 0, 0)
        setObjectCamera('pauseBack', 'other')
        setProperty('pauseBack.alpha', 0)
        addLuaSprite('pauseBack', true)
        -- make sprites for pause menu here, and hide them/take them offscreen

        precacheImage('PAUSE/blythe')
        precacheImage('PAUSE/cowboy')
        precacheImage('PAUSE/millie') -- god forbid i forget to set this to millie
        -- thank god i remember to swap it from blythe to millie

        if getCurrentOrientation() == 'Portrait' or getCurrentOrientation() == 'PortraitUpsideDown' or getCurrentOrientation() == 'LandscapeLeft' or getCurrentOrientation() == 'LandscapeRight' then -- woah i found the deleted source code woah
            isMobile = true
        else
            precacheImage('PAUSE/mouse')
        end
    end
end

function addSprites()
    if loadedSongPath == 'stash' then
        makeAnimatedLuaSprite('icon', 'PAUSE/blythe')
    elseif loadedSongPath == 'churu' then
        makeAnimatedLuaSprite('icon', 'PAUSE/millie')
    else
        makeAnimatedLuaSprite('icon', 'PAUSE/cowboy')
    end

    addAnimationByIndices('icon', 'idle', 'idle', '1,2,3,4,5,6,7,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8', 20)
    setObjectCamera('icon', 'other')
    scaleObject('icon', 1.35, 1.35)
    setProperty('icon.x', 1280)
    setProperty('icon.y', 165)
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("icon"));') -- https://gamebanana.com/questions/40730

    makeLuaText('pauseSongName', 'Error', 1280, 300, 50)
    setObjectCamera('pauseSongName', 'other')
    if loadedSongPath == 'stash' then
        setTextString('pauseSongName', 'STASH')
    elseif loadedSongPath == 'churu' then
        setTextString('pauseSongName', 'CHURU')
    elseif loadedSongPath == 'cowboy' then
        setTextString('pauseSongName', 'COWBOY')
    end
    setTextSize('pauseSongName', 75)
    setTextBorder('pauseSongName', 5, '000000')
    setTextAlignment('pauseSongName', 'right')
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("pauseSongName"));')

    makeLuaText('pauseDeaths', 'Error', 1280, 300 + deaths, 150)
    setObjectCamera('pauseDeaths', 'other')
    setTextString('pauseDeaths', deaths .. ' Deaths')
    setTextSize('pauseDeaths', 55)
    setTextBorder('pauseDeaths', 5, '000000')
    setTextAlignment('pauseDeaths', 'right')
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("pauseDeaths"));')
    runTimer('addDeathsPause', transitionTime / 2)

    makeLuaSprite('resume', 'PAUSE/sign-top', -360, -100 - 20)
    setProperty('resume.antialiasing', false)
    setObjectCamera('resume', 'other')
    scaleObject('resume', 22.5, 22.5)
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("resume"));')

    makeLuaSprite('restart', 'PAUSE/sign-middle', -360, 200 - 20)
    setProperty('restart.antialiasing', false)
    setObjectCamera('restart', 'other')
    scaleObject('restart', 22.5, 22.5)
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("restart"));')

    makeLuaSprite('exit', 'PAUSE/sign-bottom', -360, 500 - 20)
    setProperty('exit.antialiasing', false)
    setObjectCamera('exit', 'other')
    scaleObject('exit', 22.5, 22.5)
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("exit"));')

    makeLuaText('resumeText', 'RESUME', 360, -360, 85)
    setObjectCamera('resumeText', 'other')
    setTextSize('resumeText', 70)
    setTextBorder('resumeText', 6, '000000')
    setTextAlignment('resumeText', 'center')
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("resumeText"));')

    makeLuaText('restartText', 'RESTART', 360, -360, 320)
    setObjectCamera('restartText', 'other')
    setTextSize('restartText', 65)
    setTextBorder('restartText', 5, '000000')
    setTextAlignment('restartText', 'center')
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("restartText"));')

    makeLuaText('exitText', 'EXIT', 360, -360, 535)
    setObjectCamera('exitText', 'other')
    setTextSize('exitText', 100)
    setTextBorder('exitText', 8, '000000')
    setTextAlignment('exitText', 'center')
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("exitText"));')

    makeLuaText('selectionIndicator', '<', 360, 280, 70)
    setObjectCamera('selectionIndicator', 'other')
    setTextSize('selectionIndicator', 125)
    setTextBorder('selectionIndicator', 8, '000000')
    setTextAlignment('selectionIndicator', 'center')

    if isMobile then
        setProperty('selectionIndicator.visible', false)
    end
    
    runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("selectionIndicator"));')

    if not isMobile then
        makeLuaSprite('mouse', 'PAUSE/mouse', getMouseX('other'), getMouseY('other'))
        setProperty('mouse.antialiasing', false)
        setProperty('mouse.alpha', 0)
        setObjectCamera('mouse', 'other')
        scaleObject('mouse', 0.65, 0.65)
        runHaxeCode('CustomSubstate.instance.add(game.getLuaObject("mouse"));')
    end
end

function onCustomSubstateCreatePost(name)
    if name == 'pauseState' then
        addSprites()
        prettyPleaseSTOP = false
        selectedButton = 'resume'

        doTweenAlpha('eggPauseBack', 'pauseBack', 0.5, transitionTime)
        cancelTween('eggPauseMouse')
        doTweenAlpha('eggPauseMouse', 'mouse', 1, transitionTime)
        doTweenAlpha('eggSelectionIndicatorAlpha', 'selectionIndicator', 1, transitionTime)
        doTweenX('eggPauseIcon', 'icon', 750, transitionTime * 2, 'quartOut')
        doTweenX('eggPauseSongName', 'pauseSongName', -50, transitionTime * 2, 'quartOut')
        doTweenX('eggPauseSign1', 'resume', 0, transitionTime * 2, 'quartOut')
        doTweenX('eggPauseSign2', 'restart', -22.5, transitionTime * 2, 'quartOut')
        doTweenX('eggPauseSign3', 'exit', 0, transitionTime * 2, 'quartOut')
        doTweenX('eggPauseSign4', 'resumeText', 0, transitionTime * 2, 'quartOut')
        doTweenX('eggPauseSign5', 'restartText', 0, transitionTime * 2, 'quartOut')
        doTweenX('eggPauseSign6', 'exitText', 0, transitionTime * 2, 'quartOut')

        cancelTween('eggSelectionIndicator1')
        cancelTween('eggSelectionIndicator2')
        doTweenX('eggSelectionIndicator2', 'selectionIndicator', getProperty('selectionIndicator.x') + selectionIntensity, selectionTime, 'quartOut')

        playSound('pause', 1, 'pause', true)
        runTimer('bouncePause', 60 / BPM, 0)
        -- show your sprites
    end
end

function onCustomSubstateDestroy(name)
    if name == 'pauseState' then
        canPause = false
        --canPause = true -- uncomment this to try out spamming, i recommend the beginning of churu
        runTimer('pauseCooldown', 0.5) -- if you spam the pause menu you can literally break everything so trust this is necessary

        if isSniffing then
            resumeSound('SNIFF')
        end

        if isJumpscaring then
            resumeSound('JUMPSCARE')
        end

        -- hide/take your sprites offscreen
    end
end

function Destroy()
    doTweenAlpha('eggPauseBack', 'pauseBack', 0, transitionTime)
    cancelTween('eggPauseMouse')
    doTweenAlpha('eggPauseMouse', 'mouse', 0, transitionTime * 2, 'quartOut')
    doTweenAlpha('eggSelectionIndicatorAlpha', 'selectionIndicator', 0, transitionTime)
    doTweenX('eggPauseIcon', 'icon', 1280, transitionTime * 2, 'quartOut')
    doTweenX('eggPauseSongName', 'pauseSongName', 300, transitionTime * 2, 'quartOut')
    doTweenX('eggPauseSign1', 'resume', -360, transitionTime * 2, 'quartOut')
    doTweenX('eggPauseSign2', 'restart', -360, transitionTime * 2, 'quartOut')
    doTweenX('eggPauseSign3', 'exit', -360, transitionTime * 2, 'quartOut')
    doTweenX('eggPauseSign4', 'resumeText', -360, transitionTime * 2, 'quartOut')
    doTweenX('eggPauseSign5', 'restartText', -360, transitionTime * 2, 'quartOut')
    doTweenX('eggPauseSign6', 'exitText', -360, transitionTime * 2, 'quartOut')
    cancelTween('eggPauseDeaths')
    prettyPleaseSTOP = true
    doTweenX('eggPauseDeaths', 'pauseDeaths', 300 + deaths, transitionTime * 2, 'quartOut')

    soundFadeOut('pause', transitionTime)
    runHaxeCode('resyncVocals();') -- for some reason the instrumental gets deleted without this (???)
end

function onCustomSubstateUpdate(name)
    if name == 'pauseState' then
        -- onUpdate() but it only runs when your pause menu is open

        if not isMobile then
            setProperty('mouse.x', getMouseX('other'))
            setProperty('mouse.y', getMouseY('other'))
        
            --if hasUsedKeyboard then
            --    doTweenAlpha('eggPauseMouse', 'mouse', 0, transitionTime * 2, 'quartOut')
            --end

            --if lastMousePosition ~= getMouseX() .. getMouseY() then
            --    doTweenAlpha('eggPauseMouse', 'mouse', 1, transitionTime * 2, 'quartOut')
            --end

            if keyJustPressed('ui_down') then
                if selectedButton == 'none' or selectedButton == 'resume' then
                    selectedButton = 'restart'
                elseif selectedButton == 'restart' then
                    selectedButton = 'exit'
                elseif selectedButton == 'exit' then
                    selectedButton = 'resume'
                end
            elseif keyJustPressed('ui_up') then
                if selectedButton == 'none' or selectedButton == 'resume' then
                    selectedButton = 'exit'
                elseif selectedButton == 'restart' then
                    selectedButton = 'resume'
                elseif selectedButton == 'exit' then
                    selectedButton = 'restart'
                end
            end
        end

        if keyboardJustPressed('BACKSPACE') then
            runTimer('closePauseState', transitionTime)

            Destroy()
        end

        if keyboardJustPressed('O') then
            runHaxeCode([[
                import options.OptionsState;
                import backend.MusicBeatState;
                MusicBeatState.switchState(new OptionsState());
            ]])
        end

        if keyboardJustPressed('R') then
            --restartSong()
        end

        --if getProperty('mouse.alpha') > 0.99 or isMobile then
            if getMouseX('other') > 3 and getMouseX('other') < 319 then
                canClickMouse = true

                if getMouseY('other') > 11 and getMouseY('other') < 11 + 229 then
                    selectedButton = 'resume'
                elseif getMouseY('other') > 243 and getMouseY('other') < 243 + 229 then
                    selectedButton = 'restart'
                elseif getMouseY('other') > 476 and getMouseY('other') < 476 + 229 then
                    selectedButton = 'exit'
                else
                    canClickMouse = false
                end
            else
                canClickMouse = false
            end
        --else
            --canClickMouse = false
        --end

        if mouseClicked() and canClickMouse then
            if selectedButton == 'resume' then
                runTimer('closePauseState', transitionTime)

                Destroy()
            elseif selectedButton == 'restart' then
                restartSong()
            elseif selectedButton == 'exit' then
                exitSong()

                stopSound('pause')
            end
        end

        if keyJustPressed('accept') then
            if selectedButton == 'resume' then
                runTimer('closePauseState', transitionTime)

                Destroy()
            elseif selectedButton == 'restart' then
                restartSong()
            elseif selectedButton == 'exit' then
                exitSong()

                stopSound('pause')
            end
        end

        if lastSelectedButton ~= selectedButton then
            if selectedButton == 'resume' then
                doTweenY('selectionIndicatorPauseThingyMOVE', 'selectionIndicator', 70, selectionTransitionTime, 'quartOut')
                --setProperty('selectionIndicator.y', 70)
            elseif selectedButton == 'restart' then
                doTweenY('selectionIndicatorPauseThingyMOVE', 'selectionIndicator', 300, selectionTransitionTime, 'quartOut')
                --setProperty('selectionIndicator.y', 300)
            elseif selectedButton == 'exit' then
                doTweenY('selectionIndicatorPauseThingyMOVE', 'selectionIndicator', 535, selectionTransitionTime, 'quartOut')
                --setProperty('selectionIndicator.y', 535)
            end

            playSound('selectSound')
        end

        print(getMouseY('other')) -- whereas using print i can just use a command prompt and see it
        print(getMouseX('other')) -- using print because debug print does it BEHIND the pause menu

        lastSelectedButton = selectedButton
        --lastMousePosition = getMouseX() .. getMouseY()
        --hasUsedKeyboard = keyboardJustPressed('ANY')
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'eggSelectionIndicator1' then
        doTweenX('eggSelectionIndicator2', 'selectionIndicator', getProperty('selectionIndicator.x') + selectionIntensity, selectionTime, 'quartOut')
    end

    if tag == 'eggSelectionIndicator2' then
        doTweenX('eggSelectionIndicator1', 'selectionIndicator', getProperty('selectionIndicator.x') - selectionIntensity, selectionTime, 'quartIn')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'closePauseState' then
        closeCustomSubstate('pauseState')
    end

    if tag == 'bouncePause' then
        playAnim('icon', 'idle')
    end

    if tag == 'pauseCooldown' then
        canPause = true
    end

    if tag == 'addDeathsPause' then
        if not prettyPleaseSTOP then
            doTweenX('eggPauseDeaths', 'pauseDeaths', -50, transitionTime * 2, 'quartOut')
        end
    end
end

function onPause()
    if not disablePauseMenu then
        if canPause then
            openCustomSubstate('pauseState', true)
        end

        return Function_Stop
    end
end