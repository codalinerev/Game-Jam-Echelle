require("perso")
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
    --[[ if love.keyboard.isDown("up") then myHero.posY = myHero.posY - 100 * dt end
    if love.keyboard.isDown("down") then myHero.posY = myHero.posY + 100 * dt end
    if love.keyboard.isDown("left") then myHero.posX = myHero.posX - 100 * dt end
    if love.keyboard.isDown("right") then myHero.posX = myHero.posX + 100 * dt end
    if love.keyboard.isDown("space") then txt.message = "space pressed"
    if love.keyboard.isDown("j") then txt.message = "jump" end   
    end ]]
    myHero:update(dt)
    myEnnemi:update(dt)
    --print(myEnnemi.target[2])
    Bob:move(0.3,0.5)


end

function love.draw()
    love.graphics.setColor(0.8, 0.9, 1)
    love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)
    
    love.graphics.rectangle("fill", txt.x - 20, txt.y - 20, 200, 100)
    love.graphics.setColor(0.2, 0.1, 0.1)
    love.graphics.print(txt.message, txt.x, txt.y, 0, 1, 1)
    myHero:draw()
    myEnnemi:draw()
    Bob:draw()
end

function love.keypressed(key)
    if key == "space" then
        txt.message = "space pressed"
    end
end
