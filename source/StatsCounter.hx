import haxe.Timer;
import openfl.display.FPS;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;
import openfl.Lib;
import flixel.math.FlxMath;
import haxe.Int64;
import openfl.system.System;

using StringTools;

class StatsCounter extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	private var times:Array<Float>;

	public var memoryMegas:Dynamic = 0;

	public var taskMemoryMegas:Dynamic = 0;

	public var memoryUsage:String = '';

	private var curState:String = '';

	private var cacheCount:Int;

	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000)
	{
		super();

		x = inX;

		y = inY;

		selectable = false;

		defaultTextFormat = new TextFormat('VCR OSD Mono', 14, inCol);

		text = "FPS: ";

		currentFPS = 0;

		cacheCount = 0;

		times = [];

		addEventListener(Event.ENTER_FRAME, onEnter);

		width = 300;

		height = 70;
	}

	var skippedFrames = 0;

	public static var currentColor = 0;

	private function onEnter(_)
	{
		var now = Timer.stamp();

		times.push(now);

		while (times[0] < now - 1)
			times.shift();

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		/*if (currentFPS > ClientPrefs.framerate)
			currentFPS = ClientPrefs.framerate;*/

		curState = Main.initialState + '.hx';

		if (curState.startsWith('options.')) 
		{
			var curStateSplit:Array<String> = curState.split('.');
			curState = curStateSplit[1] + '.hx';
		}
		else if (curState.startsWith('editors.'))
		{
			var curStateSplit:Array<String> = curState.split('.');
			curState = curStateSplit[1] + '.hx';
		}

		if (visible)
		{
			memoryUsage = (ClientPrefs.memoryDisplay ? "RAM Usage: " : "");

			#if !html5
			memoryMegas = Int64.make(0, System.totalMemory);

			taskMemoryMegas = Int64.make(0, MemoryUtil.getMemoryfromProcess());

			var memInUse:Float = 0;

			if (ClientPrefs.memoryDisplay)
			{
				#if !windows
				memInUse = Math.round(cast(memoryMegas, Float) / 0x400 / 0x400 * 1000) / 1000;
				#else
				memInUse = Math.round(cast(taskMemoryMegas, Float) / 0x400 / 0x400 * 1000) / 1000;
				#end
				
				memoryUsage += FlxMath.roundDecimal(memInUse, 2) + " MB";
			}
			#else
			memoryMegas = HelperFunctions.truncateFloat((MemoryUtil.getMemoryfromProcess() / (1024 * 1024)) * 10, 3);
			memoryUsage += memoryMegas + " MB";
			#end

			if (ClientPrefs.showAllCounterStats)
				text += '$memoryUsage';
			else
				text += '';

			textColor = 0xFFFFFFFF;
			if (memInUse > 3000 || currentFPS <= ClientPrefs.framerate / 2)
			{
				textColor = 0xFFFF0000;
			}

			if (ClientPrefs.showAllCounterStats)
			{
				text = (ClientPrefs.showFPS ? "FPS: " + '${currentFPS}\n' : "") //Ported from qt extreme v2.5
					+ (ClientPrefs.memoryDisplay ? '$memoryUsage' + "\n" : "")
					#if debug + (ClientPrefs.showState ? "State: " + curState + "\n" : "") #end
					#if debug + "DEBUG MODE" #end;
			}
			else
				text = '';
		}

		cacheCount = currentCount;
	}
}
