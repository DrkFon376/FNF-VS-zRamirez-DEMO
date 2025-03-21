--this stuff is from smoothed icons by SadSami
local objectOrder = 2000 -- I hate psych engine 0.7 --Yeah, I hate that too :/
local smoothBar = true -- If the health bar is faulty, turn it off
function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end
function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
function onCreatePost()
	if smoothBar == true then
	makeLuaSprite('fakeBarDAD','',0,0)
	makeGraphic('fakeBarDAD','593','11','FFFFFF')
	setProperty('fakeBarDAD.color', getIconColor('dad'))
        setObjectCamera('fakeBarDAD','hud')
	setObjectOrder('fakeBarDAD', objectOrder)
	addLuaSprite('fakeBarDAD')

	makeLuaSprite('fakeBarBF','',0,0)
	makeGraphic('fakeBarBF','593','11','FFFFFF')
	setProperty('fakeBarBF.color', getIconColor('boyfriend'))
	setProperty('fakeBarBF.flipX', true)
        setObjectCamera('fakeBarBF','hud')
	setObjectOrder('fakeBarBF', objectOrder+1)
	addLuaSprite('fakeBarBF')
end
mal = getProperty('iconP1.animation.name')
frame = getProperty('iconP1.width')
if mal:sub(1, 5) == 'icon-' then
	makeAnimatedLuaSprite('simge1',nil, getProperty('iconP1.x'), getProperty('iconP1.y'))
	loadGraphic('simge1','icons/'..mal, frame)
	addAnimation('simge1','icons/'..mal, {0, 1}, 0, true)
	setProperty('simge1.flipX',true)
	setObjectCamera('simge1','hud')
	addLuaSprite('simge1')
	setObjectOrder('simge1', objectOrder+2)
else
	makeAnimatedLuaSprite('simge1',nil, getProperty('iconP1.x'), getProperty('iconP1.y'))
	loadGraphic('simge1','icons/icon-'..mal, frame)
	addAnimation('simge1','icons/icon-'..mal, {0, 1}, 0, true)
	setProperty('simge1.flipX',true)
	setObjectCamera('simge1', 'hud')
	addLuaSprite('simge1')
	setObjectOrder('simge1', objectOrder+2)
end
mal2 = getProperty('iconP2.animation.name')
frame2 = getProperty('iconP2.width')
if mal2:sub(1, 5) == 'icon-' then
	makeAnimatedLuaSprite('simge2',nil, getProperty('iconP2.x'), getProperty('iconP2.y'))
	loadGraphic('simge2','icons/'..mal2, frame2)
	addAnimation('simge2','icons/'..mal2, {0, 1}, 0, true)
	setProperty('simge2.flipX',false)
	setObjectCamera('simge2','hud')
	addLuaSprite('simge2')
	setObjectOrder('simge2', objectOrder+3)
else
	makeAnimatedLuaSprite('simge2',nil, getProperty('iconP2.x'), getProperty('iconP2.y'))
	loadGraphic('simge2','icons/icon-'..mal2, frame2)
	addAnimation('simge2','icons/icon-'..mal2, {0, 1}, 0, true)
	setProperty('simge2.flipX',false)
	setObjectCamera('simge2', 'hud')
	addLuaSprite('simge2')
	setObjectOrder('simge2', objectOrder+3)
end
	setObjectOrder('scoreTxt', objectOrder+4)
end
function onEvent(n)
	if n == 'Change Character' then
	setProperty('fakeBarBF.color', getIconColor('boyfriend'))
	setProperty('fakeBarDAD.color', getIconColor('dad'))
mal = getProperty('iconP1.animation.name')
frame = getProperty('iconP1.width')
if mal:sub(1, 5) == 'icon-' then
	makeAnimatedLuaSprite('simge1',nil, getProperty('iconP1.x'), getProperty('iconP1.y'))
	loadGraphic('simge1','icons/'..mal, frame)
	addAnimation('simge1','icons/'..mal, {0, 1}, 0, true)
	setProperty('simge1.flipX',true)
	setObjectCamera('simge1','hud')
	addLuaSprite('simge1')
	setObjectOrder('simge1', objectOrder+2)
else
	makeAnimatedLuaSprite('simge1',nil, getProperty('iconP1.x'), getProperty('iconP1.y'))
	loadGraphic('simge1','icons/icon-'..mal, frame)
	addAnimation('simge1','icons/icon-'..mal, {0, 1}, 0, true)
	setProperty('simge1.flipX',true)
	setObjectCamera('simge1', 'hud')
	addLuaSprite('simge1')
	setObjectOrder('simge1', objectOrder+2)
