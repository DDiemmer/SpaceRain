
local nave 
local tiro 
local asteroid 
local itens

local Cenario = {}

local vel = 3

local vida
local shieldsNum
local multiShieldLabel
local scoreTxt
local imgmoney
local fimfase = false
local veltiro = 0.4
local gameover 
local DisplayXwidth = 320  --display.contentWidth 
local DisplayYheight = 480  --display.contentHeight
local bgFixo = {}
local bgStars = {}
local tipoTiro = 1
local tempoTiro = 25
local lastTiro = 0
local imgtiroAtivo
local txtTiroTempo
local imgCopy
local imgEspecial 
local imgEesp
local scoreRecAux= 0
local scoreAux = 0
local somRecom 
---- monta e ordena as estrelas 
 local function MontaBGStars()
    
   
    

    bgFixo[0] = display.newImage("imagens/Cenario/BgFixo.jpg",DisplayXwidth, DisplayYheight+30)
    bgFixo[1] = display.newImage("imagens/Cenario/BgFixo.jpg",DisplayXwidth, DisplayYheight+30)
    bgFixo[0].x= display.contentCenterX
    bgFixo[0].y =display.contentCenterY
    bgFixo[1].x = display.contentCenterX
    bgFixo[1].y =display.contentCenterY - DisplayYheight-30
    bgFixo[1]:rotate(180)
    bgFixo[0]:toBack()
    bgFixo[1]:toBack()
      
    local j =0
     for i = 0, 16 do
          
     local arquivo = {"imagens/Cenario/star",j,".png"}
     arquivo = table.concat(arquivo)
     bgStars[i] = display.newImage(arquivo,DisplayYheight, DisplayYheight)
     
     if(i < 4)then
     bgStars[i].x = display.contentCenterX
     bgStars[i].y = display.contentCenterY
     else
     bgStars[i].x = math.random(0,(DisplayXwidth/2))
     bgStars[i].y = math.random(0,(DisplayYheight/2))+ DisplayYheight  * -1
     end
     -- bgFixo[i].y =display.contentCenterY - DisplayYheight
     bgStars[i]:rotate(math.random(0,360))
     
    bgStars[i]:toBack()
    
     j = j+1 
     
     if(j>4)then
         j=0 
     end
     end 
     
