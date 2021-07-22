local storyboard = require( "storyboard" )
--storyboard.isDebug =  true
--local scene = storyboard.newScene()
local physics = require "physics"
 


local Inimigos  = {}
local imgAsteroids 
local imgCollision 
local vel 
local numAsteroids 
local score = 0
local somExplosion = audio.loadSound("Sons/stomp.mp3")
local mySheet
local sequenceData
local gN = 0.2
local tempoLimitador
local tempoAst
local nivelDif


local function OnAsteroidCollission(x,y,size)
    
    local sheetDataC = { width=187, height=187, numFrames = 10, sheetContentWidth=374, sheetContentHeight=935 }
     	
local sequenceDataC = {
{ name = "Colidindo", --name of animation sequence
start = 1, --starting frame index
count = 10, --total number of frames to animate consecutively before stopping or looping
--frames={ 1,2,3,4,5,6,7,8 },
time = 1000, --optional, in milliseconds; if not supplied, the sprite is frame-based
loopCount = 1, --optional. 0 (default) repeats forever; a positive integer specifies the number of loops
loopDirection = "forward" --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
} --if defining more sequences, place a comma here and proceed to the next sequence sub-table

}

local mySheetC = graphics.newImageSheet( "imagens/Inimigos/ExpSHEET.png", sheetDataC )
 --local ast = display.newSprite(imageSheet, sequenceData)
local imgCopy = display.newSprite( mySheetC, sequenceDataC )
imgCopy.x = x
imgCopy.y = y
imgCopy:scale(size,size)
--imgCopy:toBack()
imgCopy:play()
table.insert(imgCollision,imgCopy)
imgCopy = nil

end


local function  AddPlus()

for i = numAsteroids,0,-1 do
    local sheetData = { width=64, height=64, numFrames = 30, sheetContentWidth=320, sheetContentHeight=384 }
if(math.random(100) < 50)then
        	
sequenceData = {
{ 
name = "Round", --name of animation sequence
start = 1, --starting frame index
count = 30, --total number of frames to animate consecutively before stopping or looping
--frames={ 1,2,3,4,5,6,7,8 },
time = math.random(1900,2200), --optional, in milliseconds; if not supplied, the sprite is frame-based
loopCount = 0, --optional. 0 (default) repeats forever; a positive integer specifies the number of loops

loopDirection = "forward" --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
} --if defining more sequences, place a comma here and proceed to the next sequence sub-table
}
else

     	
sequenceData = {
{ 
name = "Round", --name of animation sequence
start = 1, --starting frame index
count = 30, --total number of frames to animate consecutively before stopping or looping
--frames={ 1,2,3,4,5,6,7,8 },
time = math.random(1700,2500), --optional, in milliseconds; if not supplied, the sprite is frame-based
loopCount = 0, --optional. 0 (default) repeats forever; a positive integer specifies the number of loops

loopDirection = "backward" --optional, either "forward" (default) or "bounce" which will play forward then backwards through the sequence of frames
} --if defining more sequences, place a comma here and proceed to the next sequence sub-table
}

end

 mySheet = graphics.newImageSheet( "imagens/Inimigos/meteorSHEET.png", sheetData )
 --local ast = display.newSprite(imageSheet, sequenceData)
local imgCopy = display.newSprite( mySheet, sequenceData )
imgCopy.x = math.random(display.contentWidth)
imgCopy.y = -150 - ((i * 20)+(score/500))  -- math.random(1400) -- (score * 1.5)
imgCopy.rotation = math.random(360)
imgCopy.size = 0.5 + (math.random(150)/100)
imgCopy:scale(imgCopy.size,imgCopy.size)   
imgCopy:rotate(math.random(360))
--imgCopy:
imgCopy.name = "Asteroids"
imgCopy.tipo = "Inimigo"
imgCopy:toBack()
imgCopy:play()
imgCopy.colidiu = false
imgCopy.remover = false
--physics.addBody(imgCopy, "dynamic",{bounce=0.3, radius = 22 * imgCopy.size, friction=1.5, density= 1})
physics.addBody(imgCopy, "dynamic",{bounce=0.3, radius = 22* imgCopy.size, friction=0.5})


