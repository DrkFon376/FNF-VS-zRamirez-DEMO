import haxe.Timer;
import openfl.display.FPS;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.FlxG;
import flixel.util.FlxColor;
import openfl.Lib;
import flixel.math.FlxMath;
import haxe.Int64;
import openfl.system.System;

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
		if (currentFPS > ClientPrefs.framerate)
			currentFPS = ClientPrefs.framerate;

		if (visible)
		{
			memoryUsage = (ClientPrefs.memoryDisplay ? "RAM: " : "");

			#if !html5
			memoryMegas = Int64.make(0, System.totalMemory);

			taskMemoryMegas = Int64.make(0, MemoryUtil.getMemoryfromProcess());

			if (ClientPrefs.memoryDisplay)
			{
				if (memoryMegas >= 0x40000000)
					memoryUsage += (Math.round(cast(memoryMegas, Float) / 0x400 / 0x400 / 0x400 * 1000) / 1000) + " GB";
				else if (memoryMegas >= 0x100000)
					memoryUsage += (Math.round(cast(memoryMegas, Float) / 0x400 / 0x400 * 1000) / 1000) + " MB";
				else if (memoryMegas >= 0x400)
					memoryUsage += (Math.round(cast(memoryMegas, Float) / 0x400 * 1000) / 1000) + " KB";
				else
					memoryUsage += memoryMegas + " B";

				#if windows
				if (taskMemoryMegas >= 0x40000000)
					memoryUsage += " (" + (Math.round(cast(taskMemoryMegas, Float) / 0x400 / 0x400 / 0x400 * 1000) / 1000) + " GB)";
				else if (taskMemoryMegas >= 0x100000)
					memoryUsage += " (" + (Math.round(cast(taskMemoryMegas, Float) / 0x400 / 0x400 * 1000) / 1000) + " MB)";
				else if (taskMemoryMegas >= 0x400)
					memoryUsage += " (" + (Math.round(cast(taskMemoryMegas, Float) / 0x400 * 1000) / 1000) + " KB)";
				else
					memoryUsage += "(" + taskMemoryMegas + " B)";
				#end
			}
			#else
			memoryMegas = HelperFunctions.truncateFloat((MemoryUtil.getMemoryfromProcess() / (1024 * 1024)) * 10, 3);
			memoryUsage += memoryMegas + " MB";
			#end

			text += '$memoryUsage';

			textColor = 0xFFFFFFFF;
			if (memoryMegas >= 0x40000000 || currentFPS <= ClientPrefs.framerate / 2)
			{
				textColor = 0xFFFF0000;
			}

			text = "FPS: "
			+ '${currentFPS}\n'
			+ '$memoryUsage';

			#if debug
			text += '\nDEBUG MODE';
			#end
		}

		cacheCount = currentCount;
	}
}
