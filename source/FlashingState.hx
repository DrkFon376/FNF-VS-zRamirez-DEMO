package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var zRamirezBG:FlxSprite;
	var warnText:FlxText;
	var disabledText:Alphabet;
	var pressed:Bool = false;

	override function create()
	{
		super.create();

		zRamirezBG = new FlxSprite().loadGraphic(Paths.image("Flashing_Lights_Background"));
		zRamirezBG.screenCenter();
		zRamirezBG.updateHitbox();
		add(zRamirezBG);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width, (!FlxG.save.data.firstWarning ?
			"Hey, watch out!\n
			This Mod contains some flashing lights!\n
			Press ENTER to disable them now or go to Options Menu.\n
			Press ESCAPE to ignore this message.\n
			You've been warned!" :
			"Hey, watch out!\n
			This Mod contains some flashing lights!\n
			Press ENTER to disable them now or go to Options Menu.\n
			Press ESCAPE to ignore this message.\n
			You've been warned!\n\n
			Press D for disable this warning
			the next time you open the game\n
			(You can enable it again in Visuals Options)"),
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		disabledText = new Alphabet(0, FlxG.height - 100, 'Warning Disabled', true);
		disabledText.setScale(0.8, 0.8);
		disabledText.screenCenter(X);
		disabledText.alpha = 0;
		add(disabledText);

		pressed = false;
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxG.save.data.firstWarning = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					FlxG.save.data.flashing = false;
					FlxG.save.flush();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					if (disabledText != null && disabledText.alpha > 0)
						FlxTween.tween(disabledText, {alpha: 0}, 0.4);
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						FlxTween.tween(zRamirezBG, {alpha: 0}, 1, {
							onComplete: function(twn:FlxTween) {
								MusicBeatState.switchState(new TitleState());
							}
						});
					});
				} else {
					FlxG.save.data.flashing = true;
					FlxG.save.flush();
					FlxG.sound.play(Paths.sound('cancelMenu'));
					if (disabledText != null && disabledText.alpha > 0)
						FlxTween.tween(disabledText, {alpha: 0}, 0.4);
					FlxTween.tween(zRamirezBG, {alpha: 0}, 1);
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
			else if (FlxG.save.data.firstWarning && FlxG.keys.justPressed.D && !pressed)
			{
				FlxG.save.data.flashingWarningEnabled = false;
				FlxG.save.flush();
				disabledText.alpha = 1;
				pressed = true;
			}

			if (disabledText != null)
			{
				if (disabledText.alpha > 0)
					disabledText.alpha -= 0.8 * elapsed;
			}
		}
		super.update(elapsed);
	}
}
