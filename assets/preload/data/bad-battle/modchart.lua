--Por Slushi, para el mod Vs Zramirez. Testeado en Slushi Engine-- 

-----VARIABLES-----
local move = false
-------------------
-----------------------MODCHART-----------------------
function onStepHit()
    if curStep >= 512 and curStep <= 640 then
        noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
        move = true
        noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
        noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
    end

    if curStep == 640 then
        noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')   
        noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')
    end
    if curStep >= 768 and curStep <= 896 then
        noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
        move = true
        noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
        noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
    end
    if curStep == 896 then
        noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')    
        noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')    
    end
    if curStep >= 1408 and curStep <= 1536 then
        noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
        move = true
        noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
        noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
    end
    if curStep == 1536 then
        noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')    
        noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')    
    end
    if curStep >= 1664 and curStep <= 1792 then
        noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
        move = true
        noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
        noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
    end
    if curStep == 1792 then
        noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
        noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
        noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
        noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
        noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')  
        noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
        noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')
    end
end

function onBeatHit()
    if move == true then
        if curBeat % 2 == 0 then
            doTweenX('cam','camHUD', 250, 1.5, 'linear')
        elseif curBeat % 2 == 1 then
            doTweenX('cam','camHUD', -250, 1.5, 'linear')
        end
    end
end
----------------------------------------------------------------------