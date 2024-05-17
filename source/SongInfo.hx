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

    // Inspired by the TaskSong from VS Impostor v4!

    public function new(x:Float, y:Float, song:String, authorInfo:String = "") {

        super(x, y);
        
        var jukeBox = new FlxSprite(0 - boxTagWidth * 2, 15).makeGraphic(300 + boxTagWidth, 160, FlxColor.BLACK);
        jukeBox.alpha = 0.5;

        var jukeBoxTag = new FlxSprite(0 - boxTagWidth * 2 + jukeBox.width, 15).makeGraphic(20, 160, 0xFF3EFFE4);
        jukeBoxTag.alpha = 0.5;

        var jukeBoxText = new FlxText(0 - boxTagWidth, 30, 300, "Now playing:", fontSize);
        jukeBoxText.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), fontSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        jukeBoxText.updateHitbox();

        var jukeBoxSongName = new FlxText(0 - boxTagWidth, 60, 300, song, songNameTextSize);
        jukeBoxSongName.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), songNameTextSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        jukeBoxSongName.updateHitbox();

        var authorInfoText = new FlxText(0 - boxTagWidth, 100, 300, "Song by: " + authorInfo, fontSize);
        authorInfoText.setFormat(Paths.font("PhantomMuff Full Letters 1.1.5.ttf"), fontSize, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        authorInfoText.updateHitbox();

        add(jukeBox);
        add(jukeBoxTag);
        add(jukeBoxText);
        add(jukeBoxSongName);
        add(authorInfoText);

        alpha = 0.00000001;
    }

    public function start(){
        alpha = 1;

        // Was a great idea to incorporate the tweens to the modchartTweens map of PlayState :mirada_sexy:
        PlayState.instance.modchartTweens.set("SongInfoShit", FlxTween.tween(this, {x: 25}, 1.5, {ease: FlxEase.quintInOut, onComplete: function(twn:FlxTween){
            PlayState.instance.modchartTweens.set("SongInfoShit2", FlxTween.tween(this, {x: -360}, 1.5, {ease: FlxEase.quintInOut, startDelay: 2.5, onComplete: function(twn:FlxTween){ 
                this.destroy(); 
            }}));
        }}));
    }
}