end
 
 local function addEsp(_num)
    
       
    for i = _num,1,-1 do
        
    
    imgCopy =  display.newImageRect("imagens/Cenario/especial.png",30,30)  
    imgCopy.x = display.contentWidth - 80
    imgCopy.y =  (imgCopy.height/2) + 2
    
    if(#imgEspecial > 0) then
        imgCopy:rotate(imgEspecial[#imgEspecial].rotation-45)
    end
        
    table.insert(imgEspecial,imgCopy)
    imgCopy = nil
    end
    
end

function Cenario:New(fase)
    --TODO
    acelerometro = musicaOn
    
    nave = require "Player"
    tiro = require "Tiro"
    asteroid = require "Inimigos"
    itens = require "DropItens"
    
    vel = 3
    --vida = {}
    fimfase = false
    veltiro = 0.4
    tipoTiro = 1
    --stage = fase
    DisplayXwidth = 320 
    DisplayYheight = 480  
    bgFixo = {}
    bgStars = {}
    
    tempoTiro = 25
     --iniciando imagens cenario 
    MontaBGStars()
        
    nave:New()   
    
    shieldsNum = nave:GetLife()
    --if nave:GetBegin() == false then
    asteroid:AddNew() 
   
    tiro:New()   
    
    itens:New()
    
   --end
   --iniciando imagem score(money) e labels de score e stage
    imgmoney =  display.newImageRect("imagens/Cenario/uniMoney.png",41,31)
    imgmoney.x= imgmoney.width
    imgmoney.y = 2 + imgmoney.height/2 
    imgmoney:toFront()
    scoreTxt = display.newText(0, imgmoney.width + 50 ,imgmoney.y, "Arial",22)
    scoreTxt:setFillColor(0.35, 0, 1)
    vida = display.newImageRect("imagens/Cenario/smalShield.png", 45,32)
    vida.x = (display.contentWidth/2)
    vida.y = vida.height/2
    multiShieldLabel = display.newText(shieldsNum, vida.x + 1, (vida.height/2)+2, "Arial", 18)
    multiShieldLabel:setFillColor(0, 0, 0.7)
         
    imgtiroAtivo =  display.newImageRect("imagens/Itens/Droptiro12.png",30,30)  
    imgtiroAtivo.x = display.contentWidth - (imgtiroAtivo.width ) 
    imgtiroAtivo.y =  (imgtiroAtivo.height/2) + 2
    
    txtTiroTempo = display.newText(0, imgtiroAtivo.x ,imgtiroAtivo.y, "Arial Black",20)
    txtTiroTempo:setFillColor(0.35, 0,0)
    txtTiroTempo.text = 8
    txtTiroTempo:rotate(90)
    
    imgEesp =   display.newImageRect("imagens/Cenario/Esp.png",20,20)  
    imgEesp.x = display.contentWidth - 80
    imgEesp.y =  (imgtiroAtivo.height/2) + 2
    
    imgEspecial = {}
    
    addEsp(nave:GetEspeciais())
    scoreRecAux = 0
    scoreAux = 0
    
    somRecom  = audio.loadSound("Sons/drag.wav")
    
    gameover = false;
 
  
   
end

local function MoveStars() 
  
  for i = 0,#bgStars do
      
      local velY = 1
      if(i< (#bgStars/2))then
          velY = 0.6
      end
      
       bgStars[i].y = bgStars[i].y + velY
       
      -- movve BgFIXO 
      
     if(bgFixo ~= nil and #bgFixo> 0 ) then 
      if(i <= #bgFixo) then
        bgFixo[i].y = bgFixo[i].y + 0.2
         --se saiu da tela vai para cima de novo 
        if(bgFixo[i].y >= DisplayYheight + (bgFixo[i].contentHeight/2)) then
            bgFixo[i].y = - (bgFixo[i].contentHeight/2) -- -15-DisplayYheight
        end
--        bgFixo[i]:toBack()
         
      end
        
        bgFixo[0]:toBack()
        bgFixo[1]:toBack()
        end
        
        if(bgStars[i].y >= math.random(0,600)+DisplayYheight + (bgStars[i].contentHeight/2)) then
              bgStars[i].x = math.random(0,(DisplayXwidth/2))
            bgStars[i].y = math.random(0,(DisplayYheight/2))+ DisplayYheight  * -1
        end
        
        
        bgStars[i]:toBack()
           
  end
  
     
end

local CenarioEventsFrames = function (event) 

     MoveStars()

--  incluindo tiro 
     itens:AnimaItens()
    --if atirar == true then
   -- tipoTiro = 2

   
    imgtiroAtivo:rotate(2)
    
   if(tipoTiro > 1) then
      -- imgtiroAtivo:rotate(3)
      txtTiroTempo.text = math.ceil((30000 - (system.getTimer()- lastTiro))/1000)
       imgtiroAtivo:rotate(6)
      if(math.ceil((30000 - (system.getTimer() - lastTiro))) <= 0)then
      tipoTiro = 1
      
      txtTiroTempo.text = 8
      txtTiroTempo:rotate(90)
      end          
   end
   
   
    tiro:News(nave,veltiro,tipoTiro)
    
    
   if(imgEspecial ~= nil)then
       for i = 0, #imgEspecial do
           if(imgEspecial[i] ~= nil) then              
           
           imgEspecial[i]:rotate(5)
             
            if(nave:GetEspeciais() < #imgEspecial )then
             display.remove(imgEspecial[i])
                table.remove(imgEspecial,i)
            end
                        
           end       
       end
   end
   
   --------- Recompensa
   scoreRecAux = scoreRecAux + asteroid:GetScore() - scoreAux
    
   if(scoreRecAux>= 1000) then 
    if (soundOn == true ) then
        audio.play(somRecom)
    end
    nave:SetEspeciais(2)
    addEsp(2) 
    nave:SetLife(3)
    scoreRecAux = scoreRecAux - 1000
   end
          
   scoreAux = asteroid:GetScore()       
  --end 
   ---moveEvents
   if (nave:GetBegin()==false)then 
   asteroid:MoveAsteroids()
    end
       
   tiro:moveTiro()
   nave:moveNave()
   
   scoreTxt.text = asteroid:GetScore()
   scoreTxt:toFront()
   imgmoney:toFront()
   
   vida:toFront() 
   shieldsNum = nave:GetLife()
   multiShieldLabel.text = shieldsNum
   multiShieldLabel:toFront();
   if (shieldsNum < 1) then
       vida.isVisible = false;
       multiShieldLabel.isVisible = false;
   else 
       vida.isVisible = true;
       multiShieldLabel.isVisible = true;
   end
   
   if nave:GetLife() == -1   then
       pontos = asteroid:GetScore()
       gameover = true
   end
 
  end

local SetCollision = function (event)
    
    
if event.phase == "began" and (event.object1.name == "Tiro" or event.object2.name == "Tiro") then
     if (event.object1.name == "Asteroids" or event.object2.name == "Asteroids") then

     if(tipoTiro == 1 or  tipoTiro == 4)then 
         event.object1.colidiu = true
         event.object2.colidiu = true
         event.object2.espC = true
         event.object1.espC = true
     else 
        if (event.object1.name == "Asteroids") then
            event.object1.colidiu = true
            event.object2.espC = true
        elseif  (event.object2.name == "Asteroids") then
            event.object2.colidiu = true
            event.object1.espC = true
            
        end
     end
     end 
     
elseif event.phase == "began" and (event.object1.name == "Player" or event.object2.name == "Player") then
     if (event.object1.name == "Asteroids" or event.object2.name == "Asteroids") then
     event.object1.colidiu = true
     event.object2.colidiu = true
     end
     
end

   if event.phase == "began" and (event.object1.name == "Item" or event.object2.name == "Item") then
     if(event.object1.name == "Player" or event.object2.name == "Player")then
        if(event.object1.tipo == "Shield" or event.object2.tipo == "Shield")then
           nave:SetLife(3)
        elseif ((event.object1.tipo == "Tiro" or event.object2.tipo == "Tiro"))then
            if(tipoTiro == 1) then
            txtTiroTempo:rotate(-90)
            end
            lastTiro = system.getTimer()
            tipoTiro = 2
        elseif ((event.object1.tipo == "Tiro2" or event.object2.tipo == "Tiro2"))then
            if(tipoTiro == 1) then
            txtTiroTempo:rotate(-90)
            end
            lastTiro = system.getTimer()
            tipoTiro = 4
        elseif ((event.object1.tipo == "Especial" or event.object2.tipo == "Especial"))then
            nave:SetEspeciais(2)
            addEsp(2) 
        end
     if(event.object1.name == "Item") then
      event.object1.colidiu = true
      else
      event.object2.colidiu = true
      end
     
    end
    end

end
function Cenario:GetFimdaFase()
    
    return fimfase
    
end
function Cenario:GetGameOver()
    return gameover
end
function Cenario:GetEvents()
    
Runtime:addEventListener("enterFrame",CenarioEventsFrames)
Runtime:addEventListener("collision", SetCollision)
nave:GetPlayerEvents()
 
 end
function Cenario:ClearAll()
    
Runtime:removeEventListener("enterFrame",CenarioEventsFrames)
Runtime:removeEventListener("collision", SetCollision)

tiro:ClearAll()
table.remove(tiro)
tiro = nil

nave:ClearAll()
table.remove (nave)
nave = nil

itens:ClearAll()
table.remove (itens)
itens = nil

asteroid:ClearAll()
table.remove (asteroid)
asteroid = nil

vel = nil

for a = #bgStars,0,-1 do
    if bgStars[a] then
        display:remove(bgStars[a])
        bgStars[a]:removeSelf();
        table.remove(bgStars,a)
        bgStars[a] = nil
    end
end

bgStars = nil

for i = #bgFixo,0,-1 do
    if bgFixo[i] then
        display:remove(bgFixo[i])
        bgFixo[i]:removeSelf();
        table.remove(bgFixo,i)
        bgFixo[i] = nil
    end
end

 for j = #imgEspecial,0,-1 do
 
 if imgEspecial[j] ~= nil then
            display.remove(imgEspecial[j])
            imgEspecial[j]:removeSelf()
            imgEspecial[j] = nil
 end
 end
 
 if imgCopy then
     display:remove(imgCopy)
     imgCopy:removeSelf()
     imgCopy = nil
 end


bgFixo = nil

display.remove(vida)
vida = nil

display.remove(multiShieldLabel)
multiShieldLabel = nil

display.remove(scoreTxt)
scoreTxt = nil

display.remove(txtTiroTempo)
txtTiroTempo = nil
--display.remove(stage)
--stage = nil 
display.remove(imgmoney)
imgmoney = nil

display.remove(imgtiroAtivo)
imgtiroAtivo = nil

display.remove(imgEesp)
imgEesp = nil

if(somRecom) then
    somRecom = nil
end

scoreRecAux = nil
scoreAux = nil
tipoTiro =  nil
tempoTiro = nil
lastTiro = nil
fimfase = nil
veltiro = nil
txtTiroTempo = nil
scoreTxt = nil
gameover = nil

end


return Cenario