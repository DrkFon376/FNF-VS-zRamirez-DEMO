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

	var array:Array<FlxColor> = [
		FlxColor.fromRGB(148, 0, 211),
		FlxColor.fromRGB(75, 0, 130),
		FlxColor.fromRGB(0, 0, 255),
		FlxColor.fromRGB(0, 255, 0),
		FlxColor.fromRGB(255, 255, 0),
		FlxColor.fromRGB(255, 127, 0),
		FlxColor.fromRGB(255, 0, 0)
	];

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
			memoryUsage = (FlxG.save.data.showFPS ? "RAM in Use: " : "");
			#if !html5
			memoryMegas = Int64.make(0, System.totalMemory);

			taskMemoryMegas = Int64.make(0, MemoryUtil.getMemoryfromProcess());

			#if !windows
			memoryUsage += (FlxMath.roundDecimal(((Math.round(cast(memoryMegas, Float) / 0x400 / 0x400 * 1000) / 1000) - 54), 2)) + " MB";
			#else
			memoryUsage += (FlxMath.roundDecimal(((Math.round(cast(taskMemoryMegas, Float) / 0x400 / 0x400 * 1000) / 1000) - 54), 2)) + " MB";
			#end

			/*if (FlxG.save.data.gpuRender)
					memoryUsage = (FlxG.save.data.memoryDisplay?"Memory Usage: " + memoryMegas + " MB / " + memoryTotal + " MB" + "\nGPU Usage: " + gpuMemory
						+ " MB" #if debug
						+ gpuInfo #end : "");
				else */
			#else
			memoryMegas = HelperFunctions.truncateFloat((MemoryUtil.getMemoryfromProcess() / (1024 * 1024)) * 10, 2);
			memoryUsage += memoryMegas + " MB";
			#end

			#if debug
			text = (FlxG.save.data.showFPS ? "FPS: "
				+ '${currentFPS}\n'
				+ '$memoryUsage'
				+ "\nDEBUG MODE" : "");
			#else
			text = (FlxG.save.data.showFPS ? "FPS: "
				+ '${currentFPS}\n'
				+ '$memoryUsage' : "");
			#end
		}

		cacheCount = currentCount;
	}
}
