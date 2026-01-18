-- script by scrambled_egg3

function onCreatePost()
	makeLuaSprite('blackCover', 'black', 0, 0)
	setObjectCamera('blackCover', 'other')
	addLuaSprite('blackCover', true)

	makeLuaSprite('obj', 'black', getCameraFollowX(), getCameraFollowY())

    setProperty('boyfriend.visible', false)
    setCharacterX('bf', getCharacterX('bf') + 120)
    setScrollFactor('gf', 1, 1)

    setOnScripts('targetGF', false)
end

function onUpdate(elapsed)
    if curStep < 144 then
        if curStep < 143 then
	        setProperty('cameraSpeed', 999)
        else
	        setProperty('cameraSpeed', 1)
        end

	    setProperty('isCameraOnForcedPos', true)
        setCameraFollowPoint(getProperty('obj.x'), getProperty('obj.y'))

        doTweenAlpha('wowHideTheFreakingHudYo', 'camHUD', 0, elapsed * 0.9)
    elseif curStep == 145 then
	    setProperty('isCameraOnForcedPos', true)
    end
end

function onCreate()
	setProperty('skipCountdown', true)
end

function goodNoteHit(index, noteData, noteType, isSustain)
    if noteType == 'Blythe Sing' then
        if curStep < 1132 or curStep > 1168 then
            targetBlythe = true
            setOnScripts('targetGF', targetBlythe)
        end
    elseif noteType == '' then
        targetBlythe = false
        setOnScripts('targetGF', targetBlythe)
    end
end

function opponentNoteHit(index, noteData, noteType, isSustain)
    targetBlythe = false
    setOnScripts('targetGF', targetBlythe)
end

function onStepHit()
    if curStep == 32 then
        doTweenX('objTweenX', 'obj', getProperty('obj.x') - 300, crochet / 125, 'quartInOut')
        doTweenY('objTweenY', 'obj', getProperty('obj.y') + 100, crochet / 125, 'quartInOut')
    end

    if curStep == 80 then
        setProperty('boyfriend.visible', true)

        doTweenX('objTweenX', 'obj', getProperty('obj.x') + 300, crochet / 125, 'quartInOut')
        doTweenY('objTweenY', 'obj', getProperty('obj.y') - 25, crochet / 125, 'quartInOut')
    end

    if curStep == 768 then
        setProperty('millie.visible', true)

        doTweenX('millieX', 'millie', getProperty('millie.x') + 150, 1, 'quartOut')
        doTweenAngle('millieAngle', 'millie', 20, 1, 'quartOut')
    end

    if curStep == 780 then
        doTweenX('millieX2', 'millie', getProperty('millie.x') - 150, 0.85, 'quartIn')
        doTweenAngle('millieAngle', 'millie', 0, 0.85, 'quartIn')
    end

    if curStep == 1296 then
        doTweenAlpha('blackCoverHide', 'blackCover', 1, 2.5)
    end
end

function onTweenCompleted(tag, vars)
    if tag == 'millieX2' then
        setProperty('millie.visible', false)
    end
end

function onBeatHit()
    if curStep > 80 then
        setProperty('boyfriend.visible', true) -- i sell skipping and skipping accessories
    end
end

function onSongStart()
    playbackDelta = 1 / playbackRate

    doTweenAlpha('blackCoverHide', 'blackCover', 0, 5, 'quartOut')
end