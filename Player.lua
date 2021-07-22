-----------------------------------------------------------------------------------------
--
-- Player.lua
--
-----------------------------------------------------------------------------------------

local physics = require 'physics'

 
local Player = {};
--local imgNave = display.newImageRect("imagens/player/imgNave.png", display.contentWidth *0.258 ,display.contentWidth *0.294)
local imgNave = {}

imgNave[0] = display.newImageRect("imagens/player/imgNave.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[1] = display.newImageRect("imagens/player/imgNave30g.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[2] = display.newImageRect("imagens/player/imgNave60g.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[3] = display.newImageRect("imagens/player/imgNave30gD.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[4] = display.newImageRect("imagens/player/imgNave60gD.png", display.contentWidth *0.294 ,display.contentWidth *0.294)


local colsrects = {};
local shield; --= display.newImageRect("imagens/player/shield.png",imgNave.width ,imgNave.height)
local l_dispara = false;
local x,y = display.contentCenterX , -55;
local velX = 1;
local velY = 1;
local vel = 5;
local valPi = math.pi/180;
local begin = true ;
local ativa = false;
local vida = 5;
local dbNaveTouch = false 
local especiais
local tempoTapNave
local tempoUltTapNave
local centerX = display.contentWidth * 0.5
local centerY = display.contentHeight * 0.5
local accYinicial 
local touchs = {}

if(acelerometro == true)then
    system.setIdleTimer(false)
    system.setAccelerometerInterval(10)
end
system.activate( "multitouch" )

--local txt = display.newText("", display.contentCenterX ,200, "Arial black",22)
--txt:setFillColor(0.35, 0, 1)
-- local txt1 = display.newText("", display.contentCenterX ,270, "Arial black",22)
--- txt1:setFillColor(0.35, 0, 1)
   ---    local txt2 = display.newText("", display.contentCenterX ,300, "Arial black",22)
  -- txt2:setFillColor(0.35, 0, 1)
   --local txt3 = display.newText("", display.contentCenterX ,350, "Arial black",22)
  -- txt3:setFillColor(0.35, 0, 1)
---retorna angulo
 local function GetAngulo(px,py,px2,py2)
  
  local angulo = math.atan2( (py - py2), (px - px2) ) * (180 / math.pi) - 90;
         
    return angulo;
    
end

local function onAccelerate( event )
    
    if(begin)then 
        accYinicial = event.yGravity
        centerY = imgNave[0].y
    else
        
    if(centerX + (centerX * (event.xGravity*8)) > 0 and centerX + (centerX * (event.xGravity*8))< display.contentWidth  )then
          x = centerX + (centerX * (event.xGravity*8))
    end
     
    if(centerY - (centerY * ((event.yGravity - accYinicial)*10))> -20 and centerY - (centerY * ((event.yGravity - accYinicial)*10))< display.contentHeight - 50)then
     y = centerY - (centerY * ((event.yGravity - accYinicial)*10))
     
    end 
    
     velX = vel * math.sin(GetAngulo(imgNave[0].x,imgNave[0].y, x,y)* valPi);
     velY = -vel * math.cos(GetAngulo(imgNave[0].x,imgNave[0].y, x,y)* valPi);
 
    end
    
  
 
end

--event de tocar na nave
 local naveTouchEvent = function (event)
         
 if event.phase == "began" and especiais > 0 and dbNaveTouch == false  then
 
 tempoTapNave = system.getTimer()
     
     if(os.difftime(tempoTapNave, tempoUltTapNave) < 500 )then
     dbNaveTouch = true 
     especiais = especiais - 1
     end
 end
 if event.phase == "ended" and os.difftime(system.getTimer(),tempoTapNave) < 500 then
 tempoUltTapNave = system.getTimer()
 end
     
--  l_dispara = true;

--end
 end
 --evento de tocar na tela atualiza o x e o y
 local OnScreenTouch = function (event)
     
     if event.phase == "began" and begin == false then
        table.insert(touchs,event.id)
        
     end
     if event.phase == "ended" then
        if(#touchs > 1 and especiais > 0 and dbNaveTouch == false and os.difftime(system.getTimer(),tempoTapNave) > 500)  then 
                 dbNaveTouch = true 
                 especiais = especiais - 1
                 
       tempoTapNave = system.getTimer()
        end 
        if(touchs ~= nil)then
        for i = 0, #touchs do
         if(touchs[i] == event.id)then
        -- touchs[i]:removeSelf()
        touchs[i] = nil  
         end
      end
      end
      
      end
      if(acelerometro ==false) then
     y = event.y;
     x = event.x;
     
     velX = vel * math.sin(GetAngulo(imgNave[0].x,imgNave[0].y, x,y)* valPi);
     velY = -vel * math.cos(GetAngulo(imgNave[0].x,imgNave[0].y, x,y)* valPi);
     end
    
   
 end
 --mover nave para o x e o y
 function Player:moveNave()
          
     if colsrects[0].colidiu == true or (colsrects[1].colidiu == true and imgNave[0].isVisible == true ) then
         if(shield.isVisible == false)then
         if vida > -1 then
         shield:toFront();
         shield.isVisible = true;
         shield.tempo = system.getTimer();
         end
         vida = vida - 1;
         colsrects[0].colidiu = false;
         colsrects[1].colidiu = false;
        x = imgNave[0].x
        y = imgNave[0].y
         end
     end
     
     if system.getTimer() - shield.tempo > 900 then
         shield.isVisible = false;
     end
     
     if begin == false  then --and ativa == true
     local distancia = math.sqrt(((x - imgNave[0].x)*(x - imgNave[0].x))+((y - imgNave[0].y)*(y - imgNave[0].y)));
     local distanciaX = math.sqrt(((x - imgNave[0].x)*(x - imgNave[0].x))+((0)*(0)));   


    distancia = distancia*2
    distanciaX = distanciaX*2



     if distancia < 280 then
         velX = velX - (velX/distancia)*3;
         velY = velY - (velY/distancia)*3;
     end
    if distancia > 5 then
        for i = 0,# imgNave do
     imgNave[i].y =  imgNave[0].y + velY;
     imgNave[i].x = imgNave[0].x + velX;
        end
    else
        if(acelerometro == false)then
        velX = 0
        velY = 0
        end
    end
    
    
-----seta nave
    if math.ceil(velX) ~= 0 then
        
        if(imgNave[0].x < x ) then
        imgNave[0].isVisible = false
        imgNave[1].isVisible = false
        imgNave[2].isVisible = false
        
           if(distanciaX < 40 )then
             if(distanciaX >=20)then
             imgNave[3].isVisible = true
             imgNave[4].isVisible = false
             end
           else
            imgNave[3].isVisible = false
            imgNave[4].isVisible = true
            end
                        
        elseif (imgNave[0].x> x) then
        imgNave[0].isVisible = false
        imgNave[4].isVisible = false
        imgNave[3].isVisible = false
        if(distanciaX < 40 )then
             if(distanciaX >= 20)then
             imgNave[1].isVisible = true
             imgNave[2].isVisible = false
             end
           else
            imgNave[1].isVisible = false
            imgNave[2].isVisible = true
            end
        
        end
        
        else 
        imgNave[0].isVisible = true
        imgNave[1].isVisible = false
        imgNave[2].isVisible = false
        imgNave[4].isVisible = false
        imgNave[3].isVisible = false
        end
       
    
    end 
         if(imgNave[0].isVisible == false and imgNave[1].isVisible == false  and imgNave[2].isVisible == false and imgNave[3].isVisible == false and imgNave[4].isVisible == false  )then
              imgNave[0].isVisible = true 
         end
         colsrects[0].x = imgNave[0].x;
         colsrects[0].y = imgNave[0].y;
         colsrects[1].x = imgNave[0].x;
         colsrects[1].y = imgNave[0].y;
         shield.x = imgNave[0].x;
         shield.y = imgNave[0].y;

 end
 ---evento de animação inicial 
local startFase = function (event)

if begin == true then

if imgNave[0].y < display.contentHeight * 0.79 then
if imgNave[0].y < 20 then
imgNave[0].y = imgNave[0].y + 1000/20;	
else
imgNave[0].y = imgNave[0].y + 1000/imgNave[0].y;
end 
elseif imgNave[0].y < display.contentHeight * 0.87  then
imgNave[0].y = imgNave[0].y + imgNave[0].y/imgNave[0].y;

end

if imgNave[0].y > display.contentHeight * 0.86 then
    begin = false;
    l_dispara = true;
    y = imgNave[0].y
end
end


end

--carrega o player
function Player:New()
physics.start(); 
physics.setGravity(0,0);   
 -- display.remove(imgNave)
 if(imgNave == nil) then
 imgNave = {}

imgNave[0]= display.newImageRect("imagens/player/imgNave.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[1]= display.newImageRect("imagens/player/imgNave30g.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[2]= display.newImageRect("imagens/player/imgNave60g.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[3]= display.newImageRect("imagens/player/imgNave30gD.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
imgNave[4]= display.newImageRect("imagens/player/imgNave60gD.png", display.contentWidth *0.294 ,display.contentWidth *0.294)
  end
 colsrects = {};
 --difY = imgNave.width *0.26
shield = display.newImageRect("imagens/player/shield.png",imgNave[0].width +70 ,imgNave[0].height +40);
 
 x,y = display.contentCenterX , -55;
 velX  = 1;
 velY = 1;
 vel = 7;
 valPi = math.pi/180;
 begin = true ;
 ativa = false;
 vida = 5;
 especiais = 3
dbNaveTouch = false
   for i = 0,#imgNave do
   local nome = {"Player",i}
   nome = table.concat(nome)
   imgNave[i]:toFront();
   imgNave[i].name = nome;
   imgNave[i].x = x;
   imgNave[i].y = y;
   if(i > 0 ) then
       imgNave[i].isVisible = false
   end
   end 
   
   colsrects[0] = display.newRect(0, 0,imgNave[0].width *0.9,imgNave[0].height *0.5);--90,30--tx,ty
   --colsrects[0]:setFillColor(0.5,0.5,0.5,0.5)
   colsrects[0]:setFillColor(1,0,0,0);
   colsrects[0].x = x;
   colsrects[0].y = y;
   colsrects[0].name = "Player";
   colsrects[0].tipo = "Player";
   colsrects[0].colidiu = false;
   colsrects[1] = display.newRect(0, 0,imgNave[0].width * 0.273,imgNave[0].height * 0.8);--30,100
   --colsrects[1]:setFillColor(0.5,0.5,0.5,0.5)
   colsrects[1]:setFillColor(1,0,0,0);
   colsrects[1].x = x;
   colsrects[1].y = y;
   colsrects[1].name = "Player";
   colsrects[1].tipo = "Player";
   colsrects[1].colidiu = false;
   shield.isVisible = false;
   shield.tempo = system.getTimer();
  -- shield:toFront()
   physics.addBody(colsrects[0] , "static");
   physics.addBody(colsrects[1] , "static");
   tempoTapNave = system.getTimer()
   tempoUltTapNave = 0
   

   centerX = display.contentWidth * 0.5
   centerY = display.contentWidth * 0.5
   accYinicial = 0
   touchs = {}



   
 end


--para ver se foi clicado na nave atira
function Player:Disparou()
    
 return l_dispara; 
 
end

function Player:GetEspeciais()
    
 return especiais; 
 
end

function Player:SetEspeciais(_qtEspeciais)
    
 especiais= especiais + _qtEspeciais; 
 
end

local  function PlayerEvents ()
if begin == true then
 Runtime:addEventListener("enterFrame" , startFase);
 else 
 Runtime:removeEventListener("enterFrame" , startFase);
 end
  
end
--retorn x nave
function Player:GetX()
    return imgNave[0].x;
end
function Player:GetY()
    return imgNave[0].y;
end
function Player:GetBegin()
    return begin;
end
function Player:GetLife()
    return vida;
end
function Player:SetLife(_vida)
    vida = vida + _vida ;
end
function Player:Especial()
    local dbTouch = dbNaveTouch
    if (dbNaveTouch)then 
        dbNaveTouch = false
    end
    return dbTouch    
end

function Player:GetPlayerEvents()
 
PlayerEvents();
Runtime:addEventListener("touch", OnScreenTouch);
if(acelerometro == true)then
Runtime:addEventListener( "accelerometer", onAccelerate )
end
--imgNave[0]:addEventListener("touch", naveTouchEvent);

end

function Player:ClearAll()
Runtime:removeEventListener("enterFrame" , startFase);
 Runtime:removeEventListener("touch", OnScreenTouch); 
 Runtime:removeEventListener("accelerometer", onAccelerate )
 --imgNave[0]:removeEventListener("touch", naveTouchEvent);
for k = 0,#touchs do
if touchs[k] then
touchs[k]:removeSelf();
touchs[k] = nil;
end
end
touchs = nil;

for j = 0,#imgNave do
if imgNave[j] then
display.remove(imgNave[j]);
imgNave[j]:removeSelf();
imgNave[j] = nil;
end
end
imgNave = nil;

for i = 0, #colsrects do
    if colsrects[i] then
    physics.removeBody(colsrects[i]);
    display:remove(colsrects[i]);
    colsrects[i]:removeSelf()
    colsrects[i] = nil;
    end
end
display:remove(colsrects);
colsrects = nil;
display.remove(shield);
shield = nil;
l_dispara = nil;
x = nil;
y = nil;
velX  = nil;
velY = nil;
vel = nil;
valPi = nil;
begin = nil ;
ativa = nil;
vida = nil;
especiais = nil
dbNaveTouch = nil
tempoTapNave = nil
tempoUltTapNave = nil

end


-- faz tudo acontecer


return Player

