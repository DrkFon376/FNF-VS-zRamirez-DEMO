package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class NoteSplashOffset
{
	public function new() {}

	public var animOffsets:Map<String, Array<Float>> = [];
	public function getOffset(name:String):Array<Float>
		return animOffsets[name];

	public function setOffset(name:String, pos:Array<Float>):Array<Float>
	{
		animOffsets.set(name, pos);
		return getOffset(name);
	}
}

class NoteSplashOffsetHandler
{
	public var skins:Map<String, NoteSplashOffset> = [];

	public function new() {}

	public function getSkin(name:String):NoteSplashOffset
		return skins[name];

	public function setSkin(name:String, offset:NoteSplashOffset)
	{
		skins.set(name, offset);
		return getSkin(name);
	}

	public function getSkinOffset(name:String, animNum:String):Array<Float>
		return getSkin(name).getOffset(animNum);

	public function setSkinOffset(skin:String, name:String, pos:Array<Float>):Array<Float>
		return getSkin(skin).setOffset(name, pos);
}

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	private var idleAnim:String;
	private var textureLoaded:String = null;
	public var offsetHandler:NoteSplashOffsetHandler = new NoteSplashOffsetHandler();

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String = 'noteSplashes';

		if (ClientPrefs.noteSplashesTexture == 'Vanilla')
			skin = 'noteSplashesVanilla';

		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = 0.6;

		if(texture == null) {
			if (ClientPrefs.noteSplashesTexture == 'Psych')
				texture = 'noteSplashes';
			else
				texture = 'noteSplashesVanilla';
			
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;

		if (ClientPrefs.noteSplashesTexture == 'Psych')
			offset.set(10, 10);
		else
			offset.set(-25, -17);

		animation.play(checkAnim(note), true);
		if(animation.curAnim != null)animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	function checkAnim(note:Int):String {
		if (animation.getByName('note$note-2') == null)
			return 'note$note-1';
		return 'note$note-' + FlxG.random.int(1, 2);
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		for (i in 1...3) {
			animation.addByPrefix("note1-" + i, "note splash blue " + i, 24, false);
			animation.addByPrefix("note2-" + i, "note splash green " + i, 24, false);
			animation.addByPrefix("note0-" + i, "note splash purple " + i, 24, false);
			animation.addByPrefix("note3-" + i, "note splash red " + i, 24, false);
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}