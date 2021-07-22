-----------------------------------------------------------------------------------------
--
-- Jogo.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


local cena = require "Cenario"
---
local somJogo 
local fase = 1
local fistTime
-- include Corona's "widget" library
--local widget = require "widget"

--------------------------------------------
-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------
local SetNextScene = function (event)
     if cena ~= nil then
     if cena:GetFimdaFase() then
     -- cham menu entrefases e pula fase
         storyboard.gotoScene( "Menu", "fade", 900 )
        -- tela gameover e  chame menu mesma fase 
     return true
     end
     if cena:GetGameOver() then
         
        storyboard.gotoScene( "GameOver", "fade", 900 )
        -- tela gameover e  chame menu mesma fase 
     return true
     end
       end
end



-- 
-- Called when the scene's view does not exist:
function scene:createScene(event)
	local group = self.view
         --if fistTime == true then
         cena:New(fase)   
         --end
         fistTime = true
         if musicaOn == true then
         somJogo = audio.loadStream("Sons/forGame.mp3")
         end 
	-- display a background image
	-- display a background image
	
	-- create/position logo/title image on upper-half of the screen

	--group:insert( background )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
        
        if fistTime == false then 
         cena = require "Cenario"
         cena:New(fase)
         end
        cena:GetEvents()
        fistTime = false
         
         if musicaOn == true then
         somJogo = audio.loadStream("Sons/forGame.mp3")
         end 
	
        if somJogo then
            audio.play(somJogo,{loops = -1})
  	end
        -- dis
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
        cena:ClearAll()
       -- cena:removeSelf()
        cena = nil
        audio.pause()
        --audio.stop(somJogo)
        somJogo = nil
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	cena:removeSelf()
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )


-----------------------------------------------------------------------------------------
 
--cena:GetEvents()
Runtime:addEventListener("enterFrame", SetNextScene)

return scene