-- ts script so peak
-- each note is 112 pixels away from eachother

local appaBounceSpeed = 0.25
local shouldStartDown = false

local flashingLightsSwapped = true -- this isnt actually swapped i just coded it swapped on accident and im undoing it

local minRange = 25 - 25
local maxRange = 115 - 25

local isJumpscaring = false
local isSniffing = false

function onCreatePost()
    if downscroll then
        downscrollOffset = -565
    else
        downscrollOffset = 0
    end

    if flashingLights then
        flashingLightsSwapped = false
    end

    makeLuaSprite('appaHealth', 'APPA', 0, 530 + downscrollOffset)
    setObjectCamera('appaHealth', 'hud')
    scaleObject('appaHealth', 0.7, 0.7)
    addLuaSprite('appaHealth')
    setObjectOrder('appaHealth', 6)

    makeLuaSprite('appaNote', 'APPA', 0, 0) -- -25 = on the note, -116 = off the screen (top)
    setObjectCamera('appaNote', 'hud')      -- 615 = on the note (downscroll), 720 = off screen (butt)
    scaleObject('appaNote', 0.45, 0.45)
    if downscroll then
        setProperty('appaNote.y', 615)
        setProperty('appaNote.flipY', false)
    else
        setProperty('appaNote.y', -25)
    end
    setProperty('appaNote.alpha', 0)
    addLuaSprite('appaNote', true)
    
    makeLuaSprite('appaSNIFF', 'APPA', 500, 0)
    scaleObject('appaSNIFF', 2, 2)
    setObjectCamera('appaSNIFF', 'other')
    setProperty('appaSNIFF.alpha', 0)
    addLuaSprite('appaSNIFF', true)

    if luaSpriteExists('pauseBack') then
        setObjectOrder('appaSNIFF', getObjectOrder('pauseBack') - 1)
    end
    
    makeLuaSprite('churuJumpscare', 'churu-OG', 0, 0)
    setObjectCamera('churuJumpscare', 'other')
    setProperty('churuJumpscare.alpha', 0)
    addLuaSprite('churuJumpscare', true)
    
    makeLuaSprite('appaJumpscare', 'appa', 0, 0)
    setObjectCamera('appaJumpscare', 'other')
    setProperty('appaJumpscare.alpha', 0)
    scaleObject('appaJumpscare', 5, 2.8125)
    addLuaSprite('appaJumpscare', true)

    if luaSpriteExists('pauseBack') then
        setObjectOrder('churuJumpscare', getObjectOrder('pauseBack') - 1)
        setObjectOrder('appaJumpscare', getObjectOrder('pauseBack') - 1)
    end

    makeLuaSprite('churuHealth', 'chuchuFIXED', 330, 595)

    setProperty('churuHealth.x', -400)
    setProperty('churuHealth.y', 300 + downscrollOffset)
    setProperty('churuHealth.angle', 48)

    setObjectCamera('churuHealth', 'hud')
    scaleObject('churuHealth', 0.53, 0.4)
    addLuaSprite('churuHealth')
    setObjectOrder('churuHealth', 8 + 11) -- 11 * 2 = appa amount * 2 (because of the churu textures too)
     
    makeLuaSprite('whiteCover', 'white', 0, 0)
    setObjectCamera('whiteCover', 'other')
    setProperty('whiteCover.alpha', 0)
    addLuaSprite('whiteCover', true)
   
    setProperty('appaHealth.x', getProperty('appaHealth.x') - 180)
    setProperty('churuHealth.x', getProperty('churuHealth.x') - 180)

    runHaxeCode([[
        import psychlua.FunkinLua;

        // "i haven't mastered haxe/hscript but i can definitely work with it"
        // i said, right before i starting locking in on the code

        // also this was originally written for blythe sing so go check that out

        var ZERORGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[0];
        var UNORGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[1];
        var TWORGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[2];
        var TRESRGBValues:Array<FlxColor> = ClientPrefs.data.arrowRGB[3];

        var ZEROR:Int = ZERORGBValues[0];
        var ZEROG:Int = ZERORGBValues[1];
        var ZEROB:Int = ZERORGBValues[2];

        var UNOR:Int = UNORGBValues[0];
        var UNOG:Int = UNORGBValues[1];
        var UNOB:Int = UNORGBValues[2];

        var TWOR:Int = TWORGBValues[0];
        var TWOG:Int = TWORGBValues[1];
        var TWOB:Int = TWORGBValues[2];

        var TRESR:Int = TRESRGBValues[0];
        var TRESG:Int = TRESRGBValues[1];
        var TRESB:Int = TRESRGBValues[2];
        
        setOnScripts('ZEROR', ZEROR);
        setOnScripts('ZEROG', ZEROG);
        setOnScripts('ZEROB', ZEROB);
        
        setOnScripts('UNOR', UNOR);
        setOnScripts('UNOG', UNOG);
        setOnScripts('UNOB', UNOB);
        
        setOnScripts('TWOR', TWOR);
        setOnScripts('TWOG', TWOG);
        setOnScripts('TWOB', TWOB);
        
        setOnScripts('TRESR', TRESR);
        setOnScripts('TRESG', TRESG);
        setOnScripts('TRESB', TRESB);
    ]])
