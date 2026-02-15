perso =require "perso"

love.graphics.setDefaultFilter("nearest")
love.graphics.setBackgroundColor(0.4, 0.1, 0.2)

txt = {}
txt.message = "press space to start"
txt.x = 500
txt.y = 200
hero = {}
ennemi = {}
ennemiImage = love.graphics.newImage("assets/ennemi/alien_32.png")
heroImage = love.graphics.newImage("assets/hero/player_1_32.png")
myHero = perso:newPerso("hero", 20, 20, heroImage)
myEnnemi = perso:newPerso("ennemi", 150, 100, ennemiImage)
print("init hero et perso")
print(myHero.posX)
print(myEnnemi.posX)

function love.load()
    
end

function love.update(dt)
    if love.keyboard.isDown("up") then myHero.posY = myHero.posY - 100 * dt end
    if love.keyboard.isDown("down") then myHero.posY = myHero.posY + 100 * dt end
    if love.keyboard.isDown("left") then myHero.posX = myHero.posX - 100 * dt end
    if love.keyboard.isDown("right") then myHero.posX = myHero.posX + 100 * dt end
end

function love.draw()
    love.graphics.setColor(0.8, 0.9, 1)
    love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)
    
    love.graphics.rectangle("fill", txt.x - 20, txt.y - 20, 200, 100)
    love.graphics.setColor(0.2, 0.1, 0.1)
    love.graphics.print(txt.message, txt.x, txt.y, 0, 1, 1)
    myHero:draw()
    myEnnemi:draw()
end

function love.keypressed(key)
    if key == "space" then
        txt.message = "space pressed"
    end
end
