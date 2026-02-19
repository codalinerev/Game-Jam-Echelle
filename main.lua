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
txt.message = "mouse pos: "..love.mouse.getX() .. " , " .. love.mouse.getY()
txt.x = 600
txt.y = 200
--hero = {}

ennemi = {}
ennemiImage = love.graphics.newImage("assets/ennemi/alien_32.png")
heroImage = love.graphics.newImage("assets/hero/player_1_32.png")
imageInit = love.graphics.newImage("assets/persoInit.png")
MyHero = heroTable:newHero("MyHero", 339, 460, heroImage)
love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)

print("init images")
GUI.txt2 = MyHero.tileIndex
print(GUI.txt2)
myEnnemi = Perso:newPerso("ennemi", 100, 10, ennemiImage)
print("create myEnnemi")
Bob = Perso:newPerso("Bob", 200, 230, imageInit)
print("Bob a été crée!")
print("init hero et perso")

function love.load() 
end

function love.update(dt)
    txt.message = "mouse pos: "..love.mouse.getX() .. " , " .. love.mouse.getY()
    
    --myEnnemi:update(dt)
    MyHero:updateHero(dt)
    updateGUI()
    --Bob:move(0.3,-0.5)
    --myEnnemi:updateHero(dt)
    
end

function love.draw()
    --love.graphics.setColor(0.8, 0.9, 1)  
    love.graphics.rectangle("fill", txt.x - 20, txt.y - 20, 200, 100)
    love.graphics.setColor(0.2, 0.5, 0.3)
    love.graphics.print(txt.message, txt.x, txt.y, 0, 1, 1)
    --love.graphics.setColor(1, 1, 1)
    drawGrid()
    love.graphics.setColor(0.4, 0.4, 0.5, 0.2)
    drawMap()
    love.graphics.setColor(0.2, 0.2, 0.4, 1)
    drawGUI()
    --hero:draw()
    myEnnemi:draw()
    Bob:draw()
    MyHero:draw()  
    MyHero:drawGUIHero()  
    love.graphics.setColor(0.2, 0.3, 0.3)
end

function drawMap() ----------------- tilesize = 32    grid 16 x 16 ----
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

function drawGrid()
    local tileSize = 32
    for i = 1, #map1 do
        local x = ((i - 1) % 16) * tileSize
        local y = math.floor((i - 1) / 16) * tileSize   
        love.graphics.rectangle("line", x, y, tileSize, tileSize)
    end
end

function drawGUI()
    --love.graphics.setFont(GUI.font)
    love.graphics.setColor(GUI.bgColor)
    love.graphics.rectangle("fill", GUI.x - 10, GUI.y - 10, 300, 100)
    love.graphics.setColor(GUI.color)
    love.graphics.print(GUI.txt1, GUI.x, GUI.y)
    love.graphics.print(GUI.txt2, GUI.x, GUI.y + 20)
    love.graphics.print(GUI.txt3, GUI.x, GUI.y + 40)
end

function updateGUI()
    print("type de tuile : " ..map1[MyHero.tileIndex])
    GUI.txt2 = "Tile " .. map1[MyHero.tileIndex]  --map1[MyHero.tileIndex]
    GUI.txt3 = "next state: " ..MyHero.nextState
    GUI.txt1 = "state: " .. MyHero.state
end

function WhichTile(posX, posY)
        local tileX = math.floor((posX + 16) / 32) + 1
        local tileY = math.floor((posY + 16) / 32) + 1
        local tileIndex = (tileY - 1) * 16 + tileX
        return tileIndex
    end

function love.keypressed(key)
    if key == "space" then
        txt.message = "space pressed"
    end
end

function love.mouse.getPosition()
    local x, y = love.mouse.getPosition()
    return x, y
end
