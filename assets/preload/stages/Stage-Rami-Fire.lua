--Stage hecha por zRamirez
function onCreate()
	--Partes del stage
        makeAnimatedLuaSprite('Fondo', 'StageZFire/Fondo-Stage', 466, 147);
        addAnimationByPrefix('Fondo', 'idle', 'MIFONDOENLLAMAS0', 24, true);
        scaleObject('Fondo', 1.0, 1.0);

	makeLuaSprite('stageback', 'StageZFire/StageBack', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'StageZFire/StageFront', -208, 1031);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

    makeLuaSprite('mueble', 'StageZFire/Mueble', 569, 641);
    setLuaSpriteScrollFactor('mueble', 1.0, 1.0);
    scaleObject('mueble', 1.1, 1.1);

	if not lowQuality then
		makeLuaSprite('adornos', 'StageZFire/StageExtra', -110, 305);
		setLuaSpriteScrollFactor('adornos', 1.0, 1.0);
		scaleObject('adornos', 1.0, 1.0);

		makeLuaSprite('extra', 'StageZFire/StageExtra2', 290, 715);
		setLuaSpriteScrollFactor('extra', 1.0, 1.0);
		scaleObject('extra', 1.0, 1.0);

		makeLuaSprite('luz', 'StageZFire/BLURE', 0, 0);
	    setGraphicSize('luz',1280,720)
	    setObjectCamera('luz','camOther')
        updateHitbox('luz')
        setProperty('luz.alpha', 0.5)
	end

    makeAnimatedLuaSprite('Fire', 'StageZFire/Fire', -200, 900);
    addAnimationByPrefix('Fire', 'idle', 'Stage fuego0', 24, true);

	
	addLuaSprite('Fondo', false);
	addLuaSprite('stageback', false);	
	addLuaSprite('stagefront', false);
    addLuaSprite('mueble', false);
	addLuaSprite('adornos', false);
	addLuaSprite('extra', false);
	addLuaSprite('Fire', true);
	addLuaSprite('luz', true);
end