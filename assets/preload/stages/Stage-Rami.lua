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

	addLuaSprite('stageback', false);	
	addLuaSprite('stagefront', false);
    addLuaSprite('mueble', false);
	addLuaSprite('adornos', false);
	addLuaSprite('extra', false);
	addLuaSprite('luz', true);
end