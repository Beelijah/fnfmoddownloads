local raySNIFFING = false

local normalRayX = 0
local normalRayY = 0

function onCreatePost()
    makeLuaSprite('blackCoverThingy', 'black', 0, 0)
    setObjectCamera('blackCoverThingy', 'other')
    setProperty('blackCoverThingy.alpha', 0)
    addLuaSprite('blackCoverThingy', true)

    makeLuaSprite('rayBG', 'rayBG', -300, -150)
    setProperty('rayBG.visible', false)
    scaleObject('rayBG', 0.52, 0.52)
    addLuaSprite('rayBG')

    makeLuaSprite('ray', 'ray', getProperty('dad.x') + 150, getProperty('dad.y') + 125)
    setProperty('ray.visible', false)
    addLuaSprite('ray')

    makeLuaSprite('exc', 'exclamation', getProperty('dad.x') + 450, getProperty('dad.y') + 75)
    setProperty('exc.antialiasing', false)
    setProperty('exc.alpha', 0)
    addLuaSprite('exc', true)
    scaleObject('exc', 2.5, 2.5)
end

function onUpdate(elapsed)
    if raySNIFFING then
        setProperty('ray.x', getRandomInt(normalRayX + 50, normalRayX - 50))
        setProperty('ray.y', getRandomInt(normalRayY + 50, normalRayY - 50))
        setProperty('ray.scale.x', getRandomInt(1, 2))
        setProperty('ray.scale.y', getRandomInt(1, 2))
    end
end

function onStepHit()
    if curStep == 1188 then
        setProperty('cameraSpeed', 1)
        doTweenAlpha('blackCoverThingyAlpha', 'blackCoverThingy', 1, 1)
        doTweenAlpha('HUDAlpha', 'camHUD', 0, 1)
    end

    if curStep == 1198 then
        setProperty('rayBG.visible', true)
        setProperty('ray.visible', true)
        setProperty('bg.visible', false)
        setProperty('dad.visible', false)
        setProperty('boyfriend.visible', false)
    end

    if curStep == 1199 then
        doTweenAlpha('blackCoverThingyAlpha', 'blackCoverThingy', 0, 1)
    end

    if curStep == 1220 then
        -- start sniff

        normalRayX = getProperty('ray.x')
        normalRayY = getProperty('ray.y')
        raySNIFFING = true
    end

    if curStep == 1232 then
        -- end sniff

        raySNIFFING = false
        setProperty('ray.x', normalRayX)
        setProperty('ray.y', normalRayY)
        setProperty('ray.scale.x', 1)
        setProperty('ray.scale.y', 1)
    end

    if curStep == 1240 then
        -- ALERT!
        setProperty('exc.alpha', 1)

        doTweenAlpha('excAlpha', 'exc', 0, 1.25, 'quartOut')
        doTweenAngle('excAngle', 'exc', 30, 1.25, 'quartOut')
        doTweenY('excY', 'exc', getProperty('exc.y') - 25, 0.25, 'quadOut')
        doTweenX('excX', 'exc', getProperty('exc.x') + 10, 1.25, 'quartOut')
    end

    if curStep == 1248 then
        -- start gameplay
        setProperty('rayBG.visible', false)
        setProperty('ray.visible', false)
        setProperty('bg.visible', true)
        setProperty('dad.visible', true)
        setProperty('boyfriend.visible', true)

        setProperty('whiteCover.alpha', 1)
        doTweenAlpha('whiteCoverAlpha', 'whiteCover', 0, 0.85)
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'excY' then
        doTweenY('excY2', 'exc', getProperty('exc.y') + 250, 1, 'quartIn')
    end
end