if(score >= 50 and score <= 16000 )then
    gN = 0.2 + ((score + nivelDif)/( 500 - (((score + nivelDif)/1000) * 20)))
    tempoAst = 3 - (((score + nivelDif)/1000)* 0.5)
if(tempoAst < 1 )then
    tempoAst = 1
end
    
end

physics.setGravity(0,gN);

 ---nota, no bounce se repelem mais 
table.insert(imgAsteroids,imgCopy)

    imgCopy = nil
    
end
    numAsteroids = 0
    
    
end

function Inimigos:AddNew()
  -- physics.setDrawMode("hybrid")
  physics.start();
  nivelDif = dificuldade * 1000
  score = 0
  gN = 0.2 + ((score + nivelDif)/( 500 - (((score + nivelDif)/1000) * 20)))
  physics.setGravity(0,gN);
  imgAsteroids = {}
  imgCollision = {}
  vel = 3
  numAsteroids = 7
  somExplosion = audio.loadSound("Sons/stomp.mp3")
  tempoLimitador = system.getTimer()
  tempoAst = 3

 -- AddPlus()     
 end
 
 

function Inimigos:MoveAsteroids ()
    --tirar isso e por sprite event 
  for j = 0 ,#imgCollision do
  if imgCollision[j] ~= nil then
  if imgCollision[j].isPlaying == false then
   display.remove(imgCollision[j])
   table.remove(imgCollision,j)        
  end
  end
  
  end
  
  for i = 0,#imgAsteroids do
        if imgAsteroids[i] ~= nil then
               
               if imgAsteroids[i].colidiu == true then
                  OnAsteroidCollission(imgAsteroids[i].x,imgAsteroids[i].y + 40,imgAsteroids[i].size)
                  score = math.ceil(score + 3 / imgAsteroids[i].size)
                  imgAsteroids[i].colidiu= false                  
                  imgAsteroids[i].remover = true
                  
                  if soundOn == true then
                   audio.play(somExplosion)
                   end
                   
                   end
               -- local omm = display.newText(imgAsteroids[i].sprite.name,10, 20, "arial" ,20)
               -- omm:setTextColor(255,255,255,255)
           if imgAsteroids[i].y < display.contentHeight +50 + math.random(400) and imgAsteroids[i].remover == false then
           imgAsteroids[i].y = imgAsteroids[i].y + vel
           else
                       
             --  imgAsteroids[i] = nil
             
             physics.removeBody(imgAsteroids[i])
             display.remove(imgAsteroids[i])
             table.remove(imgAsteroids,i)
            -- numAsteroids = numAsteroids + 1
            
             end
            
         
        end
           
    end
 --if numAsteroids > math.random(15) and #imgAsteroids < math.random(10) then
 if system.getTimer() - tempoLimitador > (tempoAst * 1000) then
   
   if(numAsteroids < 15)then
       numAsteroids = 5 + math.ceil((score + nivelDif)/500)
   end
   AddPlus()
   tempoLimitador = system.getTimer()
   end
--end

--storyboard.printMemUsage()
  --end
end


function Inimigos:GetScore()
    return score
end

function Inimigos:ClearAll()
   
    for k = #imgAsteroids ,0,-1 do
       if imgAsteroids[k] ~= nil then
             physics.removeBody(imgAsteroids[k])
             display.remove(imgAsteroids[k])
             table.remove(imgAsteroids,k)
             imgAsteroids[k] =nil
      end
    end
    
    imgAsteroids = nil
    
    for j = #imgCollision,0, -1 do
        if imgCollision[j] ~= nil then
             --physics.removeBody(imgCollision[j])
             display.remove(imgCollision[j])
             table.remove(imgCollision,j)
             imgCollision[j] =nil
        end
    end
    tempoLimitador = nil
    tempoAst = nil
    imgCollision = nil
    physics.stop()
    sequenceData = nil
    mySheet = nil
    vel = nil
    numAsteroids = nil
    score = nil
    somExplosion = nil
    
end

return Inimigos
