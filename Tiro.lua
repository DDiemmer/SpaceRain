
local physics = require "physics"
physics.start();  physics.setGravity(0, 0) ; --physics.setDrawMode("debug")

local Tiro =  {}
local player 
local imgTiro 
local imgCopy
local vel 
local timeLimitador
local somTiro 
local somTiro2
local somTiroE
local somTiroECol
local tipoTiro

function Tiro:New()
 player = require "Player"
 imgTiro = {}
 vel = 25
 timeLimitador = system.getTimer()-- os.clock()
 somTiro = audio.loadSound("Sons/blaster.wav")
 somTiro2 = audio.loadSound("Sons/blaster2.mp3")
 somTiroE = audio.loadSound("Sons/blaster3.wav")
 somTiroECol = audio.loadSound("Sons/blasterCol.wav")
 
    
end
function Tiro:News(_player,tempoTiro,_tipoTiro)
    
   tipoTiro = _tipoTiro
   player = _player
   if player:Disparou() == true then
   if player:Especial()== false then 
   if(tipoTiro == 1) then
   if system.getTimer() - timeLimitador > (tempoTiro * 1000) then
   imgCopy  = display.newImageRect("imagens/Tiro/tiro.png",5,28)
   imgCopy.x =player:GetX()
   imgCopy.y = player:GetY() - 10
   imgCopy:toBack()
   imgCopy.name = "Tiro"
   imgCopy.tipo = "1"
   imgCopy.vel = 25
   imgCopy.colidiu = false
   imgCopy.espC = false
   physics.addBody(imgCopy,"static")
   if soundOn == true then
   audio.play(somTiro)
   end
   table.insert(imgTiro,imgCopy)
   imgCopy = nil
   timeLimitador = system.getTimer()
   end
   elseif (tipoTiro == 2) then
   ---Tiro 2 =  atravesa tudo    
   if system.getTimer() - timeLimitador > ((tempoTiro + 0.2) * 1000) then
   imgCopy  = display.newImageRect("imagens/Tiro/tiro2.png",10,56)
   imgCopy.x =player:GetX()
   imgCopy.y = player:GetY() - 10
   imgCopy:toBack()
   imgCopy.name = "Tiro"
   imgCopy.tipo = "2"
   imgCopy.vel = 21
   imgCopy.espC = false
   imgCopy.colidiu = false
   physics.addBody(imgCopy,"static")
   if soundOn == true then
   audio.play(somTiro2)
   end
   table.insert(imgTiro,imgCopy)
   imgCopy = nil
   timeLimitador = system.getTimer()
   end 
  elseif (tipoTiro == 4) then
   ---Tiro 2 =  atravesa tudo    
   if system.getTimer() - timeLimitador > ((tempoTiro) * 1000) then
    local nY = player:GetY()+ 35
   imgCopy  = display.newImageRect("imagens/Tiro/tiro3.png",5,28)
   imgCopy.x =player:GetX()-30
   imgCopy.y = nY
   imgCopy:toBack()
   imgCopy.name = "Tiro"
   imgCopy.tipo = "4"
   imgCopy.vel = 25
   imgCopy.aux = #imgTiro + 2
   imgCopy.espC = false
   imgCopy.colidiu = false
   physics.addBody(imgCopy,"static")  
   table.insert(imgTiro,imgCopy)
   imgCopy = nil
   imgCopy  = display.newImageRect("imagens/Tiro/tiro3.png",5,28)
   imgCopy.x =player:GetX()+30
   imgCopy.y = nY
   imgCopy:toBack()
   imgCopy.name = "Tiro"
   imgCopy.tipo = "41"
   imgCopy.vel = 25
   imgCopy.aux = #imgTiro + 2
   imgCopy.espC = false
   imgCopy.colidiu = false
   physics.addBody(imgCopy,"static")  
   table.insert(imgTiro,imgCopy)
    imgCopy = nil
    
   
   if soundOn == true then
   audio.play(somTiro)
   end
    if soundOn == true then
   audio.play(somTiro)
   end
  
   timeLimitador = system.getTimer()
   end 
   end 
   -------Se for tiro especial 
   else
   imgCopy  = display.newImageRect("imagens/Tiro/espTiro.png",30,30)
   imgCopy.x =player:GetX()
   imgCopy.y = player:GetY() - 10
   imgCopy:toBack()
   imgCopy.name = "Tiro"
   imgCopy.tipo = "E"
   imgCopy.espC = false
   imgCopy.vel = 5
   imgCopy.colidiu = false
   --physics.setGravity(0, -2) ; 
   physics.addBody(imgCopy, "dynamic",{radius = 40, isSensor = true,bounce=0.0,friction=0.0})
   if soundOn == true then
   audio.play(somTiroE)
   end
   table.insert(imgTiro,imgCopy)
   imgCopy = nil
   timeLimitador = system.getTimer() + 1
   end
     
   end   
   
   
