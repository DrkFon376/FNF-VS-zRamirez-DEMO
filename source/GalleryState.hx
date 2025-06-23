package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;
import flixel.math.FlxPoint;
import MainMenuState;

class GalleryState extends MusicBeatState
{
    
    var images:Array<String> = ['placeholder1', 'placeholder2', 'placeholder3'];

    
    var descriptions:Array<String> = [
        "Placeholder.",
        "Placeholder2.",
        "Placeholder3."
    ];

    var currentIndex:Int = 0;
    var currentImage:FlxSprite;
    var descriptionText:FlxText;

    override function create()
    {

        #if desktop
	        DiscordClient.changePresence("Gallery", null);
	    #end
        
        super.create();

        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
        bg.scrollFactor.set(0, 0);
        bg.setGraphicSize(Std.int(bg.width * 1.1));
        bg.updateHitbox();
        bg.screenCenter();
        add(bg);

        currentImage = new FlxSprite();
        currentImage.loadGraphic(Paths.image('gallery/'));
        currentImage.setGraphicSize(0, Std.int(FlxG.height * 0.5));
        currentImage.updateHitbox();
        currentImage.screenCenter(FlxAxes.X); 
        currentImage.y = 80;
        add(currentImage);

        descriptionText = new FlxText(0, currentImage.y + currentImage.height + 20, FlxG.width, descriptions[currentIndex], 16);
        descriptionText.setFormat("VCR OSD Mono", 18, FlxColor.WHITE, CENTER);
        descriptionText.scrollFactor.set();
        add(descriptionText);

        var instructions = new FlxText(0, FlxG.height - 30, FlxG.width, "IZQ/DERECHA para cambiar imagen | ESC para volver", 16);
        instructions.setFormat("VCR OSD Mono", 16, FlxColor.GRAY, CENTER);
        instructions.scrollFactor.set();
        add(instructions);
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

        currentImage.loadGraphic(Paths.image('gallery/'));
        currentImage.setGraphicSize(0, Std.int(FlxG.height * 0.5));
        currentImage.updateHitbox();
        currentImage.screenCenter(FlxAxes.X);
        currentImage.y = 80;

        descriptionText.text = descriptions[currentIndex];
        descriptionText.y = currentImage.y + currentImage.height + 20;
    }
}