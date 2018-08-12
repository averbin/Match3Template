-----------------------------------------------------------------------------------------
--
-- Match3 template menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local element = require( "element" )
local widget = require( "widget" )
local scene = composer.newScene()

local function handleButtonEvent( event )
  if "ended" == event.phase then
    print("Button is pressed and released")
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    local sceneGroup = self.view
    local background = display.newImage(sceneGroup, "res/Images/beach.jpg")
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:scale(0.7, 0.8)

    local button = widget.newButton(
      {
          label = "New Game",
          onEvent = handleButtonEvent,
          emboss = false,
          shape = "roundedRect",
          width = 100,
          height = 40,
          cornerRadius = 2,
          fillColor = { default = {1, 0, 0, 1}, over = {1, 0.1, 0.7, 0.4}},
          strokeColor = { default = {1, 0.4, 0,1}, over={0.8, 0.8, 1,1}},
          labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
          strokeWidth = 4
      }
    )

    button.x = display.contentCenterX
    button.y = display.contentCenterY
end

-- show()
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
    end
end

-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        timer.cancel( gameLoopTimer )
    end
end


-- destroy()
function scene:destroy( event )
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