end


local function OnEspecialCollission(x,y)
    
local sheetDataC = { width=350, height=43, numFrames = 14, sheetContentWidth = 350 , sheetContentHeight=602 }
     	
local sequenceDataC = {
{ name = "EspColidindo", --name of animation sequence
start = 1, --starting frame index
count = 14, --total number of frames to animate consecutively before stopping or looping
--frames={ 1,2,3,4,5,6,7,8 },
time = 1500, --optional, in milliseconds; if not supplied, the sprite is frame-based
loopCount = 1, --optional. 0 (default) repeats forever; a positive integer specifies the number of loops
loopDirection = "forward" --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
} --if defining more sequences, place a comma here and proceed to the next sequence sub-table

}

local mySheetC = graphics.newImageSheet( "imagens/Tiro/espTiroCol.png", sheetDataC )
 --local ast = display.newSprite(imageSheet, sequenceData)
local imgCopy = display.newSprite( mySheetC, sequenceDataC )
imgCopy.x = x
imgCopy.y = y
imgCopy:scale(3,1)
imgCopy.name = "Tiro"
imgCopy.tipo = "EspC"
imgCopy.vel = 0
imgCopy.colidiu = false
imgCopy.espC = false
physics.addBody(imgCopy,"static")
--imgCopy:toBack()
imgCopy:play()
table.insert(imgTiro,imgCopy)
imgCopy = nil

 if soundOn == true then
   audio.play(somTiroECol)
   end

end
-- movimento tiro
function Tiro:moveTiro (event)
 
   
 
 
    for i = 0 ,#imgTiro do    
        
        if imgTiro[i] ~= nil then
       if( imgTiro[i].tipo ~= "EspC") then
        
        if imgTiro[i].y >= -30 and (imgTiro[i].colidiu == false and imgTiro[i].espC == false)then    
        imgTiro[i].y = imgTiro[i].y - imgTiro[i].vel
        
       
        if(imgTiro[i].tipo == "41")then
               local j = (i - 1)
             if(imgTiro[j] ~= nil) then
               
            if( imgTiro[j].tipo == "4") then
              imgTiro[j].y = imgTiro[i].y  
              --imgTiro[i].tipo = "40"
            end
            end
        end
        
        if(imgTiro[i].tipo == "E" and imgTiro[i].vel >0 and(imgTiro[i].colidiu == false or imgTiro[i].espC == false))then
             
             imgTiro[i]:rotate(30)
             imgTiro[i].vel = imgTiro[i].vel + 1
            
        end
        
        else 
          if((imgTiro[i].colidiu == true or imgTiro[i].espC == true) and(imgTiro[i].tipo == "E")) then
               OnEspecialCollission(imgTiro[i].x,imgTiro[i].y) 
               --imgTiro[i].espC = false
               --imgTiro[i].colidiu = true
          end
        --imgTiro[i].isVisible = false
         if(imgTiro[i].colidiu == true or(imgTiro[i].y <= 0 and imgTiro[i].y <= -30))then 
         physics.removeBody(imgTiro[i])
         display.remove(imgTiro[i])
         table.remove(imgTiro,i)
         else
             imgTiro[i].espC = false
            -- imgTiro[i].colidiu = false
         end
            
        end
        
        end

        
        end
    end
    
    for j = 0 ,#imgTiro do
  if imgTiro[j] ~= nil then
  if(imgTiro[j].tipo == "EspC")then    
  if imgTiro[j].isPlaying == false then
   display.remove(imgTiro[j])
   table.remove(imgTiro,j)   
    end
  
  end
  end
  end

end

function Tiro:ClearAll()
 if player ~= nil then   
-- player:removeSelf()
 player = nil
 end
 
 for j = 0, #imgTiro do
 
 if imgTiro[j] ~= nil then
            physics.removeBody(imgTiro[j])
            display.remove(imgTiro[j])
            imgTiro[j]:removeSelf()
            imgTiro[j] = nil
 end
 end
 
 if imgCopy then
     physics.removeBody(imgCopy)
     display:remove(imgCopy)
     imgCopy:removeSelf()
     imgCopy = nil
 end
  
 vel = nil
 timeLimitador = nil
 
 if somTiro then
  -- somTiro:removeSelf()
     somTiro = nil
 end
 if somTiro2 then
  -- somTiro:removeSelf()
     somTiro2 = nil
 end
  if somTiroE then
  -- somTiro:removeSelf()
     somTiroE = nil
 end
 
 
  if somTiroECol then
  -- somTiro:removeSelf()
     somTiroECol = nil
 end
 
  
end

return Tiro 
