--Made by Slushi, from Vs zRamirez Mod. Tested on Slushi Engine-- 
--Modified by DrkFon376

-----VARS-----
local move = false
local moveYOpponent = false
local moveYPlayer = false
local originalXPositionsOpponent = {}
local originalXPositionsPlayer = {}
local originalYPositionsOpponent = {}
local originalYPositionsPlayer = {}
-------------------

-----------------------MODCHART-----------------------
function onStepHit()
    if curStep == 512 then
        tweenArrowsPosition(middlescroll, false)
        move = true
        moveYOpponent = true
        moveYPlayer = true
    elseif curStep == 640 then
        tweenArrowsPosition(middlescroll, true)
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        moveYOpponent = false
        moveYPlayer = false
    elseif curStep == 768 then
        tweenArrowsPosition(middlescroll, false)
        move = true
        moveYOpponent = true
        moveYPlayer = true
    elseif curStep == 896 then
        tweenArrowsPosition(middlescroll, true)
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        moveYOpponent = false
        moveYPlayer = false
    elseif curStep == 1408 then
        tweenArrowsPosition(middlescroll, false)
        move = true
        moveYOpponent = true
        moveYPlayer = true
    elseif curStep == 1536 then
        tweenArrowsPosition(middlescroll, true)
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        moveYOpponent = false
        moveYPlayer = false
    elseif curStep == 1664 then
        tweenArrowsPosition(middlescroll, false)
        move = true
        moveYOpponent = true
        moveYPlayer = true
    elseif curStep == 1792 then
        tweenArrowsPosition(middlescroll, true)
        move = false
        doTweenX('cam','camHUD', 0, 1, 'linear')
        moveYOpponent = false
        moveYPlayer = false
    elseif curStep == 1920 then
        moveYOpponent = true
    elseif curStep == 1984 then
        moveYPlayer = true
    elseif curStep == 2048 then
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

function clearOriginalYPositions()
    for i = 0, 3 do
        originalYPositionsOpponent[i] = nil
    end
    for i = 4, 7 do
        originalYPositionsPlayer[i] = nil
    end
end

function tweenArrowsPosition(isMiddlescroll, originalPos)
    for i = 0, 3 do
        if not originalXPositionsOpponent[i] then
            originalXPositionsOpponent[i] = getPropertyFromGroup('strumLineNotes', i, 'x')
        end
    end
    for i = 4, 7 do
        if not originalXPositionsPlayer[i-4] then
            originalXPositionsPlayer[i-4] = getPropertyFromGroup('strumLineNotes', i, 'x')
        end
    end

    local targetAlpha = 0

    if isMiddlescroll then
        if not originalPos then
            targetAlpha = 1
            noteTweenX('NoteX0', 0, 92, 0.3, 'sineOut')
            noteTweenX('NoteX1', 1, 204, 0.3, 'sineOut')
            noteTweenX('NoteX2', 2, 316, 0.3, 'sineOut')
            noteTweenX('NoteX3', 3, 428, 0.3, 'sineOut')
            noteTweenX('NoteX4', 4, 732, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, 844, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, 956, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, 1068, 0.3, 'sineOut')
        else
            targetAlpha = 0.35
            for i = 0, 3 do
                noteTweenX('NoteX'..i, i, originalXPositionsOpponent[i], 0.3, 'sineOut')
            end
            for i = 4, 7 do
                noteTweenX('NoteX'..i, i, originalXPositionsPlayer[i-4], 0.3, 'sineOut')
            end
        end

        if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
            for i = 0, 3 do
                noteTweenAlpha('alphaNote'..i, i, targetAlpha, 0.3, 'sineIn')
            end
            if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                setProperty("opponentHoldCovers.alpha", targetAlpha)
            end
        end
    else
        if not originalPos then
            targetAlpha = 0.35
            noteTweenX('NoteX0', 0, 82, 0.3, 'sineOut')
            noteTweenX('NoteX1', 1, 194, 0.3, 'sineOut')
            noteTweenX('NoteX2', 2, 971, 0.3, 'sineOut')
            noteTweenX('NoteX3', 3, 1083, 0.3, 'sineOut')
            noteTweenX('NoteX4', 4, 412, 0.3, 'sineOut')
            noteTweenX('NoteX5', 5, 524, 0.3, 'sineOut')
            noteTweenX('NoteX6', 6, 636, 0.3, 'sineOut')
            noteTweenX('NoteX7', 7, 748, 0.3, 'sineOut')
        else
            targetAlpha = 1
            for i = 0, 3 do
                noteTweenX('NoteX'..i, i, originalXPositionsOpponent[i], 0.3, 'sineOut')
            end
            for i = 4, 7 do
                noteTweenX('NoteX'..i, i, originalXPositionsPlayer[i-4], 0.3, 'sineOut')
            end
        end

        if getPropertyFromClass("ClientPrefs", "opponentStrums") == true then
            for i = 0, 3 do
                noteTweenAlpha('alphaNote'..i, i, targetAlpha, 0.3, 'sineIn')
            end
            if getPropertyFromClass("ClientPrefs", "holdSplashes") == true then
                setProperty("opponentHoldCovers.alpha", targetAlpha)
            end
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