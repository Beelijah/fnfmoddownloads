local value2 = 1
local isDebuggingScript = 0

-- made by scrambled_egg3
-- if you steal i steal your organs
-- this one you can steal if you credit me

-- WOW REMASTERED VERSION
-- THIS ONE DOESN'T SUCK

function onEvent(name, value1, value2)
    if name == 'Hide HUD' then
        if value1 == "1" then
            doTweenAlpha('wowHideTheFreakingHudYo', 'camHUD', 0, value2)
        elseif value1 == "0" then
            doTweenAlpha('wowShowTheFreakingHudYo', 'camHUD', 1, value2)
        end
    end
end