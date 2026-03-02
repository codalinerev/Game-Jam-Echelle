function initGame()

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
pomme = love.graphics.newImage("assets/terrain/pomme1.png")
tuiles[5] = pomme
tuiles[6] = coin
spawnPositions = {}
spawnPositions = {47, 38, 225, 90, 82 }


GUI = {}
--GUI.font = love.graphics.newFont("assets/PressStart2P-Regular.ttf", 16)
GUI.color = {0.7, 0.6, 0.7}
GUI.bgColor = {0.2, 0.2, 0.2, 0.4}
GUI.txt1 = "Press SPACE to start"
GUI.txt2 = "blablabla!"

GUI.x = 600
GUI.y = 450
heroTable = require("hero")
Perso = perso
score = 0
pdv = 100
GUI.score = score
GUI.pdv = pdv
pommes = 1
coins = 1
degats = 0
isGameOver = false
timer = 0

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
MyHero = heroTable:newHero("MyHero", 339, 260, heroImage)
love.graphics.print("HELLO!  je commence", 100, 150, 0, 2, 2)

print("init images")
GUI.txt2 = MyHero.tileIndex
print(GUI.txt2)
myEnnemi = Perso:newPerso("ennemi", 70, 180, ennemiImage, 2, ennemimad)
print("create myEnnemi")
Bob = Perso:newPerso("Bob", 60, 470, imageInit, 3)
--Bob.speed = 40
Bob.isAnim = true
print("Bob a été crée!")
print("init hero et perso")
Perso:printListe()

end