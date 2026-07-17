function onCreate()
    makeLuaSprite('bg', 'bg-new', -360, -60)
    --setProperty('bg.antialiasing', false) -- antialiasing on because u can just disable it in psych
    scaleObject('bg', 0.55, 0.55)
    addLuaSprite('bg')

    makeLuaSprite('millie', 'MILLIE', 585, 515)
    setProperty('millie.visible', false)
    scaleObject('millie', 0.4, 0.4)
    addLuaSprite('millie')
end