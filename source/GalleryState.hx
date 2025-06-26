package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;
import MainMenuState;

import haxe.Json;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

typedef GalleryData = {
    var description:String;
}

class GalleryState extends MusicBeatState
{    
    var images:Array<String> = [];
    var jsons:Array<String> = [];
    var descriptions:Array<String> = [];

    var currentIndex:Int = 0;
    var currentImage:FlxSprite;
    var descriptionText:FlxText;

    override function create()
    {
        #if desktop
	    DiscordClient.changePresence("In the Gallery", null);
	    #end
        
        super.create();

        var foldersToCheck:Array<String> = [Paths.getPreloadPath('images/gallery/')];
        #if sys
		#if MODS_ALLOWED
		foldersToCheck.insert(0, Paths.mods('images/gallery/'));
		if(Paths.currentModDirectory != null && Paths.currentModDirectory.length > 0)
			foldersToCheck.insert(0, Paths.mods(Paths.currentModDirectory + '/images/gallery/'));

		for(mod in Paths.getGlobalMods())
			foldersToCheck.insert(0, Paths.mods(mod + '/images/gallery/'));
		#end

		for (folder in foldersToCheck)
		{
			if(FileSystem.exists(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
                    if (file.endsWith('.png') && !images.contains(file))
                    {
                        trace(file);
                        images.push(file.replace('.png', ''));
                    }

                    if (file.endsWith('.json') && !jsons.contains(file))
                    {
                        trace(file);
                        jsons.push(file.replace('.json', ''));
                    }
                }
            }
        }

        for (json in jsons)
        {
            final data:GalleryData = Json.parse(File.getContent(Paths.getPath('images/gallery/$json.json', openfl.utils.AssetType.TEXT)));
            descriptions.push(data.description);
        }
        #end

        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
        bg.scrollFactor.set(0, 0);
        bg.setGraphicSize(Std.int(bg.width * 1.1));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);

        currentImage = new FlxSprite();
        currentImage.antialiasing = ClientPrefs.globalAntialiasing;
        add(currentImage);

        descriptionText = new FlxText(0, currentImage.y + currentImage.height + 20, FlxG.width, "", 16);
        descriptionText.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        descriptionText.scrollFactor.set();
        descriptionText.antialiasing = ClientPrefs.globalAntialiasing;
        add(descriptionText);

        var instructions = new FlxText(0, FlxG.height - 30, FlxG.width, "LEFT/RIGHT to change image | ESC to back to menu", 16);
        instructions.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        instructions.scrollFactor.set();
        instructions.antialiasing = ClientPrefs.globalAntialiasing;
        add(instructions);
        changeImage(0);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.RIGHT)
            changeImage(1);
        else if (FlxG.keys.justPressed.LEFT)
            changeImage(-1);
        else if (FlxG.keys.justPressed.ESCAPE)
            FlxG.switchState(new MainMenuState());
    }

    function changeImage(change:Int)
    {
        currentIndex += change;
        if (currentIndex < 0) currentIndex = images.length - 1;
        if (currentIndex >= images.length) currentIndex = 0;

        currentImage.loadGraphic(Paths.image('gallery/' + images[currentIndex]));
        currentImage.setGraphicSize(0, Std.int(FlxG.height * 0.5));
        currentImage.updateHitbox();
        currentImage.screenCenter(FlxAxes.X);
        currentImage.y = 80;

        if (descriptions[currentIndex] != null)
        {
            descriptionText.text = descriptions[currentIndex];
            descriptionText.y = currentImage.y + currentImage.height + 20;
        }
    }
}