package;

import flixel.math.FlxPoint;
import flixel.FlxSprite;
import openfl.Assets;
import Note;

//Most of the Original code from Mr.Bruh (mr.bruh69)
//Ported to haxe and edited by glowsoony //gracias glow :mirada_sexy:

using StringTools;

typedef HoldCoverData =
{
  texture:String,
  useShader:Bool,
  a:Int
}

class HoldCoverSprite extends FlxSprite
{
  public var colorSwap:ColorSwap;
  public var skin:String = "";

  public var holdSucceeded:Bool = false;

  public var coverData:HoldCoverData =
    {
      texture: null,
      useShader: true,
      a: 1
    }
  public var offsetX:Float = 0;
  public var offsetY:Float = 0;

  public function initShader()
  {
    colorSwap = new ColorSwap();
		shader = colorSwap.shader;
  }

  public function initFrames(i:Int, hcolor:String)
  {
    this.skin = "holdCover";
    this.frames = Paths.getSparrowAtlas('HoldNoteEffect/holdCover$hcolor');
  }

  public function initAnimations(hcolor:String)
  {
    animation.finishCallback = function(animationName:String) {
        if (animationName == 'holdCoverStart') playContinue();
        if (animationName == 'holdCoverEnd') endCover();
      }
      this.animation.addByPrefix('holdCoverStart', 'holdCoverStart$hcolor', 24, false);
      this.animation.addByPrefix('holdCover', 'holdCover$hcolor', 24, true);
      this.animation.addByPrefix('holdCoverEnd', 'holdCoverEnd$hcolor', 24, false);
    initShader();
  }

  public function shaderCopy(noteData:Int, note:Note)
  {
    this.antialiasing = ClientPrefs.globalAntialiasing;
    if (skin.contains('pixel') || !ClientPrefs.globalAntialiasing)
      this.antialiasing = false;

    if (!coverData.useShader) return;

    if (noteData > -1 && noteData < ClientPrefs.arrowHSV.length)
    {
      if (note != null)
      {
        colorSwap.hue = note.holdSplashHue;
        colorSwap.saturation = note.holdSplashSat;
        colorSwap.brightness = note.holdSplashBrt;
      }
      else
      {
        colorSwap.hue = ClientPrefs.arrowHSV[noteData][0] / 360;
        colorSwap.saturation = ClientPrefs.arrowHSV[noteData][1] / 100;
        colorSwap.brightness = ClientPrefs.arrowHSV[noteData][2] / 100;
      }
    }
  }

  public function endCover():Void
    {
      // *lightning* *zap* *crackle*
      if (!animation.finished && animation.curAnim != null) animation.curAnim.finish();
      visible = false;
      kill();
    }
  
    public function playStart():Void
      animation.play('holdCoverStart');
  
    public function playContinue():Void
      animation.play('holdCover');
  
    public function playEnd():Void
      animation.play('holdCoverEnd');

    public var holdCPos:FlxPoint = new FlxPoint(0, 0);
  
    override public function update(elapsed:Float)
    {
      super.update(elapsed);        
      if (holdCPos != null) setPosition(holdCPos.x - 110 + offsetX, holdCPos.y - 100 + offsetY);
    }
  
    public override function kill():Void
    {
      super.kill();
  
      this.visible = false;
    }
  
    public override function revive():Void
    {
      super.revive();
  
      this.visible = true;
    }

    override function destroy():Void
    {
      holdCPos = flixel.util.FlxDestroyUtil.destroy(holdCPos);
      super.destroy();
    }
}