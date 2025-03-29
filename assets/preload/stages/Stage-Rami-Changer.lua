--Stage hecha por zRamirez
function onCreate()
	--Partes del stage
	makeLuaSprite('stageback', 'StageHotfix/StageBack', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'StageHotfix/StageFront', -208, 1031);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

    makeLuaSprite('mueble', 'StageHotfix/StageMueble', 569, 607);
    setLuaSpriteScrollFactor('mueble', 1.0, 1.0);
    scaleObject('mueble', 1.1, 1.1);

    if not lowQuality then
	    makeLuaSprite('adornos', 'StageHotfix/Adornos', -110, 305);
	    setLuaSpriteScrollFactor('adornos', 1.0, 1.0);
	    scaleObject('adornos', 1.0, 1.0);

		makeLuaSprite('extra', 'StageHotfix/StageExtra2', 290, 715);
		setLuaSpriteScrollFactor('extra', 1.0, 1.0);
		scaleObject('extra', 1.0, 1.0);

		makeLuaSprite('luz', 'StageHotfix/idk', -200, 0);
		setLuaSpriteScrollFactor('luz', 1.0, 1.0);
		scaleObject('luz', 1.0, 1.0);
		setProperty('luz.alpha', 0.2);
    end
	
	--old stage assets
	makeLuaSprite('stagebackold', 'StageHotfix/StageBackOLD', -200, 0);
	setLuaSpriteScrollFactor('stagebackold', 1.0, 1.0);
	scaleObject('stagebackold', 1.0, 1.0);

	makeLuaSprite('stagefrontold', 'StageHotfix/StageFrontOLD', -200, 1050);
	setLuaSpriteScrollFactor('stagefrontold', 1.0, 1.0);
	scaleObject('stagefrontold', 1.0, 1.0);

	makeLuaSprite('muebleold', 'StageHotfix/StageMuebleOLD', 586, 699);
    setLuaSpriteScrollFactor('muebleold', 1.0, 1.0);
    scaleObject('muebleold', 1.0, 1.0);

    if not lowQuality then
	    makeLuaSprite('adornosold', 'StageHotfix/AdornosOLD', -110, 300);
	    setLuaSpriteScrollFactor('adornosold', 1.0, 1.0);
	    scaleObject('adornosold', 1.0, 1.0);

		makeLuaSprite('extraold', 'StageHotfix/StageExtra2OLD', 265, 735);
		setLuaSpriteScrollFactor('extraold', 1.0, 1.0);
		scaleObject('extraold', 1.0, 1.0);
	end

	addLuaSprite('stageback', false);	
	addLuaSprite('stagefront', false);
    addLuaSprite('mueble', false);
	addLuaSprite('adornos', false);
	addLuaSprite('extra', false);
	addLuaSprite('stagebackold', false);	
	addLuaSprite('stagefrontold', false);
    addLuaSprite('muebleold', false);
	addLuaSprite('adornosold', false);
	addLuaSprite('extraold', false);
	addLuaSprite('luz', true);

	setProperty('stageback.visible', false);
	setProperty('stagefront.visible', false);
	setProperty('mueble.visible', false);
	setProperty('adornos.visible', false);
	setProperty('extra.visible', false);

end
function onEvent(name,value1,value2)
	if name == 'Change Stage' then 
		
		if value1 == 'old' then
			setProperty('stageback.visible', false);
			setProperty('stagefront.visible', false);
			setProperty('mueble.visible', false);
			setProperty('adornos.visible', false);
			setProperty('extra.visible', false);
			setProperty('stagebackold.visible', true);
			setProperty('stagefrontold.visible', true);
			setProperty('muebleold.visible', true);
			setProperty('adornosold.visible', true);
			setProperty('extraold.visible', true);

		end

		if value1 == 'new' then
			setProperty('stageback.visible', true);
			setProperty('stagefront.visible', true);
			setProperty('mueble.visible', true);
			setProperty('adornos.visible', true);
			setProperty('extra.visible', true);
			setProperty('stagebackold.visible', false);
			setProperty('stagefrontold.visible', false);
			setProperty('muebleold.visible', false);
			setProperty('adornosold.visible', false);
			setProperty('extraold.visible', false);


		end
	end
end