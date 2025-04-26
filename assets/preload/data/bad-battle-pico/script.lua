function onCreate()
	doTweenAlpha('camHUDAlphaTweenOFF', "camHUD", 0, 0.001, 'sineInOut')
end

function onStepHit()
	if curStep == 112 then
		doTweenAlpha('camHUDAlphaTweenON', "camHUD", 1, 1.1, 'sineInOut')
	end
end
