--Stage hecha por zRamirez
function onCreate()
	--Partes del stage
	makeLuaSprite('stageback', 'StageZ/StageBack', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'StageZ/StageFront', -200, 1050);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

    makeLuaSprite('mueble', 'StageZ/StageMueble', 586, 699);
    setLuaSpriteScrollFactor('mueble', 1.0, 1.0);
    scaleObject('mueble', 1.0, 1.0);

    if not lowQuality then
	    makeLuaSprite('adornos', 'StageZ/Adornos', -110, 300);
	    setLuaSpriteScrollFactor('adornos', 1.0, 1.0);
	    scaleObject('adornos', 1.0, 1.0);

		makeLuaSprite('extra', 'StageZ/StageExtra2', 265, 735);
		setLuaSpriteScrollFactor('extra', 1.0, 1.0);
		scaleObject('extra', 1.0, 1.0);

		makeLuaSprite('luz', 'StageZ/idk', -200, 0);
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

	close(true);
end