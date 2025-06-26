--Por Slushi, para el mod Vs zRamirez. Testeado en Slushi Engine-- 
--Modificado por DrkFon376

-----VARIABLES-----
local move = false
local moveYOpponent = false
local moveYPlayer = false
local originalYPositionsOpponent = {}
local originalYPositionsPlayer = {}
-------------------
-----------------------MODCHART-----------------------
function onStepHit()
    if curStep >= 512 and curStep <= 640 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
            move = true
            noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 0.5)
                end
            end
        end
        moveYOpponent = true
        moveYPlayer = true
    end
    if curStep == 640 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
            move = false
            doTweenX('cam','camHUD', 0, 1, 'linear')
            noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 1)
                end
            end
        end
        moveYOpponent = false
        moveYPlayer = false
    end
    if curStep >= 768 and curStep <= 896 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
            move = true
            noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 0.5)
                end
            end
        end
        moveYOpponent = true
        moveYPlayer = true
    end
    if curStep == 896 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
            move = false
            doTweenX('cam','camHUD', 0, 1, 'linear')
            noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 1)
                end
            end
        end
        moveYOpponent = false
        moveYPlayer = false
    end
    if curStep >= 1408 and curStep <= 1536 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
            move = true
            noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 0.5)
                end
            end
        end
        moveYOpponent = true
        moveYPlayer = true
    end
    if curStep == 1536 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
            move = false
            doTweenX('cam','camHUD', 0, 1, 'linear')
            noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 1)
                end
            end
        end
        moveYOpponent = false
        moveYPlayer = false
    end
    if curStep >= 1664 and curStep <= 1792 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, 416, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, 528, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, 640, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, 752, 0.3, 'sineOut')
            move = true
            noteTweenX('Noteop1', 2, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultPlayerStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 0.5, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 0.5, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 0.5)
                end
            end
        end
        moveYOpponent = true
        moveYPlayer = true
    end
    if curStep == 1792 then
        if not middlescroll then
            noteTweenX('NoteX4', 4, defaultPlayerStrumX0, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, defaultPlayerStrumX1, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, defaultPlayerStrumX2, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, defaultPlayerStrumX3, 0.3, 'sineOut')
            move = false
            doTweenX('cam','camHUD', 0, 1, 'linear')
            noteTweenX('Noteop1', 2, defaultOpponentStrumX2, 0.3, 'sineOut')
            noteTweenX('Noteop2', 3, defaultOpponentStrumX3, 0.3, 'sineOut')
            if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
                noteTweenAlpha('alphaNote0', 0, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote1', 1, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote2', 2, 1, 0.3, 'sineIn')
                noteTweenAlpha('alphaNote3', 3, 1, 0.3, 'sineIn')
                if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                    setProperty("opponentHoldCovers.alpha", 1)
                end
            end
        end
        moveYOpponent = false
        moveYPlayer = false
    end
    if curStep == 1920 then
        moveYOpponent = true
    end
    if curStep == 1984 then
        moveYPlayer = true
    end
    if curStep == 2048 then
        moveYOpponent = false
        moveYPlayer = false
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

function onUpdate()
    local currentBeat = (getSongPosition() / 1000) * (bpm / 60)
    if moveYOpponent == true then
        for i = 0, 3 do
            if not originalYPositionsOpponent[i] then
                originalYPositionsOpponent[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
            end
            local strumY = originalYPositionsOpponent[i]
            local newY = (strumY + 15 * math.cos((currentBeat + i * 0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', newY)
        end
    else
        for i = 0, 3 do
            if originalYPositionsOpponent[i] then
                setPropertyFromGroup('strumLineNotes', i, 'y', originalYPositionsOpponent[i])
            end
        end
    end

    if moveYPlayer == true then
        for i = 4, 7 do
            if not originalYPositionsPlayer[i] then
                originalYPositionsPlayer[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
            end
            local strumY = originalYPositionsPlayer[i]
            local newY = (strumY + 15 * math.cos((currentBeat + i * 0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', newY)
        end
    else
        for i = 4, 7 do
            if originalYPositionsPlayer[i] then
                setPropertyFromGroup('strumLineNotes', i, 'y', originalYPositionsPlayer[i])
            end
        end
    end
end
----------------------------------------------------------------------