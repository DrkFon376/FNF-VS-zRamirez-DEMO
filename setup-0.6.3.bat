@echo off
color 0a
cd ..
@echo on
echo Installing dependencies.
haxelib install flixel 4.11.0
haxelib install flixel-addons 2.11.0
haxelib install flixel-ui 2.4.0
haxelib install lime https://github.com/PsychPorting/lime-0.6.3.git main
haxelib install hxCodec https://github.com/PsychPorting/hxCodec-0.6.3.git main
haxelib install hscript 2.4.0
haxelib install openfl 9.1.0
haxelib install hxcpp 4.2.1
haxelib git linc_luajit https://github.com/PsychPorting/linc_luajit-0.6.3.git main
haxelib git discord_rpc https://github.com/PsychPorting/linc_discord-rpc-0.6.3 master
echo Finished!
pause
