

-----------------------------------------------------------------------------------------
--
--Game Over.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
---
-- include Corona's "widget" library
--local widget = require "widget"
local somGameOver
local bRefazer = require "SimpleButton"
local refazerBtn
local configBtn
local score 
local scoreTxt
    

--------------------------------------------
-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------
-- 
local function onrefazerBtnRelease ()
    
    storyboard.gotoScene( "Jogo", "fade", 700 )
end
local function onConfigBtnRelease()
    
    storyboard.gotoScene( "Menu", "fade", 700 )
end
local function ScoreSave(_score)
   local path = system.pathForFile( "scoreFile.txt", system.DocumentsDirectory )
   local file = io.open(path, "w")
   if ( file ) then
      -- _score = tostring( _score )
      file:write( _score )
      io.close( file )
      return true
   else
      --print( "Error: could not read ","scoreFile.txt", "." )
      return false
   end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
 
 
         if musicaOn == true then
        somGameOver = audio.loadStream("Sons/Aeris.mp3")
         end 
	-- display a background image
	-- display a background image
        
	local background = display.newImageRect("imagens/GameOverBG.png", display.contentWidth, display.contentHeight)
	--background:setReferencePoint( display.TopLeftReferencePoint )
       background.anchorX = 0.0;
       background.anchorY = 0.0;
	background.x, background.y = 0, 0
        
        	refazerBtn = widget.newButton{
		--label="Play Now",
		--labelColor = { default={255}, over={128} },
		defaultFile="imagens/refazer.png",
		overFile="imagens/refazerOver.png",
                width=70, height=70,
		onRelease = onrefazerBtnRelease	-- event listener function
	}
	--refazerBtn:setReferencePoint( display.CenterReferencePoint )
	refazerBtn.x = display.contentWidth*0.35
	refazerBtn.y = display.contentHeight - 125
	-- create/position logo/title image on upper-half of the screen
        
        configBtn = widget.newButton{
		--label="Play Now",
		--labelColor = { default={255}, over={128} },
		defaultFile="imagens/configMenu.png",
		overFile="imagens/configMenuOver.png",
                width=70, height=70,
		onRelease = onConfigBtnRelease	-- event listener function
	}
	---configBtn:setReferencePoint( display.CenterReferencePoint )
	configBtn.x = display.contentWidth*0.65
	configBtn.y = display.contentHeight - 125
	-- create/position logo/title image on upper-half of the screen
        
        score = display.newImageRect("imagens/Menu/score.png",100,40)
        score.x = display.contentCenterX
        score.y = display.contentCenterY  + 18      
        
         scoreTxt = display.newText(0, display.contentCenterX,display.contentCenterY + 48, "Arial Black",28)
         --scoreTxt:setTextColor(90/255, 0, 0.6)
         scoreTxt:setFillColor(0.9, 0.9, 1)
         scoreTxt.text = pontos
         
         
         
	group:insert( background )
        group:insert( refazerBtn )
        group:insert( configBtn )
        group:insert( scoreTxt )
        group:insert( score )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
        
        if(pontos > maxPontos)then
            ScoreSave(pontos)
            maxPontos = pontos 
        end
        local group = self.view
        scoreTxt.text = pontos
        if musicaOn == true then
        somGameOver = audio.loadStream("Sons/Aeris.mp3")
         end 
        if somGameOver ~= nil then
        audio.play(somGameOver)
        end
        --storyboard.removeScene("Jogo")
    	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    
   
	local group = self.view
         audio.pause(somGameOver)
	somGameOver=nil
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	group:removeSelf()
        if refazerBtn then
		refazerBtn:removeSelf()	-- widgets must be manually removed
		refazerBtn = nil
	end
        if configBtn then
		configBtn:removeSelf()	-- widgets must be manually removed
		configBtn = nil
	end
        
        
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
 
return scene