
local  widget = require "widget"

local SimpleButton = {}
local doSomething = false
local bImagens
local bRectImage = nil
local bX,bY = 0
local tipo 
--tipo é ou 'I' magem ou 'W'idget
--quando tipo imagem ela dever ser nomeada terminando em 1 e 2 e quando for widget a segunda deve ser Over
--nao curtiu ? faca vc 
---criacao de botoes simples 
--se faz algo (oSomething ) for false imagem zero aparece se true a imagem 1
--
function SimpleButton:New(_doSomething,_bX,_bY,_wI,_hI,_localImagem,_extImagem,_tipo)
    doSomething = _doSomething
    bX = _bX
    bY = _bY
    tipo = _tipo 
    local arquivo
     
    if(_tipo == "I") then 
        ---insere imagem transparente para se usada para pegar o touch 
           bRectImage = display.newRect(0, 0, _wI, _hI) 
           bRectImage.x = bX
           bRectImage.y = bY
           bRectImage:setFillColor(0,0, 0,0.01)
            
    bImagens = {}
    for i = 0,1 do
    arquivo = {_localImagem,i+1,".",_extImagem}    
    arquivo = table.concat(arquivo)
    bImagens[i] = display.newImageRect(arquivo, _wI,_hI)
    bImagens[i].isVisible = false
    bImagens[i].x = bX
    bImagens[i].y = bY
    end
       
    if(doSomething == false) then
        bImagens[0].isVisible = true
        bImagens[1].isVisible = false
    else
         bImagens[0].isVisible = false
        bImagens[1].isVisible = true
    end
    
    
    elseif(_tipo == "W") then
        arquivo = {_localImagem,".",_extImagem}
        arquivo = table.concat(arquivo)
        local arquivo2 = {_localImagem,"Over.",_extImagem}
        arquivo2 = table.concat(arquivo2)
        local 
         bImagens = nil
        bImagens = widget.newButton{
        defaultFile=arquivo,
	overFile=arquivo2,
        width=_wI, height=_hI,
	onRelease = onBtnRelease-- event listener function
	}
        
    bImagens.x = bX
    bImagens.y = bY
    
    end
    
end
---evento de soltar o botao do tipo Widget
local function onBtnRelease()
    
    if(doSomething == false) then
        doSomething = true
    else
        doSomething = false
    end
    
end
--limpa as variaveis
function SimpleButton:Clear()
 widget = nil
 SimpleButton = nil
 doSomething = false
 bX,bY = nil
 tipo = nil
     if(tipo == "I") then 
         for i = 0,#bImagens do
         display.remove(bImagens[i])
         bImagens[i]:removeSelf()
         bImagens[i] = nil
         end
     end
     display.remove(bImagens)
     bImagens:removeSelf()
     bImagens = nil 
     
     if(bRectImage ~= nil)then
     display.remove(bRectImage)
     bRectImage = nil
     end
     
end
---reorna o etado da variavel doSomething
function SimpleButton:GetDoSomething()
    return doSomething
end
---retorna o objeto para inserir no grupo 
function SimpleButton:GetObject()
    
    if(tipo == "I") then
     return bImagens
    else
     return bRectImage
    end
  
  
  
end
---pegar o X e Y
function SimpleButton:GetbXbY(x,y)
x = bX
y = bY
end
--setar o x e o y 
--Ainda nao pronto, se precisar, mais tarde arrumo 
function SimpleButton:SetbXbY(x,y)
bX = x
bY = y
end


--falta verificar remosao de evento do widget e tudode imagem 
--bImagens:addEventListener("touch", onBtnRelease

return SimpleButton