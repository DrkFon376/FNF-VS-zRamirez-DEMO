package achievements;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxSort;
import flixel.util.FlxColor;
import achievements.Achievements.Achievement;

#if ACHIEVEMENTS_ALLOWED
class AchievementsMenuState extends MusicBeatState
{
	public var curSelected:Int = 0;

	public var options:Array<Dynamic> = [];
	public var grpOptions:FlxSpriteGroup;
	public var nameText:FlxText;
	public var descText:FlxText;
	public var progressTxt:FlxText;

	var camFollow:FlxObject;

	var MAX_PER_ROW:Int = 4;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Achievements Menu", null);
		#end

		// prepare achievement list
		for (achievement => data in Achievements.achievements)
		{
			var unlocked:Bool = Achievements.isUnlocked(achievement);
			if(data.hidden != true || unlocked)
				options.push(makeAchievement(achievement, data, unlocked, data.mod));
		}

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		menuBG.antialiasing = ClientPrefs.globalAntialiasing;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.scrollFactor.set();
		add(menuBG);

		grpOptions = new FlxSpriteGroup();
		grpOptions.scrollFactor.x = 0;

		options.sort(sortByID);
		for (option in options)
		{
			var hasAntialias:Bool = ClientPrefs.globalAntialiasing;
			var graphic = null;
			if(option.unlocked)
			{
				#if MODS_ALLOWED Paths.currentModDirectory = option.mod; #end
				var image:String = 'achievements/' + option.name;
				if(Paths.fileExists('images/$image-pixel.png', IMAGE))
				{
					graphic = Paths.image('$image-pixel');
					hasAntialias = false;
				}
				else graphic = Paths.image(image);

				if(graphic == null) graphic = Paths.image('unknownMod');
			}
			else graphic = Paths.image('achievements/lockedachievement');

			var spr:FlxSprite = new FlxSprite(0, Math.floor(grpOptions.members.length / MAX_PER_ROW) * 180).loadGraphic(graphic);
			spr.scrollFactor.x = 0;
			spr.screenCenter(X);
			spr.x += 180 * ((grpOptions.members.length % MAX_PER_ROW) - MAX_PER_ROW/2) + spr.width / 2 + 15;
			spr.ID = grpOptions.members.length;
			spr.antialiasing = hasAntialias;
			grpOptions.add(spr);
		}

		var box:FlxSprite = new FlxSprite(0, -30).makeGraphic(1, 1, FlxColor.BLACK);
		box.scale.set(grpOptions.width + 60, grpOptions.height + 60);
		box.updateHitbox();
		box.alpha = 0.6;
		box.scrollFactor.x = 0;
		box.screenCenter(X);
		add(box);
		add(grpOptions);

		var box:FlxSprite = new FlxSprite(0, 570).makeGraphic(1, 1, FlxColor.BLACK);
		box.scale.set(FlxG.width, FlxG.height - box.y);
		box.updateHitbox();
		box.alpha = 0.6;
		box.scrollFactor.set();
		add(box);
		
		nameText = new FlxText(50, box.y + 10, FlxG.width - 100, "", 32);
		nameText.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		nameText.scrollFactor.set();
		nameText.antialiasing = ClientPrefs.globalAntialiasing;

		descText = new FlxText(50, nameText.y + 38, FlxG.width - 100, "", 24);
		descText.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.antialiasing = ClientPrefs.globalAntialiasing;

		add(progressTxt);
		add(descText);
		add(nameText);
		
		_changeSelection();
		super.create();
		
