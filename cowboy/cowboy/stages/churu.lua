local isSecondaryBeat = false
local bounceSpeed = 1
local appaAmount = 11
local appaBounce = 50 / 1.5

function onCreate()
    makeLuaSprite('bg', 'churu', -410, -100)
    --setProperty('bg.antialiasing', false) -- antialiasing on because u can just disable it in psych
    scaleObject('bg', 0.52, 0.52)
    addLuaSprite('bg')

    for i = 1, appaAmount do
        makeLuaSprite('bgAppa' .. i, 'APPA', -500 + i * 200, 430)
        scaleObject('bgAppa' .. i, 0.65, 0.65)
        setProperty('bgAppa' .. i .. '.alpha', 0)
        addLuaSprite('bgAppa' .. i)

        doTweenX('bgAppa' .. i .. 'X', 'bgAppa' .. i, getProperty('bgAppa' .. i .. '.x') - 199 * 2, 1)
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'bgAppa1X' then
        for i = 1, appaAmount do
            setProperty('bgAppa' .. i .. '.x', -500 + i * 200)
            doTweenX('bgAppa' .. i .. 'X', 'bgAppa' .. i, getProperty('bgAppa' .. i .. '.x') - 199 * 2, 1)
        end
    end

    if tag == 'bgAppa2Y' then
        o = 1
        repeat
            doTweenY('bgAppa' .. o .. 'Y', 'bgAppa' .. o, getProperty('bgAppa' .. o .. '.y') - appaBounce, bounceSpeed, 'quartOut')
            --debugPrint('bgAppa' .. o)
            o = o + 2
        until o > appaAmount
        o = 2
        repeat
            doTweenY('bgAppa3' .. o .. 'Y', 'bgAppa' .. o, getProperty('bgAppa' .. o .. '.y') + appaBounce, bounceSpeed, 'quartOut')
            --debugPrint('bgAppa' .. o)
            o = o + 2
        until o > appaAmount
    end

    if tag == 'bgAppa2YZ' then
        o = 1
        repeat
            doTweenY('bgAppa' .. o .. 'Y', 'bgAppa' .. o, getProperty('bgAppa' .. o .. '.y') - appaBounce, bounceSpeed, 'quartOut')
            --debugPrint('bgAppa' .. o)
            o = o + 2
        until o > appaAmount
    end

    if tag == 'bgAppa1Y' then
        o = 2
        repeat
            doTweenY('bgAppa' .. o .. 'Y', 'bgAppa' .. o, getProperty('bgAppa' .. o .. '.y') - appaBounce, bounceSpeed, 'quartOut')
            --debugPrint('bgAppa' .. o)
            o = o + 2
        until o > appaAmount
        o = 1
        repeat
            doTweenY('bgAppa3' .. o .. 'Y', 'bgAppa' .. o, getProperty('bgAppa' .. o .. '.y') + appaBounce, bounceSpeed, 'quartOut')
            --debugPrint('bgAppa' .. o)
            o = o + 2
        until o > appaAmount
    end
end

function onSongStart()
    bounceSpeed = crochet / 1000
    setOnScripts('appaAmount', appaAmount)

    o = 2
    repeat
        doTweenY('bgAppa' .. o .. 'YZ', 'bgAppa' .. o, getProperty('bgAppa' .. o .. '.y'), bounceSpeed, 'quartOut')
        --debugPrint('bgAppa' .. o)
        o = o + 2
    until o > appaAmount
end