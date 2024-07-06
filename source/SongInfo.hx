package;

#if sys
import sys.io.File;
#end

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using StringTools;
using flixel.util.FlxSpriteUtil;

class SongInfo extends FlxSpriteGroup
{
    var fontSize:Int = 25;
    var songNameTextSize:Int = 30;
    var boxTagWidth:Int = 15;

    public static var daAuthorInfo:String = ""; //Customizable using lua!
    public static var customSongTitle:String = ""; //Also this!
    public static var customJukeBoxTagColor:String = ""; //And this too!
    public static var disabled:Bool = false; //You can also disable it using lua

    //Inspired by the TaskSong from VS Impostor v4!

    public function new(x:Float, y:Float, song:String, authorInfo:String = "") {

        super(x, y);

        var colorNum:Int = Std.parseInt(customJukeBoxTagColor);
        if(customJukeBoxTagColor != "" && !customJukeBoxTagColor.startsWith('0x'))
            colorNum = Std.parseInt('0xFF' + customJukeBoxTagColor);

        var jukeBoxText = new FlxText(0 - boxTagWidth, 27, 300, "Now playing:", fontSize);
        jukeBoxText.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), fontSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        jukeBoxText.updateHitbox();

        var jukeBoxSongName = new FlxText(0 - boxTagWidth, 57, 300, (customSongTitle != "" ? customSongTitle : song), songNameTextSize);
        jukeBoxSongName.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), songNameTextSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        jukeBoxSongName.updateHitbox();

        var authorInfoText = new FlxText(0 - boxTagWidth, 97, 300, (daAuthorInfo != "" ? daAuthorInfo : authorInfo), fontSize);
        authorInfoText.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), fontSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        authorInfoText.updateHitbox();

        var jukeBox = new FlxSprite(0 - boxTagWidth * 2, 15).makeGraphic(300 + boxTagWidth, jukeBoxText.frameHeight + jukeBoxSongName.frameHeight + authorInfoText.frameHeight + 21, FlxColor.BLACK);
        jukeBox.alpha = 0.5;

        var jukeBoxTag = new FlxSprite(0 - boxTagWidth * 2 + jukeBox.width, 15).makeGraphic(20, jukeBoxText.frameHeight + jukeBoxSongName.frameHeight + authorInfoText.frameHeight + 21, (customJukeBoxTagColor != "" ? colorNum : FlxColor.fromRGB(PlayState.instance.dad.healthColorArray[0], PlayState.instance.dad.healthColorArray[1], PlayState.instance.dad.healthColorArray[2])));
        jukeBoxTag.alpha = 0.5;

        add(jukeBox);
        add(jukeBoxTag);
        add(jukeBoxText);
        add(jukeBoxSongName);
        add(authorInfoText);

        alpha = 0.00000001;
    }

    public function start(){
        if (!disabled)
        {
            alpha = 1;

            //Was a great idea to incorporate the tweens to the modchartTweens map of PlayState :mirada_sexy:
            PlayState.instance.modchartTweens.set("SongInfoShit", FlxTween.tween(this, {x: 25}, 1.5, {ease: FlxEase.quintInOut, onComplete: function(twn:FlxTween){
                PlayState.instance.modchartTweens.set("SongInfoShit2", FlxTween.tween(this, {x: -360}, 1.5, {ease: FlxEase.quintInOut, startDelay: 2.5, onComplete: function(twn:FlxTween){ 
                    this.destroy(); 
                }}));
            }}));
        }
    }
}