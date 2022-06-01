local composer = require( "composer" )
local physics = require ("physics")
local scene = composer.newScene()
local widget = require( "widget" )
physics.start()

local audio1 = audio.loadSound( "sound/sound.mp3" )
local audio2 = audio.loadSound( "sound/min-life.mp3" )
local audio3 = audio.loadSound( "sound/heal-sound.mp3" )

function scene:create( event )
local sceneGroup = self.view

local spawnBomb_timer
local spawnPlus_timer
local spawnHeal_timer
local spawnPlus5_timer
local life = 7
local count = 0

local background = display.newImageRect(sceneGroup,"images/game-bg.png", 350, 600)
background.x = display.contentCenterX
background.y = display.contentCenterY

--спавн +25 и -25
local function spawnBomb ()
  local bomb = display.newImageRect("images/broken-heart.png", 60, 60)
  bomb.x = math.random(10,460)
  bomb.y = -200
  bomb.height = h-100
  bomb.width = w-90
  bomb.myName = "bomb"
  physics.addBody(bomb, "dynamic", {radius = 20, isSensor = true})
  end
  spawnBomb_timer = timer.performWithDelay (200,spawnBomb, 0)

  local function spawnPlus()
  local plus = display.newImageRect("images/green-apple.png", 50, 50)
  plus.x = math.random(10, 460)
  plus.y = -200
  plus.height = h-100
  plus.width = w-90
  plus.myName = "plus"
  physics.addBody(plus, "dynamic", {radius = 10, isSensor = true})
  end
  spawnPlus_timer = timer.performWithDelay (1300, spawnPlus, 0)

  local function spawnPlus5()
  local plus5 = display.newImageRect("images/strawberry.png", 50,50)
  plus5.x = math.random(10, 460)
  plus5.y = -200
  plus5.height = h-100
  plus5.width = w-90
  plus5.myName = "plus5"
  physics.addBody(plus5, "dynamic", {radius = 10, isSensor = true})
  end
  spawnPlus5_timer = timer.performWithDelay (5300,spawnPlus5, 0)

  local function spawnHeal()
  local heal = display.newImageRect("images/life.png", 50,50)
  heal.x = math.random(10, 460)
  heal.y = -200
  heal.height = h-100
  heal.width = w-90
  heal.myName = "heal"
  physics.addBody(heal, "dynamic", {radius = 10, isSensor = true})
  end
  spawnHeal_timer = timer.performWithDelay (7300,spawnHeal, 0)

--игрок
local player = display.newImage(sceneGroup, tst3, 100, 470)
player.height = h
player.width = w
player.myName = "player"
physics.addBody(player, "dynamic", {radius = 20, isSensor = true} )
    player.gravityScale = 0

--управление игроком
local function dragPlayer (event)
  if(event.phase == "began") then
      display.currentStage:setFocus(player)
      player.touchOffsetX = event.x - player.x
  elseif(event.phase == "moved") then
    player.x = event.x - player.touchOffsetX
  elseif(event.phase == "ended") then
    display.currentStage:setFocus(nil)
    return true
end
end

--информация о жизнях и набранных очках
local countText = display.newText(sceneGroup,"Очки:"..count, 255, -10, "20704.otf", 24)
local lifeText = display.newText(sceneGroup,"Жизни:".. life, 70, -10, "20704.otf", 24)
player:addEventListener("touch", dragPlayer)

local function onPlayAgainTouch()
        composer.gotoScene("scenes.menu", "fade") -- move player to menu
    end

local function incCount()
count = count + 2
countText.text = "Очки:"..count
end

local function incCount5()
count = count + 5
countText.text = "Очки:"..count
end

local function minLife()
  life = life - 1
  lifeText.text = "Жизни:"..life
end

local function incLife()
if (life < 7) then
life = life + 1
lifeText.text = "Жизни:"..life
end
end

local function onCollision (event)
  if(event.phase == "began") then
    local obj1 = event.object1
    local obj2 = event.object2
if (obj1.myName == "player" and obj2.myName == "bomb") then
    local audio2Channel = audio.play( audio2 )
      minLife()
      display.remove(obj2)
      if (life == 0) then
        display.remove(obj1)
        timer.cancel(spawnBomb_timer)
        timer.cancel(spawnPlus_timer)
        timer.cancel(spawnPlus5_timer)
        timer.cancel(spawnHeal_timer)
        display.remove(countText)
        display.remove(lifeText)

      local gameOverBack = display.newRect(sceneGroup, 0, 0, display.actualContentWidth, display.actualContentHeight)
      gameOverBack.x = display.contentCenterX
      gameOverBack.y = display.contentCenterY
      gameOverBack:setFillColor(0)
      gameOverBack.alpha = 0.5
      local gameOverText1 = display.newText( sceneGroup, "Вы проиграли", 100, 200, "20704.otf", 32 )
      gameOverText1.x = display.contentCenterX
      gameOverText1.y = 150
      gameOverText1:setFillColor( 1, 1, 1 )
      local gameOverText2 = display.newText( sceneGroup, "Ваш счет: "..count, 100, 200, "20704.otf", 32 )
      gameOverText2.x = display.contentCenterX
      gameOverText2.y = 220
      gameOverText2:setFillColor( 1, 1, 1 )
      local playAgain = widget.newButton{
         width = 180,
         height = 70,
         defaultFile = "images/button-pink.png",
         overFile = "images/button-pink-hover.png",
         label = "В меню",
         font = "20704.otf",
         fontSize = 24,
         labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
         onEvent = onPlayAgainTouch
      }
      playAgain.x = display.contentCenterX
      playAgain.y = gameOverText2.y + 100
      table.insert(sceneGroup,playAgain)
      return sceneGroup
      end
      elseif (obj1.myName == "player" and obj2.myName == "plus") then
        local audio1Channel = audio.play( audio1 )
            incCount()
            display.remove(obj2)
      elseif (obj1.myName == "player" and obj2.myName == "plus5") then
        local audio1Channel = audio.play( audio1 )
            incCount5()
            display.remove(obj2)
      elseif (obj1.myName == "player" and obj2.myName == "heal") then
        local audio3Channel = audio.play( audio3 )
          incLife()
          display.remove(obj2)
        end
    end
end
Runtime:addEventListener("collision", onCollision)
end

function scene:show( event )
  local prevScene = composer.getSceneName( "previous" )
  if(prevScene) then
    composer.removeScene(prevScene)
      end
end

function scene:hide( event )
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then

    end
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene