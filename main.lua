require("perso")
require ("map1")
tuiles = {}
tuiles[1] = love.graphics.newImage("assets/terrain/black.png")
tuiles[3] = love.graphics.newImage("assets/terrain/coffeeBeans.png")
tuiles[2] = love.graphics.newImage("assets/terrain/brique4.png")
tuiles[4] = love.graphics.newImage("assets/terrain/echelle7.png")
sfxOPerdon = love.audio.newSource("assets/sons/opardon.wav", "static")
heart = love.graphics.newImage("assets/GUI/coeur.png")
coin = love.graphics.newImage("assets/GUI/coin.png")
pomme = love.graphics.newImage("assets/terrain/pommeRed.png")
tuiles[5] = pomme
tuiles[6] = coin
spawnPositions = {}
spawnPositions = {5, 25, 30, 78}


GUI = {}
--GUI.font = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 16)
GUI.color = {0.5, 0.2, 0.5}
GUI.bgColor = {0.2, 0.2, 0.2, 0.8}
GUI.txt1 = "Press SPACE to start"
GUI.txt2 = "blablabla!"

GUI.x = 600
GUI.y = 450
heroTable = require("hero")
Perso = perso
score = 0
pdv = 5
GUI.score = score
GUI.pdv = pdv
pommes = 0
coins = 0
degats = 0
isGameOver = false

love.graphics.setDefaultFilter("nearest")
--love.graphics.setBackgroundColor(0.4, 0.3, 0.2)


txt = {} --- GUI text
txt.message = "mouse pos: "..love.mouse.getX() .. " , " .. love.mouse.getY()
txt.x = 600
txt.y = 250

ennemi = {}
ennemiImage = love.graphics.newImage("assets/ennemi/greenEnemy.png")
ennemimad = love.graphics.newImage("assets/ennemi/enemyGmad.png")
heroImage = love.graphics.newImage("assets/hero/joyCalm.png")
imageInit = love.graphics.newImage("assets/ennemi/ball1.png")
MyHero = heroTable:newHero("MyHero", 339, 460, heroImage)
love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)

print("init images")
GUI.txt2 = MyHero.tileIndex
print(GUI.txt2)
myEnnemi = Perso:newPerso("ennemi", 70, 180, ennemiImage, 2)
print("create myEnnemi")
Bob = Perso:newPerso("Bob", 60, 470, imageInit, 3)
Bob.speed = 40
Bob.isAnim = true
print("Bob a été crée!")
print("init hero et perso")
Perso:printListe() 
function love.load() 
end

function love.update(dt)
    txt.message = "mouse pos: "..love.mouse.getX() .. " , " .. love.mouse.getY()
    if pommes == 0 then spawnPommes() end
    if coins == 0 then spawnCoins() end
    updateScore()
    myEnnemi:update(dt)
    MyHero:updateHero(dt)
    Bob:update(dt)
    updateGUI()
    if degats > 100 then isGameOver = true   end 
end

function love.draw()
    if isGameOver then drawGameOver()
    else drawGame()
    end
end

function drawGame()
    love.graphics.setColor(0.8, 0.9, 1)  
    love.graphics.rectangle("fill", txt.x - 20, txt.y - 20, 200, 100)
    love.graphics.setColor(0.2, 0.5, 0.3)
    love.graphics.print(txt.message, txt.x, txt.y, 0, 1, 1)
    love.graphics.setColor(1, 1, 1)
    drawGrid()
    drawMap()
    myEnnemi:draw()
    Bob:draw()
    MyHero:draw()  
    MyHero:drawGUIHero()  
    love.graphics.setColor(0.2, 0.3, 0.3)
    drawGUI()
end

function drawMap() ----------------- tilesize = 32    grid 16 x 16 ----
    local tileSize = 32

    for i = 1, #map1 do
        local x = ((i - 1) % 16) * tileSize
        local y = math.floor((i - 1) / 16) * tileSize
        --print(map1[i]).    
        local j = map1[i]
        if tuiles[j] == 4 then love.graphics.draw(tuiles[1], x, y) end
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
    love.graphics.draw(heart, 590, 120, 0, 2, 2)
    love.graphics.print("SCORE "..score, 650, 420)
    love.graphics.draw(pomme, 610, 390, 0, 2, 2)
    love.graphics.draw(coin, 680, 330, 0, 2, 2)
    love.graphics.setColor(1, 1, 1)
end

function updateGUI()
    --print("type de tuile : " ..map1[MyHero.tileIndex])
    GUI.txt2 = "pdv "..pdv  --map1[MyHero.tileIndex]
    GUI.txt3 = "degats: " ..degats
    GUI.txt1 = "score:  " .. score
    GUI.pdv = pdv
    GUI.score = score
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

function updateScore() --check collision with hero and ennemi
    for i, pers in ipairs(listePerso) do
       local dx = MyHero.posX - pers.posX
        local dy = MyHero.posY - pers.posY
        local distance = math.sqrt(dx * dx + dy * dy)
        if distance < 20 then
            txt.message = "Collision detected with " .. pers.name
            degats = degats + pers.giveDamage       
            sfxOPerdon:play()
            pers.collisions = pers.collisions + 1
        end 
    end
    if map1[MyHero.tileIndex] == 5 then pommes = pommes + 1   map1[MyHero.tileIndex] = 1 pdv = pdv + 20 end
    if map1[MyHero.tileIndex] == 6 then coins = coins + 1   map1[MyHero.tileIndex] = 1 score = score + 20 end 
    --if tuiles[map[hero.x, hero.y]] == 5 or tuiles[map[hero.x, hero.y]] == 6
end  

function drawGameOver()
    love.graphics.setColor(0.5, 0.5, 0.8)
    love.graphics.print("GAME OVER", 250, 200, 0, 4, 4)
    love.graphics.print("Score: "..score, 350, 300, 0, 2, 2)
end

function spawnPommes()
    local rand = math.random(1, #spawnPositions)
    print(rand)
    map1[rand] = 5
    pommes = 1
    
end

function spawnCoins()
end

