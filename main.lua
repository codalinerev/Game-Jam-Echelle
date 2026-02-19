require("perso")
require ("map1")
tuiles = {}
tuiles[1] = love.graphics.newImage("assets/terrain/greenTexture.png")
tuiles[3] = love.graphics.newImage("assets/terrain/coffeeBeans.png")
tuiles[2] = love.graphics.newImage("assets/terrain/bricks.png")
tuiles[4] = love.graphics.newImage("assets/terrain/echelle.png")

GUI = {}
--GUI.font = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 16)
GUI.color = {1, 0.2, 0.5}
GUI.bgColor = {0.2, 0.2, 0.2, 0.8}
GUI.txt1 = "Press SPACE to start"
GUI.txt2 = "blablabla!"

GUI.x = 600
GUI.y = 450
heroTable = require("hero")
Perso = perso

love.graphics.setDefaultFilter("nearest")
--love.graphics.setBackgroundColor(0.4, 0.3, 0.2)


txt = {} --- GUI text
txt.message = "press space to start"
txt.x = 600
txt.y = 200
hero = {}

ennemi = {}
ennemiImage = love.graphics.newImage("assets/ennemi/alien_32.png")
heroImage = love.graphics.newImage("assets/hero/player_1_32.png")
imageInit = love.graphics.newImage("assets/persoInit.png")
MyHero = heroTable:newHero("MyHero", 220, 120, heroImage)
love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)


print("init images")
hero = Perso:newPerso("hero", 20, 20, heroImage)
GUI.txt3 = MyHero.txt
print(GUI.txt3)
--Perso.printListe()
print(hero.name)
hero.hasPlan = false
myEnnemi = Perso:newPerso("ennemi", 100, 10, ennemiImage)
print("create myEnnemi")
Bob = Perso:newPerso("Bob", 200, 230, imageInit)
print("Bob a été crée!")
print("init hero et perso")

function love.load() 
end

function love.update(dt)
    if love.keyboard.isDown("space") then txt.message = "space pressed" end
    if love.keyboard.isDown("j") then txt.message = "jump" end
    hero:updateHero(dt)
    myEnnemi:update(dt)
    MyHero:updateHero(dt)
    GUI.txt3 = MyHero.txt
    --print(myEnnemi.target[2])
    Bob:move(0.3,-0.5)
end

function love.draw()
    --love.graphics.setColor(0.8, 0.9, 1)  
    love.graphics.rectangle("fill", txt.x - 20, txt.y - 20, 200, 100)
    love.graphics.setColor(0.2, 0.1, 0.1)
    love.graphics.print(txt.message, txt.x, txt.y, 0, 1, 1)
    love.graphics.setColor(1, 1, 1)
    draw_map()
    draw_GUI()
    hero:draw()
    myEnnemi:draw()
    Bob:draw()
    MyHero:draw()   
    love.graphics.setColor(0.2, 0.3, 0.3)
end

function draw_map() -----------------tilesize = 32----
    local tileSize = 32
    for i = 1, #map1 do
        local x = ((i - 1) % 16) * tileSize
        local y = math.floor((i - 1) / 16) * tileSize
        --print(map1[i]).    
        local j = map1[i]
        if tuiles[j] then love.graphics.draw(tuiles[j], x, y)     
        else  love.graphics.draw(tuiles[1], x, y)
        end
    end
end

function draw_GUI()
    --love.graphics.setFont(GUI.font)
    love.graphics.setColor(GUI.bgColor)
    love.graphics.rectangle("fill", GUI.x - 10, GUI.y - 10, 300, 100)
    love.graphics.setColor(GUI.color)
    love.graphics.print(GUI.txt1, GUI.x, GUI.y)
    love.graphics.print(GUI.txt2, GUI.x, GUI.y + 20)
    love.graphics.print(GUI.txt3, GUI.x, GUI.y + 40)
end

function love.keypressed(key)
    if key == "space" then
        txt.message = "space pressed"
    end
end
