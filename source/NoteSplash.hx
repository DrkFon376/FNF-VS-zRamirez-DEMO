package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class NoteSplashData
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

	public var fps:Array<Int> = null;
}

class NoteSplashOffsetHandler
{
	public var skins:Map<String, NoteSplashData> = [];

	public function new() {}

	public function getSkin(name:String):NoteSplashData
		return skins[name];

	public function setSkin(name:String, offset:NoteSplashData)
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
	public static var offsetHandler:NoteSplashOffsetHandler = new NoteSplashOffsetHandler();

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String = 'noteSplashShit/' + ClientPrefs.noteSplashesTexture;
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;

		loadAnims(skin);

		final data:NoteSplashData = new NoteSplashData();
		switch (skin)
		{
			case 'noteSplashShit/Diamond':
				data.fps = [22, 26];
				for (anim in ['note0-1', 'note1-1', 'note2-1', 'note3-1', 'note0-2', 'note1-2', 'note2-2', 'note3-2'])
				{
					if (anim.contains('-1'))
						data.setOffset(anim, [-28, -52]);
					else
						data.setOffset(anim, [-16, -55]);
				}
			case 'noteSplashShit/Psych':
				for (anim in ['note0-1', 'note1-1', 'note2-1', 'note3-1', 'note0-2', 'note1-2', 'note2-2', 'note3-2'])
					data.setOffset(anim, [0, 0]);
			case 'noteSplashShit/Vanilla':
				for (anim in ['note0-1', 'note1-1', 'note2-1', 'note3-1', 'note0-2', 'note1-2', 'note2-2', 'note3-2'])
					data.setOffset(anim, [-35, -27]);
			case 'noteSplashShit/Electric':
				data.fps = [22, 26];
				for (anim in ['note0-1', 'note1-1', 'note2-1', 'note3-1'])
					data.setOffset(anim, [-44, -54]);
			case 'noteSplashShit/Sparkles':
				data.fps = [22, 26];
				for (anim in ['note0-1', 'note1-1', 'note2-1', 'note3-1'])
					data.setOffset(anim, [-48, -48]);
			case 'noteSplashShit/Lightning':
				data.fps = [22, 26];
				for (anim in ['note0-1', 'note1-1', 'note2-1', 'note3-1'])
					data.setOffset(anim, [-15, -19]);
		}
		offsetHandler.setSkin(skin, data);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = 0.6;

		if(texture == null) {
			texture = 'noteSplashShit/' + ClientPrefs.noteSplashesTexture;
			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;

		final name:String = checkAnim(note);
		animation.play(name, true);
		offset.set(10, 10);

		final animOffsets:Array<Float> = offsetHandler.getSkinOffset(texture, name);
		if (animOffsets != null) 
		{
			offset.x += animOffsets[0];
			offset.y += animOffsets[1];
		}

		final fpsArray:Array<Int> = offsetHandler.getSkin(texture).fps;
		if(animation.curAnim != null) animation.curAnim.frameRate = fpsArray == null ? 24 + FlxG.random.int(-2, 2) : FlxG.random.int(fpsArray[0], fpsArray[1]);
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
		if(animation.curAnim != null) if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}