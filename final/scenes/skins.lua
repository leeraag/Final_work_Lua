local composer = require( "composer" )
local scene = composer.newScene()

local function wer() -- lvl1
  tst1 = 'images/cat.png'
  h = 130
  w = 120
  x = 100
  y = 140
  composer.gotoScene("scenes.menu1")
end
local function wer2() -- lvl2
  tst2 = 'images/cat2.png'
  h = 130
  w = 120
  x = 100
  y = 140
  composer.gotoScene("scenes.menu2")
end
local function wer3() -- lvl3
  tst3 = 'images/cat3.png'
  h = 130
  w = 120
  x = 100
  y = 140
  composer.gotoScene("scenes.menu3")
end


local function Menu()
  composer.gotoScene("scenes.menu")
end

-- отображение сцены
function scene:create( event )
local sceneGroup = self.view

    local sceneGroup = self.view
    local background = display.newImageRect(sceneGroup,"images/background-menu.png", 350, 600)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    local name = display.newText(sceneGroup,"Уровни", display.contentCenterX-100, display.contentCenterY-180,"20704.otf", 25)

    local backMenu = display.newText(sceneGroup,"Меню", display.contentCenterX, display.contentCenterY+250,"20704.otf", 25)
    backMenu:addEventListener("tap", Menu)
    local play = display.newImage(sceneGroup, "images/cat.png", 100, 170)
    play.height = 170
    play.width = 140

    local play2 = display.newImage(sceneGroup, "images/cat2.png", 240, 170)
    play2.height = 170
    play2.width = 140

    local play3 = display.newImage(sceneGroup, "images/cat3.png", 160, 350)
    play3.height = 170
    play3.width = 160

    play:addEventListener("tap", wer)
    play2:addEventListener("tap", wer2)
    play3:addEventListener("tap", wer3)
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