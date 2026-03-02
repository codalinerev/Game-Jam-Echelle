require("perso")
require ("map1")
require("initGame")

function love.load() 
    initGame()
    print("init game")
end

function love.update(dt)
    --txt.message = "mouse pos: "..love.mouse.getX() .. " , " .. love.mouse.getY()
    if pommes == 0 then spawnPommes() end
    if coins == 0 then spawnCoins() end
    updateScore()
    myEnnemi:update(dt)
    MyHero:updateHero(dt)
    Bob:update(dt)
    updateGUI()
    if pdv <= 0 then isGameOver = true  end 
end

function love.draw()
    if isGameOver then drawGameOver()
    else drawGame() end
end

function drawGame()

    love.graphics.setColor(1, 1, 1)
    drawGrid()
    drawMap()
    myEnnemi:draw()
    Bob:draw()
    MyHero:draw()  
    --MyHero:drawGUIHero()  
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
        if tuiles[j] == 4 then love.graphics.draw(tuiles[1], x, y) end  --background derriere l'echelle
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
    love.graphics.rectangle("fill", 530, 20, 250, 450)
    love.graphics.setColor(GUI.color)

        --, 0, 2, 2)
    local i = math.floor(pdv / 20) 
    print ("i: "..i)
    if i > 1 then for j = 1, i do love.graphics.draw(heart, 550 + j * 35, 50) end end
    love.graphics.draw(heart, 550, 50)
    love.graphics.print("SCORE "..score, 560, 430)
    love.graphics.print("pdv: "..pdv, 550, 370)
    love.graphics.print("degats: "..degats, 550, 320)
    love.graphics.draw(pomme, 550, 150, 0, 2, 2)
    love.graphics.print(MyHero.pommes, 590, 220)
    love.graphics.draw(coin, 650, 150, 0, 2, 2)
    love.graphics.print(MyHero.coins, 680, 220)
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
    if isGameOver and key == "p" then
        initGame()
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
        --if distance < 20 then
        if ((dx > 0 and dx < 30) or (dx < 0 and dx > -30)) and ((dy < 0 and dy > -30) or (dy > 0 and dy < 30)) then       
            txt.message = "Collision detected with " .. pers.name
            print(dx..","..dy)
            print("Collision detected with " .. pers.name)
            pers.badTemper = true
            pers.speed = 2
            degats = degats + pers.giveDamage
            pdv = pdv - pers.giveDamage       
            sfxOPerdon:play()
            pers.collisions = pers.collisions + 1
        end 
    end
    if map1[MyHero.tileIndex] == 5 then pommes = pommes - 1   map1[MyHero.tileIndex] = 1 pdv = pdv + 10 MyHero.pommes = MyHero.pommes + 1 end
    if map1[MyHero.tileIndex] == 6 then coins = coins - 1 MyHero.coins = MyHero.coins + 1  map1[MyHero.tileIndex] = 1 score = score + 20 end 
    --if tuiles[map[hero.x, hero.y]] == 5 or tuiles[map[hero.x, hero.y]] == 6
end  

function drawGameOver()
    love.graphics.setColor(0.5, 0.5, 0.8)
    love.graphics.print("GAME OVER", 250, 200, 0, 4, 4)
    love.graphics.print("Score: "..score, 350, 300, 0, 2, 2)   
    love.graphics.print("press p to play again", 300, 400)
end

function spawnPommes()
    local rand = math.random(1, #spawnPositions)
    --print(rand)
    if map1[spawnPositions[rand]] == 6 then spawnPommes() else map1[spawnPositions[rand]] = 5 end
    pommes = 1
    
end

function spawnCoins()
    local rand = math.random(1, #spawnPositions)
    --print(rand)
    if map1[spawnPositions[rand]] == 5 then spawnCoins() else map1[spawnPositions[rand]] = 6 end
    coins = 1
end 