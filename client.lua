ESX = exports["es_extended"]:getSharedObject()

local UIactive = false

RegisterNUICallback("EventManager", function(data)
    if (data.event == "Exit") then 
        UIactive = false
        SetNuiFocus(false)
        return
    elseif (data.event == "ReceivedApplication") then
        local data = data.data
        UIactive = false
        SetNuiFocus(false)
        TriggerServerEvent("p1_policeapplication:ReceivedApplication", data)
        ESX.ShowNotification(Config["Strings"]["SentApplication"])
    end
end)

Citizen.CreateThread(function()
    if (Config["Blip"]["Show"]) then
        for i=1, #Config["Locations"] do
            local blip = AddBlipForCoord(Config["Locations"][i])
        
            SetBlipSprite(blip, Config["Blip"]["Icon"])
            SetBlipScale(blip, Config["Blip"]["Scale"])
            SetBlipColour(blip, Config["Blip"]["Color"])
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config["Strings"]["BlipName"])
            EndTextCommandSetBlipName(blip)
        end
    end

    while (UIactive) do
        Wait(0)
        DisableControlAction(0, 1)
        DisableControlAction(0, 2)
        DisableControlAction(0, 142)
        DisableControlAction(0, 18)
        DisableControlAction(0, 322)
        DisableControlAction(0, 106)
    end
end)

Citizen.CreateThread(function()
    while (true) do
        sleep = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i=1, #Config["Locations"] do
            local applicationCoords = Config["Locations"][i]
            local dist = #(playerCoords - applicationCoords)
            if (dist <= 1.5) then
                sleep = 5
                FloatingText(applicationCoords, Config["Strings"]["PressEToOpen"])
                if (IsControlJustPressed(0, 38)) then
                    UIactive = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        event = "OpenWindow",
                    })
                end
            end
        end
        Wait(sleep)
    end
end)

FloatingText = function(coords, msg) 
    AddTextEntry(GetCurrentResourceName(), msg) 
    SetFloatingHelpTextWorldPosition(1, coords) 
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0) 
    BeginTextCommandDisplayHelp(GetCurrentResourceName()) 
    EndTextCommandDisplayHelp(2, false, false, -1) 
end