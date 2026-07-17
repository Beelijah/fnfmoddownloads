function noteMiss(index, noteData, noteType, isSustain)

    if noteType == 'Blythe Sing' then
        doTweenColor('missThingyColor2', 'gf', '9333ff', 0.0040)
    else
        doTweenColor('missThingyColor', 'boyfriend', '9333ff', 0.0040)
    end
end

function goodNoteHit(index, noteData, noteType, isSustain)
    if noteType == 'Blythe Sing' then
        doTweenColor('missThingyColor2', 'gf', 'ffffff', 0.0040)
    else
        doTweenColor('missThingyColor', 'boyfriend', 'ffffff', 0.0040)
    end
end

function onUpdate(elapsed)
    -- setHealth(2)
    -- ^ I GENUINELY ALMOST FORGOT TO COMMENT THIS OUT OH MY GOD

    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
        doTweenColor('missThingyColor', 'boyfriend', 'ffffff', 0.0040)
    end

    if getProperty('gf.animation.curAnim.name') == 'idle' then
        doTweenColor('missThingyColor2', 'gf', 'ffffff', 0.0040)
    end
end