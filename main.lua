local bill = require("demo.bill")
local lonk = require("demo.lonk")
local luigini = require("demo.luigini")

local currentDemo = lonk
local showHelp = false

function love.keypressed(key, scan, isRepeat)
    local handled = false
    if not isRepeat then
        if key == "1" then
            currentDemo = lonk
            handled = true
        elseif key == "2" then
            currentDemo = luigini
            handled = true
        elseif key == "3" then
            currentDemo = bill
            handled = true
        elseif key == "f1" then
            showHelp = not showHelp
        end
    end

    if not handled and currentDemo.keypressed then
        currentDemo.keypressed(key, scan, isRepeat)
    end
end

function love.mousemoved(...)
    if currentDemo.mousemoved then
        currentDemo.mousemoved(...)
    end
end

function love.update(deltaTime)
    if not showHelp then
        currentDemo.update(deltaTime)
    end
end

local help = [[
slick demo

- press f1 to close help

global controls
- 1: legend of lönk top-down "RPG" demo
- 2: luigini brothers platformer demo
- 3: bill c. triangulation demo
]]

function love.draw()
    love.graphics.push("all")
    if showHelp then
        love.graphics.print(help, 8, 8)
        
        local _, lines = love.graphics.getFont():getWrap(help, love.graphics.getWidth())
        love.graphics.translate(0, (#lines + 1) * love.graphics.getFont():getHeight())

        if currentDemo.help then
            currentDemo.help()
        end
    else
        love.graphics.push("all")
        currentDemo.draw()
        love.graphics.pop()

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.printf("press f1 for help", 1, 9, love.graphics.getWidth(), "center")
        love.graphics.setColor(1, 0, 1, 1)
        love.graphics.printf("press f1 for help", 0, 8, love.graphics.getWidth(), "center")
    end
    love.graphics.pop()
end
