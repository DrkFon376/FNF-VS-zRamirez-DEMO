--Stage hecha por zRamirez
function onCreate()
	--Partes del stage
        makeAnimatedLuaSprite('Fondo', 'StageZFire/Fondo-Stage', 260, 95);
        addAnimationByPrefix('Fondo', 'idle', 'Drk stage fondo quemandosew0', 24, true);
        scaleObject('Fondo', 1.1, 1.1);

	makeLuaSprite('stageback', 'StageZFire/StageBack', -200, 0);
	setLuaSpriteScrollFactor('stageback', 1.0, 1.0);
	scaleObject('stageback', 1.0, 1.0);

	makeLuaSprite('stagefront', 'StageZFire/StageFront', -200, 1050);
	setLuaSpriteScrollFactor('stagefront', 1.0, 1.0);
	scaleObject('stagefront', 1.0, 1.0);

        makeLuaSprite('mueble', 'StageZFire/Mueble', 586, 699);
        setLuaSpriteScrollFactor('mueble', 1.0, 1.0);
        scaleObject('mueble', 1.0, 1.0);

	makeLuaSprite('adornos', 'StageZFire/StageExtra', -110, 300);
	setLuaSpriteScrollFactor('adornos', 1.0, 1.0);
	scaleObject('adornos', 1.0, 1.0);

	makeLuaSprite('extra', 'StageZFire/StageExtra2', 265, 735);
	setLuaSpriteScrollFactor('extra', 1.0, 1.0);
	scaleObject('extra', 1.0, 1.0);

		makeLuaSprite('luz', 'StageZFire/BLURE', 0, 0);
	        setGraphicSize('luz',1280,720)
	        setObjectCamera('luz','camOther')
                updateHitbox('luz')
                setProperty('luz.alpha', 0.5)

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

	close(true);
end