
local physics = require "physics"
physics.start(); -- physics.setGravity(0,0) ; --physics.setDrawMode("debug")

local DropItens =  {}
--local player 
local imgItens1
local imgItens2
local imgCopy
local vel 
local somDrag 
local tempoLimit
local tempoLast
local item


function DropItens:New()
 --player = require "Player"
 imgItens1 = {}
 imgItens2 = {}
 somDrag  = audio.loadSound("Sons/drag.wav")
 imgCopy = nil
 tempoLimit = system.getTimer()
 tempoLast = 28
    
end

local function AddNew(_tipo)
 --player = require "Player"

 
 local iX = 0
 local iY = math.random(0, 250)
 iY = iY * -1
    ----tipo 1 =  Shield 
   if(_tipo == 1) then   
   imgCopy  = display.newImageRect("imagens/Itens/Dropshield1.png",40,40)
   imgCopy.x = math.random(10,display.contentWidth - imgCopy.width)  
   iX = imgCopy.x
   imgCopy.y = iY --player:GetY() - 10
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Shield"
  -- imgCopy.alt = imgCopy.size.y
   imgCopy.colidiu = false
      physics.addBody(imgCopy,"dynamic",{isSensor = true })

   table.insert(imgItens1,imgCopy)
   imgCopy = nil
   
   imgCopy  = display.newImageRect("imagens/Itens/Dropshield2.png",40,40)
   imgCopy.x = iX 
   imgCopy.y = iY
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Shield"
   imgCopy.colidiu = false
   --   physics.addBody(imgCopy, "static")
   table.insert(imgItens2,imgCopy)
   imgCopy = nil
   
   --tipo 2 Tiro 2 
   elseif(_tipo == 2) then
       
   imgCopy  = display.newImageRect("imagens/Itens/Droptiro11.png",40,40)
   imgCopy.x = math.random(10,display.contentWidth - imgCopy.width)  
   iX = imgCopy.x
   imgCopy.y = iY --player:GetY() - 10
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Tiro"
  -- imgCopy.alt = imgCopy.size.y
   imgCopy.colidiu = false
      physics.addBody(imgCopy,"dynamic",{isSensor = true })

   table.insert(imgItens1,imgCopy)
   imgCopy = nil
   
   imgCopy  = display.newImageRect("imagens/Itens/Droptiro12.png",40,40)
   imgCopy.x = iX 
   imgCopy.y = iY
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Tiro"
   imgCopy.colidiu = false
   --   physics.addBody(imgCopy, "static")
   table.insert(imgItens2,imgCopy)
   imgCopy = nil
   
   
    elseif(_tipo == 3) then
       
   imgCopy  = display.newImageRect("imagens/Itens/Droptiro21.png",50,50)
   imgCopy.x = math.random(10,display.contentWidth - imgCopy.width)  
   iX = imgCopy.x
   imgCopy.y = iY --player:GetY() - 10
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Especial"
  -- imgCopy.alt = imgCopy.size.y
   imgCopy.colidiu = false
      physics.addBody(imgCopy,"dynamic",{isSensor = true })

   table.insert(imgItens1,imgCopy)
   imgCopy = nil
   
   imgCopy  = display.newImageRect("imagens/Itens/Droptiro22.png",50,50)
   imgCopy.x = iX 
   imgCopy.y = iY
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Especial"
   imgCopy.colidiu = false
   --   physics.addBody(imgCopy, "static")
   table.insert(imgItens2,imgCopy)
   imgCopy = nil
    elseif(_tipo == 4) then
       
   imgCopy  = display.newImageRect("imagens/Itens/Droptiro31.png",50,50)
   imgCopy.x = math.random(10,display.contentWidth - imgCopy.width)  
   iX = imgCopy.x
   imgCopy.y = iY --player:GetY() - 10
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Tiro2"
  -- imgCopy.alt = imgCopy.size.y
   imgCopy.colidiu = false
      physics.addBody(imgCopy,"dynamic",{isSensor = true })

   table.insert(imgItens1,imgCopy)
   imgCopy = nil
   
   imgCopy  = display.newImageRect("imagens/Itens/Droptiro32.png",50,50)
   imgCopy.x = iX 
   imgCopy.y = iY
   imgCopy:toFront()
   imgCopy.name = "Item"
   imgCopy.tipo = "Tiro2"
   imgCopy.colidiu = false
   --   physics.addBody(imgCopy, "static")
   table.insert(imgItens2,imgCopy)
   imgCopy = nil
   
   end 
   
   iY = nil
   iX = nil
    
end


-- movimento tiro
function DropItens:AnimaItens()
 

 
 if (imgItens1 ~= nil)then
-- if(imgItens[1].tipo == "Shield")then
 
    for i = 0, #imgItens1, 1 do
    
    if(imgItens1[i] ~= nil)then
    
    if(imgItens2[i].tipo == "Especial")then
    imgItens1[i]:rotate(-4)
    imgItens2[i]:rotate(10)
    else
    imgItens1[i]:rotate(-2)
    imgItens2[i]:rotate(4)
    end
    imgItens2[i].x = imgItens1[i].x
    imgItens2[i].y = imgItens1[i].y
         
      if(imgItens1[i].colidiu == true or imgItens1[i].y > (display.contentHeight + (imgItens1[i].height * 1.5) ))then
        
        if (soundOn == true and imgItens1[i].colidiu == true ) then
        audio.play(somDrag)
        end
        
        
        display.remove(imgItens2[i])
        table.remove(imgItens2,i)
        --imgItens2[i] = nil
        physics.removeBody(imgItens1[i])
        display.remove(imgItens1[i])
        table.remove(imgItens1,i)
       -- imgItens1[i] = nil
        --imgItens = nil
     
   end
   
    end
 end
 end
 
  ---Se deve Inserir Item na tela  
if system.getTimer() - tempoLimit > (tempoLast * 1000) then

    item = math.random(0, 100)
    if(item > 15 and item < 85)then
        item = 2 * math.random(1,2)
    elseif (item <=15) then
        item = 1
    else
        item = 3
    end
    
    if(math.random(20)==20) then
     AddNew(math.random(1,4))   
    end
     AddNew(item)
     
    tempoLast = tempoLast - 0.2



if(tempoLast < 10) then
    tempoLast = 10
end
tempoLimit = system.getTimer()
end
      
        

end

function DropItens:ClearAll()
-- if player ~= nil then   
-- player:removeSelf()
-- player = nil
-- end
 
 if(imgItens1)then
 for j = #imgItens1,0,-1 do
 
 if imgItens1[j] ~= nil then
            physics.removeBody(imgItens1[j])
            display.remove(imgItens1[j])
            imgItens1[j]:removeSelf()
            imgItens1[j] = nil
 end
 end
 end
  
  if(imgItens2)then
 for k = #imgItens2,0,-1 do
 
 if imgItens2[k] ~= nil then
            physics.removeBody(imgItens2[k])
            display.remove(imgItens2[k])
            imgItens2[k]:removeSelf()
            imgItens2[k] = nil
 end
 end
 end
 imgItens1 =nil
 imgItens2 =nil
 if imgCopy then
     physics.removeBody(imgCopy)
     display:remove(imgCopy)
     imgCopy:removeSelf()
     imgCopy = nil
 end
 
 vel = nil
 
 if somDrag then
  -- somTiro:removeSelf()
    somDrag = nil
 end
  
  tempoLimit = nil
  tempoLast = nil
  item = nil
  
end

return DropItens 