end
mal2 = getProperty('iconP2.animation.name')
frame2 = getProperty('iconP2.width')
if mal2:sub(1, 5) == 'icon-' then
	makeAnimatedLuaSprite('simge2',nil, getProperty('iconP2.x'), getProperty('iconP2.y'))
	loadGraphic('simge2','icons/'..mal2, frame2)
	addAnimation('simge2','icons/'..mal2, {0, 1}, 0, true)
	setProperty('simge2.flipX',false)
	setObjectCamera('simge2','hud')
	addLuaSprite('simge2')
	setObjectOrder('simge2', objectOrder+3)
else
	makeAnimatedLuaSprite('simge2',nil, getProperty('iconP2.x'), getProperty('iconP2.y'))
	loadGraphic('simge2','icons/icon-'..mal2, frame2)
	addAnimation('simge2','icons/icon-'..mal2, {0, 1}, 0, true)
	setProperty('simge2.flipX',false)
	setObjectCamera('simge2', 'hud')
	addLuaSprite('simge2')
	setObjectOrder('simge2', objectOrder+3)
end
	setObjectOrder('scoreTxt', objectOrder+4)

end
end
function onBeatHit()
	scaleObject('iconP1',1,1)
	scaleObject('iconP2',1,1)
	setProperty('simge1.x',getProperty('simge1.x')+getProperty('simge1.width')/10)
	setProperty('simge2.x',getProperty('simge2.x')-getProperty('simge2.width')/10)
	setProperty('simge1.scale.x', 1.2)
	setProperty('simge1.scale.y', 1.2)
	setProperty('simge2.scale.x', 1.2)
	setProperty('simge2.scale.y', 1.2)
end
function onUpdatePost(elapsed)
	setProperty('iconP1.alpha',0)
	setProperty('iconP2.alpha',0)
	setProperty('simge1.x', lerp(getProperty('iconP1.x'),getProperty('simge1.x'),math.exp(-elapsed * 9 * getProperty('playbackRate'))))
	setProperty('simge1.y', getProperty('iconP1.y'))
	setProperty('simge2.x', lerp(getProperty('iconP2.x'),getProperty('simge2.x'),math.exp(-elapsed * 9 * getProperty('playbackRate'))))
	setProperty('simge2.y', getProperty('iconP2.y'))

	setProperty('simge1.angle', getProperty('iconP1.angle'))
	setProperty('simge2.angle', getProperty('iconP2.angle'))

	setProperty('simge1.scale.x', lerp(1, getProperty('simge1.scale.x'), math.exp(-elapsed * 9 * getProperty('playbackRate'))))
	setProperty('simge1.scale.y', lerp(1, getProperty('simge1.scale.y'), math.exp(-elapsed * 9 * getProperty('playbackRate'))))
	setProperty('simge2.scale.x', lerp(1, getProperty('simge2.scale.x'), math.exp(-elapsed * 9 * getProperty('playbackRate'))))
	setProperty('simge2.scale.y', lerp(1, getProperty('simge2.scale.x'), math.exp(-elapsed * 9 * getProperty('playbackRate'))))
	if smoothBar == true then
	setProperty('fakeBarBF._frame.frame.width', lerp((getProperty('health')/2)*593,getProperty('fakeBarBF._frame.frame.width'),math.exp(-elapsed * 9 * getProperty('playbackRate'))))

	setProperty('fakeBarBF.x', getProperty('healthBarBG.x')+4)
	setProperty('fakeBarDAD.x', getProperty('healthBarBG.x')+4)
	setProperty('fakeBarBF.y', getProperty('healthBarBG.y')+4)
	setProperty('fakeBarDAD.y', getProperty('healthBarBG.y')+4)

	if getProperty('fakeBarBF._frame.frame.width') > 593 then
	setProperty('fakeBarBF._frame.frame.width', 593)
end
end
	if getProperty('health') > 1.6 then
		setProperty('simge2.animation.curAnim.curFrame', '1')
end
	if getProperty('health') < 1.6 then
		setProperty('simge2.animation.curAnim.curFrame', '0')
end
	if getProperty('health') < 0.4 then
		setProperty('simge1.animation.curAnim.curFrame', '1')
end
	if getProperty('health') > 0.4 then
		setProperty('simge1.animation.curAnim.curFrame', '0')
end
end
--lerp(0, getProperty('sical.x'), math.exp(-elapsed * 9 * getProperty('playbackRate')))
function lerp(a, b, ratio)
	return a + ratio * (b - a); --the funny lerp
end