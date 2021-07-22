-----------------------------------------------------------------------------------------
--
-- Menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require( "widget" )
--------------------------------------------
musicaOn = false
soundOn = false
pontos = 0 
maxPontos = 0
dificuldade = 0 
acelerometro = true
-- forward declarations and other locals
 local playBtn = nil    

 local background = nil
 local somMusicsBtn -- = display.newImageRect("imagens/Menu/notasomAtivv.png",50,50)
 local somBtn = display.newRect(0, 0, 50, 50)
 local somSoundsBtn -- = display.newImageRect("imagens/Menu/caixasomativo.png",50,50)
 local soundBtn = display.newRect(0, 0, 50, 50)

local musica = audio.loadSound("Sons/forGame.mp3")
local sound = audio.loadSound("Sons/blaster2.mp3")

local opcoesBtn  = nil
local moveOp = false
local moveMenuBaixo = true
local lastY = 0
local maxScore = nil
local maxScoreTxt = nil


local function ScoreLoad()
   local path = system.pathForFile("scoreFile.txt", system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
      -- read all contents of file into a string
      local contents = file:read( "*a" )
      local score = tonumber(contents);
      io.close( file )
      return score
   else
      return 0
   end
   return nil
end


-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	storyboard.gotoScene( "Jogo", "fade", 700 )
        --imgsomMusics[0].isVisible = false
	
	return true	-- indicates successful touch
end

local function onOpcoesBtnRelease(event)

   ----quando tocar
    if(event.phase == "began" and (opcoesBtn.y == 0 or opcoesBtn == display.contentHeight) )then
    moveOp = true  
    ---quando mover
    elseif(opcoesBtn~=nil and event.phase == "moved")then
        if(event.y >=0 and event.y < display.contentHeight )then
        opcoesBtn.y = event.y
       
    ---comecou por cima e esta movendo para baixo 
       if(lastY < event.y)then
       ----esta movendo para baixo 
       moveMenuBaixo = true
       ----indo para cima 
       elseif(lastY > event.y)then
           moveMenuBaixo = false
       end
       end
    
    
    elseif(event.phase == "ended" or event.phase == "canceled")then
    moveOp = false

    else
        moveOp=false
    end
    
    lastY = event.y
end
local AbreOpcoesEventsFrames = function (event) 
          
          opcoesBtn:rotate(2)
  
  if(moveOp == false)then
        ---se o Y da imagem for maior que 0 e menor 72(15% do tamanho da tela)   vai para baixo 
        if(opcoesBtn.y > 0 and opcoesBtn.y < display.contentHeight * 0.20  )then
        
                 if(opcoesBtn.y - 10 <= 0)then 
                    opcoesBtn.y = 0
                else
                    opcoesBtn.y = opcoesBtn.y - 10
                end
                ---se y da imagem maior igual que (408 (85% da tela) mas menor que o maximo da tela 
       elseif(opcoesBtn.y  >= (display.contentHeight* 0.85) and opcoesBtn.y < display.contentHeight) then
                if(opcoesBtn.y + 10 >= display.contentHeight) then
                    opcoesBtn.y = display.contentHeight
                else
                    opcoesBtn.y = opcoesBtn.y + 10
                end
         elseif (opcoesBtn.y >= display.contentHeight * 0.20 and opcoesBtn.y  <= (display.contentHeight* 0.85))then
                if(moveMenuBaixo == false)then
                if(opcoesBtn.y - 10 <= 0)then 
                    opcoesBtn.y = 0
                else
                    opcoesBtn.y = opcoesBtn.y - 10
                end
                else
                   if(opcoesBtn.y + 10 >= display.contentHeight) then
                    opcoesBtn.y = display.contentHeight
                else
                    opcoesBtn.y = opcoesBtn.y + 10
                end
                end
        end
        end
        background.x, background.y = 0, opcoesBtn.y -  display.contentHeight
         somMusicsBtn.y = 250 + opcoesBtn.y 
         somSoundsBtn.y = 309+ opcoesBtn.y 
        somBtn.y = 250 + opcoesBtn.y 
        soundBtn.y =309+ opcoesBtn.y 
        maxScore.y = opcoesBtn.y - (display.contentHeight - 100)
         maxScoreTxt.y = opcoesBtn.y + 60 - (display.contentHeight - 100)
        playBtn.y = (display.contentHeight - 95) + opcoesBtn.y
end

local onTapBmusic =  function(event)
   
  
  if event.phase == "began" and system.getTimer() - somMusicsBtn.tempo > 200 then
    
    if somMusicsBtn.ativo == true then
        display.remove(somMusicsBtn)
        somMusicsBtn = display.newImageRect("imagens/Menu/notasomNativo.png", 50, 50)
       somMusicsBtn.x = 60
       somMusicsBtn.y = 250
        somMusicsBtn.ativo = false
        somMusicsBtn.tempo = system.getTimer()
        audio.pause(musica)
    else
        display.remove(somMusicsBtn)
        somMusicsBtn = display.newImageRect("imagens/Menu/notasomAtivv.png", 50, 50)
        somMusicsBtn.x = 60
        somMusicsBtn.y = 250
        somMusicsBtn.ativo = true
        somMusicsBtn.tempo = system.getTimer()
        audio.play(musica)
    end
    
 
  end
  
end
local onTapBsound =  function(event)
    
  if event.phase == "began" and system.getTimer() - somSoundsBtn.tempo > 200 then
    
    if somSoundsBtn.ativo == true then
        -- audio.play(sound)
        display.remove(somSoundsBtn)
        somSoundsBtn = display.newImageRect("imagens/Menu/caixasomNativo.png", 50, 50)
       somSoundsBtn.x = 60
       somSoundsBtn.y = 309
        somSoundsBtn.ativo = false
        somSoundsBtn.tempo = system.getTimer()
        
    else
        display.remove(somSoundsBtn)
        somSoundsBtn = display.newImageRect("imagens/Menu/caixasomativo.png", 50, 50)
        somSoundsBtn.x = 60
        somSoundsBtn.y = 310
        somSoundsBtn.ativo = true
        somSoundsBtn.tempo = system.getTimer()
        audio.play(sound)
    end
    
 
  end
  
end

  
  

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------
local createOpcoesScene = function()
 
       -----botao de opcoes
        opcoesBtn = widget.newButton{
		--label="Play Now",
		--labelColor = { default={255}, over={128} },
		defaultFile="imagens/Menu/configMenu.png",
		overFile="imagens/Menu/lua.png",
                width=70, height=65,
		onEvent = onOpcoesBtnRelease	-- event listener function
	}
	---configBtn:setReferencePoint( display.CenterReferencePoint )
	opcoesBtn.x = display.contentCenterX
	opcoesBtn.y = 0
        
        maxScore = display.newImageRect("imagens/Menu/maxScore.png",250,60)
        maxScore.x = display.contentCenterX
        maxScore.y = opcoesBtn.y - (display.contentHeight - 100)
        
        maxScoreTxt = display.newText(0, display.contentCenterX ,maxScore.y + 60, "Arial Black",48)
        --scoreTxt:setTextColor(90/255, 0, 0.6)
        maxScoreTxt:setFillColor(0.9, 0.9, 1)
        maxScoreTxt.text = maxPontos
        
        
        
        
end
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
         
        maxPontos = ScoreLoad()
        --instancia Menu opcoes
        -- display a background image
	-- display a background image
        background = display.newImageRect("imagens/Menu/backgroundN.png", display.contentWidth, display.contentHeight*2)
--	background:setReferencePoint( display.TopLeftReferencePoint )
        background.anchorX = 0.0;
        background.anchorY = 0.0;
	background.x, background.y = 0, 0 - display.contentHeight
	-- create/position logo/title image on upper-half of the screen

	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		--label="Play Now",
		--labelColor = { default={255}, over={128} },
		width=178, 
		height=80,
		defaultFile="imagens/Menu/img_bMJogar1.png",
		overFile="imagens/Menu/img_bMJogarOver.png",
	    --            width=178, height=80,
		onRelease = onPlayBtnRelease	-- event listener function
	}
--	playBtn:setReferencePoint( display.CenterReferencePoint )
     --  playBtn.anchorX = 0.0
      -- playBtn.anchorY = 0.0
	playBtn.x = display.contentWidth* 0.5
	playBtn.y = display.contentHeight - 95
        
        

         createOpcoesScene()
   
        -- all display objects must be inserted into group

        group:insert( background )
	group:insert( playBtn )
        group:insert (somBtn)
        group:insert (soundBtn)
                ---Grupo Menu opcoes
        group:insert(opcoesBtn) 
        group:insert(maxScore)
        group:insert(maxScoreTxt)
        

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view


if musicaOn == true then
audio.play(musica)
display.remove(somMusicsBtn)
somMusicsBtn = display.newImageRect("imagens/Menu/notasomAtivv.png", 50, 50)
somMusicsBtn.ativo = true
else
display.remove(somMusicsBtn)
somMusicsBtn = display.newImageRect("imagens/Menu/notasomNativo.png", 50, 50)
somMusicsBtn.ativo = false
end
if soundOn == true then
    --audio.play(sound) 
    display.remove(somSoundsBtn)
    somSoundsBtn = display.newImageRect("imagens/Menu/caixasomativo.png", 50, 50)
    somSoundsBtn.ativo = true
     else
     display.remove(somSoundsBtn)
    somSoundsBtn = display.newImageRect("imagens/Menu/caixasomNativo.png", 50, 50)
    somSoundsBtn.ativo = false
        end
        -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
somMusicsBtn.tempo = system.getTimer()
somSoundsBtn.tempo = system.getTimer()
         somMusicsBtn.x = 60
        somMusicsBtn.y = 250
        somBtn.x = somMusicsBtn.x
        somBtn.y = somMusicsBtn.y
        somBtn:setFillColor(0,0, 0,0.01)
        somMusicsBtn.tempo = system.getTimer()
        
      if musicaOn == false then
         somMusicsBtn.ativo = musicaOn  
        else
        somMusicsBtn.ativo = true
        end
        
        if musicaOn == true then
        audio.play(musica)
        end
        
        soundBtn.x = 60
        soundBtn.y = 310
        soundBtn:setFillColor(0.1,0.1, 0.1,0.01)
        somSoundsBtn.x = 60
        somSoundsBtn.y = 310    
        somSoundsBtn.tempo = system.getTimer()
        
        if soundOn == false then
        somSoundsBtn.ativo = soundOn
       else
        somSoundsBtn.ativo = true
        end
        
        
        maxScoreTxt.text = maxPontos 
        
        

somBtn:addEventListener("touch", onTapBmusic)
soundBtn:addEventListener("touch", onTapBsound)
Runtime:addEventListener("enterFrame",AbreOpcoesEventsFrames)

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    
        somBtn:removeEventListener("touch", onTapBmusic)
        soundBtn:removeEventListener("touch",onTapBsound)
        Runtime:removeEventListener("enterFrame",AbreOpcoesEventsFrames)
        
       musicaOn = somMusicsBtn.ativo
       soundOn = somSoundsBtn.ativo
       display.remove(somSoundsBtn)
       display.remove(somMusicsBtn)
        local group = self.view
      --  group:removeSelf()
 
               
            audio.pause(sound)
            audio.pause(musica)
            
        --imgsomMusics.remove(0)	
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	 group:removeSelf()
         somBtn:removeEventListener("touch", onTapBmusic)
        soundBtn:removeEventListener("touch",onTapBsound)
        if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
        if somBtn ~= nil then
                --display.remove(somBtn)
		--somBtn:removeSelf()	-- widgets must be manually removed
		somBtn = nil
	end
        if soundBtn then
                --display.remove(soundBtn)
               -- soundBtn:removeSelf()	-- widgets must be manually removed
		soundBtn = nil
	end
        if somMusicsBtn then
                display.remove(somMusicsBtn)
		--somMusicsBtn:removeSelf()	-- widgets must be manually removed
		somMusicsBtn = nil
	end
        if somSoundsBtn then
                display.remove(somSoundsBtn)
		--somSoundsBtn:removeSelf()	-- widgets must be manually removed
		somSoundsBtn = nil
	end
         if sound then
                sound:removeSelf()	-- widgets must be manually removed
		sound = nil
	end
            if musica then
                musica:removeSelf()	-- widgets must be manually removed
		musica = nil
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



-- 
-----------------------------------------------------------------------------------------

return scene