end

function onCountdownStarted()
    setProperty('appaNote.x', defaultPlayerStrumX0)
    
    if not downscroll then
        doTweenY('appaNoteBounce1', 'appaNote', getProperty('appaNote.y') - 25, appaBounceSpeed, 'quartOut')
    else
        doTweenY('appaNoteBounce1', 'appaNote', getProperty('appaNote.y') + 25, appaBounceSpeed, 'quartOut')
    end
end

function onEvent(event, value1, value2, strumTime)
    if event == 'Z Churu Events' then
        if value1 == '1' then
            doTweenX('appaHealthX', 'appaHealth', getProperty('appaHealth.x') + 180, 1, 'quartOut')
            doTweenX('churuHealthX', 'churuHealth', getProperty('churuHealth.x') + 180, 1, 'quartOut')

        elseif value1 == '2' then
            shouldStartDown = true
            doTweenAlpha('appaNoteAlpha', 'appaNote', 1, appaBounceSpeed * 2, 'quartInOut')
        elseif value1 == '3' then
            if isSniffing then
                cancelTimer('sniffFadeOut')
                stopSound('SNIFF')
            end

            isSniffing = true
            setOnScripts('isSniffing', true)
            playSound('SNIFF', 0.6, 'SNIFF')
            runTimer('sniffFadeOut', 5)
            doTweenAlpha('appaSNIFFAlpha', 'appaSNIFF', 0.85, 1)

            if flashingLightsSwapped then
                setProperty('appaSNIFF.y', getRandomInt(0, 200))
                setProperty('appaSNIFF.x', getRandomInt(300, 700))
                setProperty('appaSNIFF.scale.x', getRandomInt(2, 4))
                setProperty('appaSNIFF.scale.y', getRandomInt(2, 4))
            end
        elseif value1 == '4' then
            isJumpscaring = true
            setOnScripts('isJumpscaring', true)
            setProperty('churuJumpscare.alpha', 1)
            doTweenAlpha('churuJumpscareAlpha', 'churuJumpscare', 0, 1)
            playSound('JUMPSCARE', 1, 'JUMPSCARE')
        elseif value1 == '5' then
            isJumpscaring = true
            setOnScripts('isJumpscaring', true)
            setProperty('appaJumpscare.alpha', 1)

            setProperty('dad.visible', false)
            setProperty('boyfriend.visible', false)
            setProperty('bg.visible', false)
            setProperty('camHUD.alpha', 0)

            for i = 1, appaAmount do
                setProperty('bgAppa' .. i .. '.visible', false)
            end

            doTweenAlpha('churuJumpscareAlpha', 'appaJumpscare', 0, 1)
            playSound('JUMPSCARE', 1, 'JUMPSCARE')

        elseif value1 == '6' then
            setSpriteShader('dad', 'white')
            setSpriteShader('boyfriend', 'white')

            for i = 1, appaAmount do
                setSpriteShader('bgAppa' .. i, 'slightlyDarkerThanWhite')
            end

            for i = 0, 3 do
                setPropertyFromGroup('playerStrums', i, 'rgbShader.b', 0xAAAAAA) -- these are the custom note colors
                setPropertyFromGroup('playerStrums', i, 'rgbShader.g', 0xDDDDDD)
                setPropertyFromGroup('playerStrums', i, 'rgbShader.r', 0xFFFFFF)

                setPropertyFromGroup('opponentStrums', i, 'rgbShader.b', 0xAAAAAA)
                setPropertyFromGroup('opponentStrums', i, 'rgbShader.g', 0xDDDDDD)
                setPropertyFromGroup('opponentStrums', i, 'rgbShader.r', 0xFFFFFF)
            end
        elseif value1 == '7' then
            removeSpriteShader('dad')
            removeSpriteShader('boyfriend')

            for i = 1, appaAmount do
                removeSpriteShader('bgAppa' .. i)
            end

            for i = 0, 3 do
                if i == 0 then
                    defaultR = ZEROR -- all of these are defined at the end of onCreatePost()
                    defaultG = ZEROG
                    defaultB = ZEROB
                elseif i == 1 then
                    defaultR = UNOR
                    defaultG = UNOG
                    defaultB = UNOB
                elseif i == 2 then
                    defaultR = TWOR
                    defaultG = TWOG
                    defaultB = TWOB
                elseif i == 3 then
                    defaultR = TRESR
                    defaultG = TRESG
                    defaultB = TRESB
                end

                setPropertyFromGroup('playerStrums', i, 'rgbShader.b', defaultB)
                setPropertyFromGroup('playerStrums', i, 'rgbShader.g', defaultG)
                setPropertyFromGroup('playerStrums', i, 'rgbShader.r', defaultR)

                setPropertyFromGroup('opponentStrums', i, 'rgbShader.b', defaultB)
                setPropertyFromGroup('opponentStrums', i, 'rgbShader.g', defaultG)
                setPropertyFromGroup('opponentStrums', i, 'rgbShader.r', defaultR)
            end
        end
    end
