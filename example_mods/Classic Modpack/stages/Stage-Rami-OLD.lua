--Stage hecha por zRamirez
function onCreate()
	--Partes del stage
	makeLuaSprite('stageback', 'StageOLD/StageBack', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'StageOLD/StageFront', -200, 1050);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

    makeLuaSprite('mueble', 'StageOLD/StageMueble', 627, 699);
    setLuaSpriteScrollFactor('mueble', 1.0, 1.0);
    scaleObject('mueble', 1.0, 1.0);

    if not lowQuality then
	    makeLuaSprite('adornos', 'StageOLD/Adornos', -110, 300);
	    setLuaSpriteScrollFactor('adornos', 1.0, 1.0);
	    scaleObject('adornos', 1.0, 1.0);

    end

	addLuaSprite('stageback', false);	
	addLuaSprite('stagefront', false);
    addLuaSprite('mueble', false);
	addLuaSprite('adornos', false);
	addLuaSprite('extra', false);

	close(true);
end