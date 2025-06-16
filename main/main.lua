local display, system, Runtime, native = display, system, Runtime, native

local config = require("assets.config")
local bd = config.bd
local tf = config.tf
local t = config.t
local f = config.f
local s = config.s
local trtdnt = config.trtdnt

local function toggleFunction() --> #ревизия 11.05.2025
    s.w = not s.w
    trtdnt.w = not trtdnt.w
end

local function createSkyGradient(horizonColor, zenithColor) --> #ревизия 11.05.2025
    local skyRect = display.newRect(bd.w * 0.5, bd.h * 0.5, bd.w, bd.h)
    local paint = {
        type = "gradient",
        color1 = horizonColor,
        color2 = zenithColor,
        direction = "down"
    }
    skyRect.fill = paint
    return skyRect
end

local function createStars(numStars) --> #ревизия 11.05.2025
    local starsGroup = display.newGroup()
    for i = 1, numStars do
        local x = math.random(0, bd.w)
        local y = math.random(0, bd.h * 0.7)
        local starSize = math.random(2,4)
        local alpha = 0.3 + math.random() * 0.7
        local star = display.newCircle(starsGroup, x, y, starSize)
        star:setFillColor(1, 1, 1, alpha)
    end
    return starsGroup
end

local function twinkleStars() --> #ревизия 11.05.2025
    for i = 1, f.s.numChildren do
        local star = f.s[i]
        star.alpha = 0.3 + math.abs(math.sin(system.getTimer() * 0.002 + i)) * 0.7
    end
end

local function trt_main() --> #ревизия 11.05.2025
    local toprighttext = display.newText(trtdnt.f, 0, 0, tf.f, tf.s) 
    toprighttext.anchorX = 0
    toprighttext.anchorY = 0
    return toprighttext
end

local function onEnterFrame() --> #ревизия 11.05.2025
    if not trtdnt.w then
        trtdnt.m:setFillColor(20/255,12/256,28/255)
        bd.d=os.date("!*t")
        trtdnt[1]="FPS: "..display.fps
        trtdnt[4]="TIME:"..(bd.d.hour+3)..":"..bd.d.min..":"..bd.d.sec
        for i = 1, #trtdnt do trtdnt.f=trtdnt[i] .."\n".. trtdnt.f end
        trtdnt.m.text = trtdnt.f
        trtdnt.f=""
    else trtdnt.m:setFillColor(0,0,0,0) end
end

local function frame_main() --> #ревизия 11.05.2025
    twinkleStars()
    onEnterFrame()
end

local function track() --> #ревизия 11.05.2025
        local trackGroup = display.newGroup()

    for i = 1, t.n do
        local tileImage = t.i[(i % 2) + 1]
        local tile = display.newImageRect(trackGroup, bd.pathp..tileImage, 24*t.d, 4*t.d)
        tile.fill.effect = "filter.pixelate"
        tile.fill.effect.numPixels = 1
        tile.x = t.x + (i - 1) * 24 *t.d
        tile.y = t.y
    end
end

local function button_settings() --> #ревизия 11.05.2025
    local settingsButton = display.newImageRect("assets/images/settings_s_1.png", 64, 64)
    settingsButton.fill.effect = "filter.pixelate"
    settingsButton.fill.effect.numPixels = 1
    local margin = 20
    settingsButton.x = bd.w - margin - settingsButton.width / 2
    settingsButton.y = bd.h - margin - settingsButton.height / 2 -t.sx

    settingsButton:addEventListener("tap", function()
        toggleFunction()
        if s.w then
            settingsButton.alpha = 1
        else
            settingsButton.alpha = 0.5
        end
    end)
    settingsButton.alpha = 0.5
end 

local function mouse_settings() --> #ревизия 16.06.2025
    native.setProperty( "mouseCursorVisible", false )

    local cursor = display.newImage("assets/images/arrow.png")

    cursor.x, cursor.y = display.contentCenterX, display.contentCenterY
    cursor:scale(8,8)
    cursor.fill.effect = "filter.pixelate"
    
    cursor.fill.effect.numPixels = 1
    local function onMouse(event)

        cursor.x = event.x
        cursor.y = event.y
        return true
    end

    Runtime:addEventListener("mouse", onMouse)
end

local function button_attack() --> #ревизия 16.06.2025
    local imagePath1 = "assets/images/attack/1.png"
    local imagePath2 = "assets/images/attack/2.png"


    local button = display.newImage(imagePath1, display.contentCenterX, display.contentCenterY)

    button.fill.effect = "filter.pixelate"
    button.fill.effect.numPixels = 1
    local margin = 20
    button.x = bd.w - margin - button.width / 2 - t.s*4
    button.y = bd.h - margin - button.height / 2 - t.sx*2
    button:scale(4,4)
    local isFirstImage = true

    local function onButtonTouch(event)
        if event.phase == "ended" then
            if isFirstImage then
                button:removeSelf()
                button = display.newImage(imagePath2, display.contentCenterX, display.contentCenterY)
                isFirstImage = false
            else
                button:removeSelf()
                button = display.newImage(imagePath1, display.contentCenterX, display.contentCenterY)
                isFirstImage = true
            end
            button.fill.effect = "filter.pixelate"
            button.fill.effect.numPixels = 1
            local margin = 20
            button.x = bd.w - margin - button.width / 2 - t.s*4
            button.y = bd.h - margin - button.height / 2 - t.sx*2
            button:scale(4,4)
            button:addEventListener("touch", onButtonTouch)
        end
        return true
    end

    button:addEventListener("touch", onButtonTouch)
end

-- mouse_settings() --> для win(desktop)

createSkyGradient(f.h, f.z)
f.s = createStars(f.q)
trtdnt.m=trt_main()
track()
button_settings()
button_attack()
Runtime:addEventListener("enterFrame", frame_main)