--Stage hecha por zRamirez
function onCreate()
	--Partes del stage
	makeLuaSprite('stageback', 'StageZOld/StageBack', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'StageZOld/StageFront', -200, 1050);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

    makeLuaSprite('mueble', 'StageZOld/StageMueble', 627, 699);
    setLuaSpriteScrollFactor('mueble', 1.0, 1.0);
    scaleObject('mueble', 1.0, 1.0);

    if not lowQuality then
	    makeLuaSprite('adornos', 'StageZOld/Adornos', -110, 300);
	    setLuaSpriteScrollFactor('adornos', 1.0, 1.0);
	    scaleObject('adornos', 1.0, 1.0);

		makeLuaSprite('extra', 'StageZOld/StageExtra2', 265, 735);
		setLuaSpriteScrollFactor('extra', 1.0, 1.0);
		scaleObject('extra', 1.0, 1.0);
    end

	addLuaSprite('stageback', false);	
	addLuaSprite('stagefront', false);
    addLuaSprite('mueble', false);
	addLuaSprite('adornos', false);

	close(true);
end