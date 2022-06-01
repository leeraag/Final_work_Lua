local composer = require( "composer" )
local scene = composer.newScene()
local widget = require ("widget")

local function Start()
  composer.gotoScene("scenes.game")
end

local function Skin()
  composer.gotoScene("scenes.skins")
end

function scene:create( event )
local sceneGroup = self.view
_W = display.contentWidth
_H = display.contentHeight

local background = display.newImageRect(sceneGroup,"images/background-menu.png", 370, 600)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- кнопка "Играть"
local function handleButtonEvent1( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene("scenes.lvl2", "slideRight")
    end
end

-- кнопка "уровни"
local function handleButtonEvent2( event )
      		    if ( "ended" == event.phase ) then
      		        composer.gotoScene("scenes.skins", "slideRight")
      		    end
            end

        local btn_startPlaying = widget.newButton {
      		    width = 180,
      		    height = 70,
      		    defaultFile = "images/button-pink.png",
      		    overFile = "images/button-pink-hover.png",
      		    label = "Играть",
      		    font = "20704.otf",
      		    fontSize = 24,
      		    labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
      		    onEvent = handleButtonEvent1
      		}
      		btn_startPlaying.x = display.contentCenterX
      		btn_startPlaying.y = display.contentCenterY - 80
      		sceneGroup:insert(btn_startPlaying)

          local btn_startPlaying = widget.newButton {
                width = 180,
                height = 70,
                defaultFile = "images/button-pink.png",
                overFile = "images/button-pink-hover.png",
                label = "Уровни",
                font = "20704.otf",
                fontSize = 24,
                labelColor = { default={ 1, 1, 1 }, over={ 1, 1, 1, 0.5 } },
                onEvent = handleButtonEvent2
            }
            btn_startPlaying.x = display.contentCenterX
            btn_startPlaying.y = display.contentCenterY + 20
            sceneGroup:insert(btn_startPlaying)
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
