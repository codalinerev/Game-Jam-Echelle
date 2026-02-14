love.graphics.setDefaultFilter("nearest")
love.graphics.setBackgroundColor(0.4, 0.1, 0.2)

txt = {}
txt.message = "press space to start"
txt.x = 500
txt.y = 200

function love.load()
end

function love.update(dt)
end

function love.draw()
    love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)
    love.graphics.rectangle("line", txt.x - 20, txt.y - 20, 200, 100)
    love.graphics.print(txt.message, txt.x, txt.y, 0, 1, 1)
end

function love.keypressed(key)
    if key == "space" then
        txt.message = "space pressed"
    end
end
