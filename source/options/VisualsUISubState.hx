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

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence
		FlxG.save.data.enteredVisualsOptions = true;

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Hold Splashes',
			"If unchecked, hitting a Sustain Note won't show particles (also applies to opponent's side).",
			'holdSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Note Splashes Texture:',
			"Choose what texture you want to be used in the Note Splashes.",
			'noteSplashesTexture',
			'string',
			'Vanilla',
			['Vanilla', 'Psych', 'Diamond', 'Electric', 'Sparkles']);
		addOption(option);

		var option:Option = new Option('Note Skin Texture:',
			"Choose what texture you want to be used in on the Notes.",
			'noteSkin',
			'string',
			'Vanilla',
			['Vanilla', 'Future', 'Future2', 'Chip', 'Bar', 'Diamond', 'Square', 'DoritosPizzerola']);
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
			'Breakfast',
			['None', 'Breakfast', 'Tea Time', 'zRamírez']);
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
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic == 'Breakfast' ? "breakfast-pixel" : (ClientPrefs.pauseMusic == 'zRamírez' ? "ramirez-week-pause" : ClientPrefs.pauseMusic))));

		changedMusic = true;
	}

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
