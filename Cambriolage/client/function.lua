
function CamFunctiond()
    CamM = CreateCam("DEFAULT_SCRIPTED_CAMERA", 50)
    SetTimecycleModifier("heliGunCam")
    SetCamActive(CamM, 1)
    SetCamCoord(CamM, vector3(117, 556.515014, 184.5000))
    SetCamFov(CamM, 50.0)
    PointCamAtCoord(CamM, vector3(50.66433, 9000.00, 185.46595))
    RenderScriptCams(1, 0, 0, 0, 0)

end

function DeleteCam()
    RenderScriptCams(0, 1, 1000, 0, 0)
    SetCamActive(CamM, false)
    SetTimecycleModifier('')
end

RegisterCommand('delte', function()  
    DeleteCam()
end)

Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
		local dst = GetDistanceBetweenCoords(pCoords, true)
        for k,v in pairs(config.cambriolage) do
			if #(pCoords - v.pos) < 1.5 then
                DrawMarker(22, 118.2617, 543.8978, 183.897, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                DrawMarker(22, 126.3001, 543.549, 183.897, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                DrawMarker(22, 117.9613, 548.7766, 184.0970, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                DrawMarker(22, 116.45288, 561.784, 180.4970, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                cambriolage = true
                RageUI.Text({message = "Appuyez sur [~b~E~s~] pour voler.",time_display = 100,})
				if IsControlJustReleased(0, 38) then
                    exports['progressBars']:startUI(10000, "")
                    FreezeEntityPosition(PlayerPedId(), true)
                    takeAnim()
					TriggerServerEvent('test:amount')
                    FreezeEntityPosition(PlayerPedId(), false)
				end
            end
        end

        if cambriolage then
            Wait(1)
        else
            Wait(500)
        	end
		end
end)


function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

function takeAnim()
    local ped = GetPlayerPed(-1)
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Citizen.Wait(10000)
    end
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(10000)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end


Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(122.9432, 557.6515, 184.2970)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 5 then
            interval = 200
        else
            interval = 1
            DrawMarker(22, 122.9432, 557.6515, 184.2970, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
            if distance < 1 then  

                RageUI.Text({message = "Appuyez sur [~b~E~s~] pour voler.",time_display = 100,})

                if IsControlJustPressed(1, 51) then 
                    exports['progressBars']:startUI(10000, "")
                    FreezeEntityPosition(PlayerPedId(), true)
                    takeAnim()
					TriggerServerEvent('weapon')
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            end
        end

        Citizen.Wait(interval)
    end
end)


function aTenue()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 178,   ['torso_2'] = 9,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 77,   ['pants_2'] = 9,
                ['shoes_1'] = 55,   ['shoes_2'] = 9,
                ['helmet_1'] = 91,  ['helmet_2'] = 9,
                ['chain_1'] = 1,    ['chain_2'] = 0,
                ['mask_1'] = -1,  ['mask_2'] = 0,
                ['ears_1'] = 2,     ['ears_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 178,   ['torso_2'] = 9,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 77,   ['pants_2'] = 9,
                ['shoes_1'] = 55,   ['shoes_2'] = 9,
                ['helmet_1'] = 91,  ['helmet_2'] = 9,
                ['chain_1'] = 1,    ['chain_2'] = 0,
                ['mask_1'] = -1,  ['mask_2'] = 0,
                ['ears_1'] = 2,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end