function onCreate()
	doTweenAlpha('camHUDAlphaTweenOFF', "camHUD", 0, 0.001, 'sineInOut')
end

function onStepHit()
	if curStep == 128 then
		doTweenAlpha('camHUDAlphaTweenON', "camHUD", 1, 0.3625, 'sineInOut')
	end
end
