-- Xeno GUI Lua - Brookhaven Fling (Bypass FE Kill)

local Players = game:Service("Players")
local RunService = game:Service("RunService")
local LocalPlayer = Players.LocalPlayer

local function executarFlingNoMaisProximo()
    local meuChar = LocalPlayer.Character
    local meuRoot = meuChar and meuChar:FindFirstChild("HumanoidRootPart")
    local meuHum = meuChar and meuChar:FindFirstChildOfClass("Humanoid")
    
    if not meuRoot or not meuHum then return end
    
    -- Encontra a pessoa mais próxima para aplicar o Fling
    local alvo = nil
    local menorDistancia = 15 -- Só funciona se você chegar bem perto do alvo (em blocos)
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (meuRoot.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if dist < menorDistancia then
                alvo = p.Character.HumanoidRootPart
                menorDistancia = dist
            end
        end
    end
    
    -- Se achar alguém perto, ativa o bug de física para empurrar e matar o alvo
    if alvo then
        local bV = Instance.new("BodyVelocity")
        bV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bV.Velocity = Vector3.new(10000, 10000, 10000) -- Força massiva de arremesso
        bV.Parent = meuRoot
        
        -- Faz seu corpo colidir agressivamente com a física do alvo por meio segundo
        task.wait(0.3)
        bV:Destroy()
    end
end

-- Executa o truque
executarFlingNoMaisProximo()