		FlxG.camera.follow(camFollow, null, 0.15);
		FlxG.camera.scroll.y = -FlxG.height;
	}

	function makeAchievement(achievement:String, data:Achievement, unlocked:Bool, mod:String = null)
	{
		return {
			name: achievement,
			displayName: unlocked ? data.name : '???',
			description: data.description,
			curProgress: data.maxScore > 0 ? Achievements.getScore(achievement) : 0,
			maxProgress: data.maxScore > 0 ? data.maxScore : 0,
			decProgress: data.maxScore > 0 ? data.maxDecimals : 0,
			unlocked: unlocked,
			ID: data.ID,
			mod: mod
		};
	}

	public static function sortByID(Obj1:Dynamic, Obj2:Dynamic):Int
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.ID, Obj2.ID);

	var goingBack:Bool = false;
	override function update(elapsed:Float) {
		if(!goingBack && options.length > 1)
		{
			var add:Int = 0;
			if (controls.UI_LEFT_P) add = -1;
			else if (controls.UI_RIGHT_P) add = 1;

			if(add != 0)
			{
				var oldRow:Int = Math.floor(curSelected / MAX_PER_ROW);
				var rowSize:Int = Std.int(Math.min(MAX_PER_ROW, options.length - oldRow * MAX_PER_ROW));
				
				curSelected += add;
				var curRow:Int = Math.floor(curSelected / MAX_PER_ROW);
				if(curSelected >= options.length) curRow++;

				if(curRow != oldRow)
				{
					if(curRow < oldRow) curSelected += rowSize;
					else curSelected = curSelected -= rowSize;
				}
				_changeSelection();
			}

			if(options.length > MAX_PER_ROW)
			{
				var add:Int = 0;
				if (controls.UI_UP_P) add = -1;
				else if (controls.UI_DOWN_P) add = 1;

				if(add != 0)
				{
					var diff:Int = curSelected - (Math.floor(curSelected / MAX_PER_ROW) * MAX_PER_ROW);
					curSelected += add * MAX_PER_ROW;
					//trace('Before correction: $curSelected');
					if(curSelected < 0)
					{
						curSelected += Math.ceil(options.length / MAX_PER_ROW) * MAX_PER_ROW;
						if(curSelected >= options.length) curSelected -= MAX_PER_ROW;
						//trace('Pass 1: $curSelected');
					}
					if(curSelected >= options.length)
					{
						curSelected = diff;
						//trace('Pass 2: $curSelected');
					}

					_changeSelection();
				}
			}
			
			if(controls.RESET && (options[curSelected].unlocked || options[curSelected].curProgress > 0))
				openSubState(new ResetAchievementSubstate());
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
			goingBack = true;
		}
		super.update(elapsed);
	}

	public var barTween:FlxTween = null;
	function _changeSelection()
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		nameText.text = options[curSelected].displayName;
		descText.text = options[curSelected].description;

		var maxRows = Math.floor(grpOptions.members.length / MAX_PER_ROW);
		if(maxRows > 0)
		{
			var camY:Float = FlxG.height / 2 + (Math.floor(curSelected / MAX_PER_ROW) / maxRows) * Math.max(0, grpOptions.height - FlxG.height / 2 - 50) - 100;
			camFollow.setPosition(0, camY);
		}
		else camFollow.setPosition(0, grpOptions.members[curSelected].getGraphicMidpoint().y - 100);

		grpOptions.forEach(function(spr:FlxSprite) {
			spr.alpha = 0.6;
			if(spr.ID == curSelected) spr.alpha = 1;
		});
	}
}

class ResetAchievementSubstate extends MusicBeatSubstate
{
	var onYes:Bool = false;
	var yesText:Alphabet;
	var noText:Alphabet;

	public function new()
	{
		super();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);
		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});

		var text:Alphabet = new Alphabet(0, 180, 'Reset Achievement: ', true);
		text.screenCenter(X);
		text.scrollFactor.set();
		add(text);
		
		var state:AchievementsMenuState = cast FlxG.state;
		var text:FlxText = new FlxText(50, text.y + 90, FlxG.width - 100, state.options[state.curSelected].displayName, 40);
		text.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.scrollFactor.set();
		text.borderSize = 2;
		text.antialiasing = ClientPrefs.globalAntialiasing;
		add(text);
		
		yesText = new Alphabet(0, text.y + 120, 'Yes', true);
		yesText.screenCenter(X);
		yesText.x -= 200;
		yesText.scrollFactor.set();
		for(letter in yesText.letters) letter.color = FlxColor.RED;
		add(yesText);
		noText = new Alphabet(0, text.y + 120, 'No', true);
		noText.screenCenter(X);
		noText.x += 200;
		noText.scrollFactor.set();
		add(noText);
		updateOptions();
	}

	override function update(elapsed:Float)
	{
		if(controls.BACK)
		{
			close();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			return;
		}

		super.update(elapsed);

		if(controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			onYes = !onYes;
			updateOptions();
		}

		if(controls.ACCEPT)
		{
			if(onYes)
			{
				var state:AchievementsMenuState = cast FlxG.state;
				var option:Dynamic = state.options[state.curSelected];

				Achievements.variables.remove(option.name);
				Achievements.achievementsUnlocked.remove(option.name);
				option.unlocked = false;
				option.curProgress = 0;
				option.name = state.nameText.text = '???';
				state.grpOptions.members[state.curSelected].loadGraphic(Paths.image('achievements/lockedachievement'));
				state.grpOptions.members[state.curSelected].antialiasing = ClientPrefs.globalAntialiasing;

				Achievements.save();
				FlxG.save.flush();
				FlxG.sound.play(Paths.sound('cancelMenu'));
			}
			close();
			return;
		}
	}

	function updateOptions() {
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
#end