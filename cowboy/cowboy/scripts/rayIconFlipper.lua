function onBeatHit()
    if dadName == 'ray' then
        IconFlipX = getProperty('iconP2.flipX')
        if IconFlipX then
            setProperty('iconP2.flipX', false)
        else
            setProperty('iconP2.flipX', true)
        end
    end
end