end

function onUpdate(elapsed)
    if isSniffing then
        if not flashingLightsSwapped then
            setProperty('appaSNIFF.y', getRandomInt(0, 200))
            setProperty('appaSNIFF.x', getRandomInt(400, 700))
            setProperty('appaSNIFF.scale.x', getRandomInt(2, 4))
            setProperty('appaSNIFF.scale.y', getRandomInt(2, 4))
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'sniffFadeOut' then
        soundFadeOut('SNIFF', 1, 0)
        doTweenAlpha('appaSNIFFAlpha', 'appaSNIFF', 0, 1)
    end
end

function onPause()
    if isSniffing then
        pauseSound('SNIFF')
    end

    if isJumpscaring then
        pauseSound('JUMPSCARE')
    end
end

function onSoundFinished(tag)
    if tag == 'SNIFF' then
        isSniffing = false
        setOnScripts('isSniffing', false)
    end

    if tag == 'JUMPSCARING' then
        isJumpscaring = false
        setOnScripts('isJumpscaring', false)
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'appaNoteBounce1' then
        if not downscroll then
            doTweenY('appaNoteBounce2', 'appaNote', getProperty('appaNote.y') + 25, appaBounceSpeed, 'quartIn')
        else
            doTweenY('appaNoteBounce2', 'appaNote', getProperty('appaNote.y') - 25, appaBounceSpeed, 'quartOut')
        end
    end

    if tag == 'appaNoteBounce2' then
        if not downscroll then
            doTweenY('appaNoteBounce1', 'appaNote', getProperty('appaNote.y') - 25, appaBounceSpeed, 'quartOut')
        else
            doTweenY('appaNoteBounce1', 'appaNote', getProperty('appaNote.y') + 25, appaBounceSpeed, 'quartIn')
        end

        if shouldStartDown then
            shouldStartDown = false

            if not downscroll then
                noteTweenY('note1Y', 4, 50 + getRandomInt(minRange, maxRange), 0.75, 'quartOut')
            else
                noteTweenY('note1Y', 4, 570 - getRandomInt(minRange, maxRange), 0.75, 'quartOut')
            end
            doTweenX('appaNoteX1', 'appaNote', getProperty('appaNote.x') + 112, appaBounceSpeed * 2, 'quartInOut')
        end
    end

    if tag == 'appaNoteX1' then
        if not downscroll then
            noteTweenY('note2Y', 5, 50 + getRandomInt(minRange, maxRange), 0.75, 'quartOut')
        else
            noteTweenY('note2Y', 5, 570 - getRandomInt(minRange, maxRange), 0.75, 'quartOut')
        end
        doTweenX('appaNoteX2', 'appaNote', getProperty('appaNote.x') + 112, appaBounceSpeed * 2, 'quartInOut')
    elseif tag == 'appaNoteX2' then
        if not downscroll then
            noteTweenY('note3Y', 6, 50 + getRandomInt(minRange, maxRange), 0.75, 'quartOut')
        else
            noteTweenY('note3Y', 6, 570 - getRandomInt(minRange, maxRange), 0.75, 'quartOut')
        end
        doTweenX('appaNoteX3', 'appaNote', getProperty('appaNote.x') + 112, appaBounceSpeed * 2, 'quartInOut')
    elseif tag == 'appaNoteX3' then
        if not downscroll then
            noteTweenY('note4Y', 7, 50 + getRandomInt(minRange, maxRange), 0.75, 'quartOut')
        else
            noteTweenY('note4Y', 7, 570 - getRandomInt(minRange, maxRange), 0.75, 'quartOut')
        end
        if not middlescroll then
            doTweenX('appaNoteX4', 'appaNote', 1280, appaBounceSpeed * 2, 'quartInOut')
        else
            doTweenAlpha('appaNoteAlpha', 'appaNote', 0, appaBounceSpeed * 2, 'quartInOut')
        end
    end
    
    if tag == 'appaHealthX' then
        doTweenAngle('appaHealthAngle', 'appaHealth', 15, 0.5, 'quartIn')

        doTweenX('churu67X', 'churuHealth', 330, 0.5, 'quartIn')
        doTweenY('churu67Y', 'churuHealth', 595 + downscrollOffset, 0.5, 'quartIn')
        doTweenAngle('churu67Angle', 'churuHealth', 0, 0.5, 'quartIn')
    end

    if tag == 'appaHealthAngle' then
        doTweenAngle('appaHealthAngle2', 'appaHealth', 0, 0.5, 'quartOut')

        doTweenColor('iconP1Red', 'iconP1', 'FF0000', 0.00001)
        doTweenColor('iconP2Red', 'iconP2', 'FF0000', 0.00001)

        if not downscroll then
            doTweenY('iconP1Y', 'iconP1', 720, 1)
            doTweenY('iconP2Y', 'iconP2', 720, 1)
        else
            doTweenY('iconP1Y', 'iconP1', -125, 1)
            doTweenY('iconP2Y', 'iconP2', -125, 1)
        end
    end

    if tag == 'appaHealthAngle2' then
        doTweenAlpha('appaHealthAlpha', 'appaHealth', 0, 1)
    end

    if tag == 'iconP1Red' then
        doTweenColor('iconP1Normal', 'iconP1', 'FFFFFF', 1)
        doTweenColor('iconP2Normal', 'iconP2', 'FFFFFF', 1)
    end
end