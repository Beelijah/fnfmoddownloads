-- thank god for splitting up intro.lua and script.lua
-- update: script.lua is now referring to the event script
-- update: also the stage lua file
-- update: also ray-cutscene.lua

local normalCowboyX = 0
local normalCowboyY = 0

local cowboyJumpingJacks = 50 * 1.75
local cowboyJumpingJacksSpeed = 0.15 * 1.75
local cowboyDailyStepsSpeed = 5

local hasStoppedCountdown = false

function onCreate()
    setProperty('skipCountdown', true)
end

function onCreatePost()
    setProperty('camHUD.alpha', 0) -- wow a normal way to set the hud opacity
    setProperty('cameraSpeed', 999)
    setScrollFactor('gf', 1, 1)

    normalCowboyX = getProperty('boyfriend.x')
    normalCowboyY = getProperty('boyfriend.y')

    makeLuaSprite('cam', 'black', 890, getProperty('boyfriend.y') + 150)
    makeLuaSprite('cowboyJumpingJacks', 'black', cowboyJumpingJacks)
    doTweenX('jack', 'cowboyJumpingJacks', 0, cowboyDailyStepsSpeed / 1.5)
    runTimer('END', cowboyDailyStepsSpeed / 6)

    setProperty('boyfriend.x', getProperty('boyfriend.x') + 550)
    --setProperty('dad.x', getProperty('dad.x') - 130)
    --setProperty('dad.y', getProperty('dad.y') - 175)

    doTweenX('camX', 'cam', 890 - 250, cowboyDailyStepsSpeed, 'quartOut')
    doTweenX('walk,YouFatty', 'boyfriend', normalCowboyX, cowboyDailyStepsSpeed, 'quartOut')
    doTweenY('jump,YouFatty', 'boyfriend', getProperty('boyfriend.y') - cowboyJumpingJacks, cowboyJumpingJacksSpeed, 'quartOut')
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'END' then
        startCountdown()
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'jump,YouFatty' then
        doTweenY('jump,YouFatty2', 'boyfriend', getProperty('boyfriend.y') + cowboyJumpingJacks, cowboyJumpingJacksSpeed, 'quartIn')
    end

    if tag == 'jump,YouFatty2' then
        doTweenY('jump,YouFatty', 'boyfriend', getProperty('boyfriend.y') - cowboyJumpingJacks, cowboyJumpingJacksSpeed, 'quartOut')
    end
end

function onStartCountdown()
    if not hasStoppedCountdown then
        hasStoppedCountdown = true

        return Function_Stop
    end
end

function onStepHit()
    if curStep > 31 and curStep < 128 then
        setProperty('cameraSpeed', 1)

        for i = 1, appaAmount do
            if luaSpriteExists('bgAppa' .. i) then
                doTweenAlpha('appaShow' .. i, 'bgAppa' .. i, 1, 1) -- very stupid way of doing it but if you pause a million times then it will break sooooo this is better
            end --                                                    no it isnt im getting null object references now and i have to add a luaSpriteExists() check
        end
    end
end

function onUpdate(elapsed)
    cowboyJumpingJacks = getProperty('cowboyJumpingJacks.x')

    if keyboardJustPressed('R') then
        --restartSong()
    end

    if curStep < 32 then
        -- the max right the camera can go is 890

        setCameraFollowPoint(getProperty('cam.x'), getProperty('cam.y'))
    end
end