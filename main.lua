require("perso")
heroTable = require("hero")
Perso = perso

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
imageInit = love.graphics.newImage("assets/persoInit.png")
MyHero = heroTable:newHero("MyHero", 220, 120, heroImage)


print("init images")
hero = Perso:newPerso("hero", 20, 20, heroImage)
print("create myHero")
--Perso.printListe()
print(hero.name)
hero.hasPlan = false
myEnnemi = Perso:newPerso("ennemi", 100, 10, ennemiImage)
print("create myEnnemi")
Bob = Perso:newPerso("Bob", 200, 230, imageInit)
print("Bob a été crée!")
print("init hero et perso")
--print(myHero.posX)
--

function love.load()
    
end

function love.update(dt)
    if love.keyboard.isDown("space") then txt.message = "space pressed" end
    if love.keyboard.isDown("j") then txt.message = "jump" end
    hero:updateHero(dt)
    myEnnemi:update(dt)
    MyHero:updateHero(dt)
    --print(myEnnemi.target[2])
    Bob:move(0.3,-0.5)


end

function love.draw()
    love.graphics.setColor(0.8, 0.9, 1)
    love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)
    
    love.graphics.rectangle("fill", txt.x - 20, txt.y - 20, 200, 100)
    love.graphics.setColor(0.2, 0.1, 0.1)
    love.graphics.print(txt.message, txt.x, txt.y, 0, 1, 1)
    hero:draw()
    myEnnemi:draw()
    Bob:draw()
    MyHero:draw()
end

function love.keypressed(key)
    if key == "space" then
        txt.message = "space pressed"
    end
end
