package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import Note;
import StrumNote;
import NoteSplash;

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public var splashes:FlxTypedGroup<NoteSplash>;
	public var notes:FlxTypedGroup<StrumNote>;
	var notesTween:Array<FlxTween> = [];
	var noteY:Float = 90;
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence
		FlxG.save.data.enteredVisualsOptions = true;

		// for note skins
		notes = new FlxTypedGroup<StrumNote>();
		splashes = new FlxTypedGroup<NoteSplash>();
		for (i in 0...Note.colArray.length)
		{
			var note:StrumNote = new StrumNote(370 + (560 / Note.colArray.length) * i, -200, i, 0);
			changeNoteSkin(note);
			notes.add(note);

			var splash:NoteSplash = new NoteSplash(0, 0, 0);
			splash.ID = i;
			splash.kill();
			splashes.add(splash);
		}

		var option:Option = new Option('Note Skins: ',
			"Choose what texture you want to be used in on the Notes.",
			'noteSkin',
			'string',
			'Vanilla',
			['Vanilla', 'Future', 'Chip', 'Bar', 'Diamond', 'Square', 'Camellia', 'StepMania', 'FutureALT', 'DoritosPizzerola']);
		addOption(option);
		option.onChange = onChangeNoteSkin;

		var option:Option = new Option('Note Splashes: ',
			"Choose what texture you want to be used in the Note Splashes.",
			'splashSkin',
			'string',
			'Lightning',
			['Lightning', 'Vanilla', 'Psych', 'Diamond', 'Electric', 'Sparkles']);
		addOption(option);
		option.onChange = onChangeSplashSkin;

		var option:Option = new Option('Note Splashes Alpha',
			'How visible the Splash Note effect is.\nIf you want to disable the Splashes effect, uncheck \"Note Splashes\" option (This was made this way to prevent lag.)',
			'splashAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		option.onChange = onChangeSplashAlpha;

		var option:Option = new Option('Sustain Alpha',
			'How visible the hold note is.',
			'holdAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		//Man, que carajos, esta opción en teoria es innesesaria ya que esta el splash alpha, pero como este mod esta pensado para gente con una pc igual de mierda que la mia pues aquí esta la opción de mrd -zRamírez
		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Hold Covers',
			"If unchecked, hitting a Sustain Note won't show particles (also applies to opponent's side).",
			'holdSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Disable Sustain Loop',
			"If checked, the looping of singing animations when you press a sustain note will be disabled, like V-Slice.",
			'disableSustainLoop',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Cutscenes English Subtitles',
			"If checked, English subtitles will be displayed in cutscenes.",
			'cutscenesSubtitles',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Flashing Lights Warning',
			"If unchecked, the flashing lights warning will no longer be displayed when starting the game.",
			'flashingWarningEnabled',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Health Bar Transparency',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Show Memory Usage',
			'If checked, Memory Usage is displayed in counter.',
			'memoryDisplay',
			'bool',
			true);
		addOption(option);

		#if debug
		var option:Option = new Option('Show State',
			'If checked, the current state is displayed in counter.',
			'showState',
			'bool',
			true);
		addOption(option);
		#end
		#end
		
		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			'zRamírez',
			['None', 'zRamírez', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool',
			true);
		addOption(option);
		#end

		var option:Option = new Option('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			'bool',
			true);
		addOption(option);

		super();
		add(notes);
		add(splashes);
	}

	var notesShown:Bool = false;
	override function changeSelection(change:Int = 0)
	{
		super.changeSelection(change);

		switch(curOption.variable)
		{
			case 'noteSkin', 'splashSkin', 'splashAlpha':
				if(!notesShown)
				{
					for (note in notes.members)
					{
						FlxTween.cancelTweensOf(note);
						FlxTween.tween(note, {y: noteY}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
					}
				}
				notesShown = true;
				if (curOption.variable.startsWith('splash') && Math.abs(notes.members[0].y - noteY) < 25) playNoteSplashes();

			default:
				if(notesShown) 
				{
					for (note in notes.members)
					{
						FlxTween.cancelTweensOf(note);
						FlxTween.tween(note, {y: -200}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
					}
				}
				notesShown = false;

		}
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(ClientPrefs.getPauseMusic()));

		changedMusic = true;
	}

	function onChangeNoteSkin()
	{
		notes.forEachAlive(function(note:StrumNote) {
			changeNoteSkin(note);
			note.centerOffsets();
			note.centerOrigin();
		});
	}

	function changeNoteSkin(note:StrumNote)
	{
		var skin:String = 'noteShit/' + ClientPrefs.noteSkin;
		var customSkin:String = ClientPrefs.noteSkin;
		if(Paths.fileExists('images/$customSkin.png', IMAGE)) skin = customSkin;

		note.texture = skin; //Load texture and anims
		note.reloadNote();
		note.playAnim('static');
	}

	function onChangeSplashSkin()
		playNoteSplashes();

	function playNoteSplashes()
	{
		splashes.forEach(function(splash:NoteSplash)
		{
			final hue:Float = ClientPrefs.arrowHSV[splash.ID][0] / 360;
			final sat:Float = ClientPrefs.arrowHSV[splash.ID][1] / 100;
			final brt:Float = ClientPrefs.arrowHSV[splash.ID][2] / 100;
			splash.revive();
			splash.setupNoteSplash(notes.members[splash.ID].x, notes.members[splash.ID].y, splash.ID, 'noteSplashShit/' + ClientPrefs.splashSkin, hue, sat, brt);
		});
	}

	function onChangeSplashAlpha()
		playNoteSplashes();

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('zRamirezMenu'));
		super.destroy();
	}

	/*#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showAllCounterStats;
	}
	#end*/
}
