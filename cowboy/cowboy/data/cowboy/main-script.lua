-- script by scrambled_egg3

local normalCameraSpeed = 1

local newCamX = 0
local newCamY = 0

local loopa = 0

local isRayAllowedToFuckingSwearInMyChristianYouTubeChannel = true

function onCreate()
	setProperty('skipCountdown', true)
end

function onCreatePost()
	isRayAllowedToFuckingSwearInMyChristianYouTubeChannel = getModSetting('isRayAllowedToFuckingSwearInMyChristianYouTubeChannel')

	makeLuaSprite('blackCover', 'black', 0, 0)
	setObjectCamera('blackCover', 'other')
	addLuaSprite('blackCover', true)

	makeLuaSprite('obj', 'black', getCameraFollowX() - 175 + 80 - 250 + 190, getCameraFollowY() - 437 + 60 + 450)
	-- camera X through an object so i can tween it without janky code

	normalCameraSpeed = getProperty('cameraSpeed')
	setProperty('cameraSpeed', 999)
	setProperty('isCameraOnForcedPos', true) -- the power of looking through the source code
end

function onUpdate(elapsed)
	if curStep < 15 then
        setProperty('camHUD.alpha', 0)
	end

	if curStep > 165 and curStep < 175 then
        doTweenAlpha('wowShowTheFreakingHudYo', 'camHUD', 1, 0.1)
	end

	--debugPrint(getCameraFollowX()) -- only left here to get rays X after i make his character
	--debugPrint(getCameraFollowY())

	if curStep < 191 then
		setCameraFollowPoint(getProperty('obj.x'), getProperty('obj.y'))
		setProperty('cameraSpeed', 999)
	end

	if curStep > 1234 then
		setCameraFollowPoint(getProperty('obj.x'), getCameraFollowY())
		setProperty('cameraSpeed', 999)
	end
end

function onSectionHit()
	if curStep < 128 then
		setProperty('cameraSpeed', 0.0000000005)
	elseif curStep == 128 then
        doTweenAlpha('wowShowTheFreakingHudYo', 'camHUD', 1, playbackDelta)
	end
end

function onStepHit()
	if curStep == 14 then
		doTweenX('tweenCameraX', 'obj', getProperty('obj.x') - 70 - 190, 8 * playbackDelta, 'quartInOut')
		doTweenY('tweenCameraY', 'obj', getProperty('obj.y') - 10, 8 * playbackDelta, 'quartInOut')

        doTweenZoom('camZoomEvent', 'game', 0.9, 6 * playbackDelta, 'quartInOut')
	end

	if not isRayAllowedToFuckingSwearInMyChristianYouTubeChannel then
		if curStep > 104 and curStep < 107 then
			setProperty('opponentVocals.volume', 0) -- the power of looking through the source code (x2)
		end

		if curStep == 105 then
			playSound('filter', 1.25)
		end

		if curStep > 107 and curStep < 115 then
			setProperty('opponentVocals.volume', 1) -- the power of looking through the source code (x2)
		end
	end
	
	if curStep == 112 then
		doTweenX('tweenCameraX', 'obj', 367.5, 3 * playbackDelta, 'quartInOut')
		doTweenY('tweenCameraY', 'obj', 600, 3 * playbackDelta, 'quartInOut')
	end

	if curStep == 191 then
		setProperty('isCameraOnForcedPos', false)
		setProperty('cameraSpeed', normalCameraSpeed)
	end

	if curStep == 1212 then
		setProperty('isCameraOnForcedPos', false)
		setProperty('cameraSpeed', normalCameraSpeed)
	end

	if curStep == 1216 then
		triggerEvent('Hide HUD', "1", tostring(playbackDelta))
	end

	if curStep == 1235 then
		setProperty('obj.x', 380)
		setProperty('cameraSpeed', 999)
		setProperty('isCameraOnForcedPos', true) -- the power of looking through the source code (x3)
    	setProperty('big-tuh-un-tuh.visible', true)

    	setProperty('big-boom.visible', true)
		doTweenAngle('rotateBoom', 'big-boom', 34.2, 0.8 * playbackDelta, 'quadOut')
		doTweenX('xBoom', 'big-boom', getProperty('big-boom.x') + 105, 0.8 * playbackDelta, 'quadOut')
		doTweenX('objTween', 'obj', getProperty('obj.x') + 400, stepCrochet / 1000 * 7 * playbackDelta, 'quadIn')

		doTweenX('bfTween', 'boyfriend', getProperty('boyfriend.x') + 128, stepCrochet / 1000 * 3 * playbackDelta, 'quartIn')
        startTween('cowboyXTween', 'boyfriend.scale', {x = 0.0001}, stepCrochet / 1000 * 3 * playbackDelta, {ease = 'quartIn'})
	end

	if curStep == 1239 then
		triggerEvent('Play Animation', 'back', 'BF')
		doTweenX('bf2Tween', 'boyfriend', getProperty('boyfriend.x') - 128, stepCrochet / 1000 * 3 * playbackDelta, 'quartOut')
        startTween('cowboyXTween2', 'boyfriend.scale', {x = 1}, stepCrochet / 1000 * 3 * playbackDelta, {ease = 'quartOut'})
	end

	if curStep == 1242 then
    	setProperty('boyfriend.visible', false)
    	setProperty('dad.visible', false)
    	setProperty('big-boom.visible', false)
    	setProperty('bg.visible', false)
    	setProperty('big-tuh-un-tuh.visible', false)
	end

	-- steps 1235 to 1240 for big booms
	-- 0.75s total (2:41.10 to 2:41.85)
end

function onSongStart()
	playbackDelta = 1 / playbackRate

	doTweenAlpha('blackCoverHide', 'blackCover', 0, crochet / 125 * playbackDelta, 'quartOut')
end