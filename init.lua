local log = hs.logger.new('wang','debug')
-- Set hyper to ctrl + alt + cmd + shift
local hyper      = {'ctrl', 'cmd', 'alt'}

-- Move Mouse to center of next Monitor
hs.hotkey.bind(hyper, 'right', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:toEast()

    if not nextScreen then
        return
    end

    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
 
    hs.mouse.absolutePosition(center)
    hs.eventtap.leftClick(center, 100)
end)

-- Move Mouse to center of previous Monitor
hs.hotkey.bind(hyper, 'left', function()
    local screen = hs.mouse.getCurrentScreen()
    local previousScreen = screen:toWest()

    if not previousScreen then 
        return
    end

    local rect = previousScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
 
    hs.mouse.absolutePosition(center)
    hs.eventtap.leftClick(center, 100)
end)


-- 将当前窗口移动到第 n 个屏幕
-- 并最大化窗口
local hyper2 = {'ctrl', 'cmd'}
    
-- hyper + shift + left move the current window to the left monitor
hs.hotkey.bind(hyper2, 'left', function() 
    local w = hs.window.focusedWindow()

    if not w then 
        return
    end

    local wSize = w:size()
    log:d('window size', wSize.w)

    w:moveOneScreenWest(false, true)
end)

-- hyper + shift + right move the current window to the right monitor
hs.hotkey.bind(hyper2, 'right', function() 
    local w = hs.window.focusedWindow()
    if not w then 
        return
    end

    w:moveOneScreenEast(false, true)
end)

hs.hotkey.bind(hyper2, 'up', function() 
    local w = hs.window.focusedWindow()
    if not w then 
        return
    end

    local isFullScreen = w:isFullScreen()
    if isFullScreen then
        return
    end

    w:setFullScreen(true)
end)

hs.hotkey.bind(hyper2, 'down', function() 
    local w = hs.window.focusedWindow()
    if not w then 
        return
    end

    local isFullScreen = w:isFullScreen()
    if not isFullScreen then
        return
    end

    w:setFullScreen(false)
end)

local hyper3 = {'alter', 'cmd'}

hs.hotkey.bind(hyper3, 'left', function() 
    moveTo({0, 0, 0.5, 1}) 
end)

hs.hotkey.bind(hyper3, 'right', function() 
    moveTo({0.5, 0, 0.5, 1}) 
end)

hs.hotkey.bind(hyper3, 'up', function() 
    moveTo({0, 0, 1, 0.5}) 
end)

hs.hotkey.bind(hyper3, 'down', function() 
    moveTo({0, 0.5, 1, 0.5}) 
end)

-- move window to target pos
function moveTo(pos) 
    local w = hs.window.focusedWindow()
    if not w then 
        return
    end

    local isFullScreen = w:isFullScreen()
    if isFullScreen then
        w:setFullScreen(false)
    end

    w:moveToUnit(pos)
end
