package;

import openfl.Assets;
import flixel.FlxSprite;
import Note;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxTimer;

using StringTools;

// Brought over from SC-Engine by me (glowsoony) Ah yes my code from my own engine to this one!
class HoldCoverGroup extends FlxTypedSpriteGroup<HoldCoverSprite>
{
  public var enabled:Bool = true;
  public var canSplash:Bool = false;
  public var isReady(get, never):Bool;

  public dynamic function get_isReady():Bool
    return true;

  public function new()
    super(0);

  public var colors:Array<String> = ["Purple", "Blue", "Green", "Red"];

  public dynamic function addHolds(i:Int, strum:StrumNote)
  {
    final hold:HoldCoverSprite = new HoldCoverSprite();
    hold.initFrames(i, colors[i]);
    hold.initAnimations(colors[i]);
    hold.visible = false;
    hold.holdCPos.set(strum.x, strum.y);
    add(hold);
  }

  public function spawnOnNoteHit(note:Note):Void
  {
    if (note == null) return;
    final member:HoldCoverSprite = grabMember(note.noteData);
    if (member == null) return;

    if (enabled && isReady)
    {
      member.shaderCopy(note.noteData, note);
      if (note.endHoldC || note.canHoldC && note.nextNote == null)
      {
        if (canSplash && member.holdSucceeded)
          member.playEnd();
        else 
          member.endCover();
      }
      else if (note.sustainLength > 0 && (!note.isSustainNote || !member.visible))
      {
        member.revive();
        member.playStart();
        member.holdSucceeded = true;
      }
    }
  }

  public function grabMember(index:Int):HoldCoverSprite
    return members[index];

  public function despawnOnMiss(direciton:Int, ?note:Note = null):Void
  {
    final noteData:Int = (note != null ? note.noteData : direciton);
    if (enabled && isReady)
    {
      final member:HoldCoverSprite = grabMember(noteData);
      member.shaderCopy(noteData, note);
      member.endCover();
    }
  }

  private function hideHoldCoverLater(data:Int, delay:Float):Void
  {
      var timer:FlxTimer = new FlxTimer();
      var tag:String = "hideHoldCoverFromStrum" + data;
      PlayState.instance.modchartTimers.set(tag, timer.start(delay, function(timer:FlxTimer)
      {
        grabMember(data).visible = false;
        PlayState.instance.modchartTimers.remove(tag);
      }));
  }
}
