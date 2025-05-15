-- Settings
local triggerBeats = {28, 188, 380, 508}
local bpm = 178 -- BPM from the song

local counterImages = {'three', 'two', 'one', 'go'}
local usedBeats = {}

function onCreate()
    for i = 1, #counterImages do
        makeLuaSprite('count' .. i, 'counter/' .. counterImages[i], 0, 0)
        setObjectCamera('count' .. i, 'camHUD')
        setProperty('count' .. i .. '.alpha', 0)
        screenCenter('count' .. i)
        addLuaSprite('count' .. i, false)
    end
end

function onBeatHit()
    for i = 1, #triggerBeats do
        local beat = triggerBeats[i]
        if curBeat == beat and not usedBeats[beat] then
            usedBeats[beat] = true

            local beatLength = 60 / bpm --Beat duration per second

            for j = 1, #counterImages do
                runTimer('showCount' .. j .. '_at_' .. beat, (j - 1) * beatLength)
            end
        end
    end
end

function onTimerCompleted(tag)
    for i = 1, #counterImages do
        for j = 1, #triggerBeats do
            local beat = triggerBeats[j]
            if tag == 'showCount' .. i .. '_at_' .. beat then
                setProperty('count' .. i .. '.alpha', 0)
                doTweenAlpha('fadeIn' .. i .. '_at_' .. beat, 'count' .. i, 1, 0.001, 'linear')
                runTimer('hideCount' .. i .. '_at_' .. beat, 0.15)
            elseif tag == 'hideCount' .. i .. '_at_' .. beat then
                doTweenAlpha('fadeOut' .. i .. '_at_' .. beat, 'count' .. i, 0, 0.15, 'linear')
            end
        end
    end
end
