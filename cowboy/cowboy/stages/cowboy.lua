function onCreate()
    makeLuaSprite('bg', 'background3', -490, -100) -- fun fact: background3 was originally bg.png
    --setProperty('bg.antialiasing', false) -- antialiasing on because u can just disable it in psych
    scaleObject('bg', 0.54, 0.54)
    addLuaSprite('bg')

    makeLuaSprite('big-boom', 'teleporter', 295, 585)
    setProperty('big-boom.antialiasing', false)
    setProperty('big-boom.visible', false)
    scaleObject('big-boom', 8.5, 8.5)
    addLuaSprite('big-boom')

    makeLuaSprite('big-tuh-un-tuh', 'tnt-pile', 900, -300)
    setProperty('big-tuh-un-tuh.antialiasing', false)
    setProperty('big-tuh-un-tuh.visible', false)
    scaleObject('big-tuh-un-tuh', 8.5, 8.5)
    addLuaSprite('big-tuh-un-tuh')
end