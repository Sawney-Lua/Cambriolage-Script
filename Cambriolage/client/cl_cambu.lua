ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)


RegisterCommand("coords", function(source, args, rawcommand)
    local pos = GetEntityCoords(PlayerPedId())
    local LastPosH = GetEntityHeading(GetPlayerPed(-1))
    print(pos.x..", ^4"..pos.y..",^1 "..pos.z.." ^2 ".. LastPosH)
end, false)


Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(-842.7183, 466.814, 87.59)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 5 then
            interval = 200
        else
            interval = 1
            DrawMarker(22, -842.7183, 466.814, 87.59, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
            if distance < 1 then  

                RageUI.Text({message = "Appuyez sur [~b~E~s~] Commencer Le Braquage.",time_display = 100,})

                if IsControlJustPressed(1, 51) then 
                    open()
                end
            end
        end

        Citizen.Wait(interval)
    end
end)

Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(121.9677, 548.6577, 180.4972)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 5 then
            interval = 200
        else
            interval = 1
            DrawMarker(22, 121.9677, 548.6577, 180.4972, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
            if distance < 1 then  

                RageUI.Text({message = "Appuyez sur [~b~E~s~] Pouvez volez des Vêtements.",time_display = 100,})

                if IsControlJustPressed(1, 51) then 
                    aTenue()
                end
            end
        end

        Citizen.Wait(interval)
    end
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)

-------Commande Pose--------

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



-------Commande Pose--------


local cambriolage = false 

RMenu.Add('main', 'arm', RageUI.CreateMenu("Actions", "", 10,222))
RMenu:Get('main', 'arm'):SetSubtitle("Menu")
RMenu:Get('main', 'arm').EnableMouse = false
RMenu:Get('main', 'arm').Closed = function()
    cambriolage = false
end


function open()
	if cambriolage then
		cambriolage = true
	else
		cambriolage = true
		RageUI.Visible(RMenu:Get('main', 'arm'), true)
            Citizen.CreateThread(function()
                while cambriolage do
                    Citizen.Wait(1)
    		RageUI.IsVisible(RMenu:Get('main', 'arm'), true, true, true, function()	
					RageUI.ButtonWithStyle("Lancé le Braquage", " ", {}, true,function(h,a,s)
                        if s then
                            CamFunctiond()
                            SetEntityCoords(PlayerPedId(), 117.1398, 560.0418, 183.3048)
                            Wait(5000)  
                            ESX.ShowAdvancedNotification('LSPD INFORMATIONS', '~b~Demande de renfort', '~r~Une intrusion a été détécter par le système de surveillance.', 'CHAR_CALL911', 8)
                            DeleteCam()
                            AddTimerBar("Temps restants", {endTime=GetGameTimer()+270000})
                            Wait(270000)
                            RemoveTimerBar()
                            
                        end
					end)
                    RageUI.ButtonWithStyle("(POLICE) Rentré dans la maison de force", " ", {}, ESX.PlayerData.job.name == 'police',function(h,a,s)
                        if s then 
                            SetEntityCoords(PlayerPedId(), 117.1398, 560.0418, 183.3048) 
                        end
					end)
                end)
            end
        end)
    end
end









function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(anim, function()
		SetPedMotionBlur(plyPed, false)
		SetPedMovementClipset(plyPed, anim, true)
		RemoveAnimSet(anim)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end

function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end

