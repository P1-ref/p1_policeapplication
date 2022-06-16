RegisterServerEvent("p1_policeapplication:ReceivedApplication")
AddEventHandler("p1_policeapplication:ReceivedApplication", function(data)
    SendDiscordMessage(
        "***--- [Personuppgifter] ---***\n" ..
        "**Namn:** " .. data.name .. "\n" ..
        "**Födelsedatum:** " .. data.birthdate .. "\n" ..
        "**Discord-namn:** " .. data.discordname .. "\n" ..
        "***--- [Allmänt] ---***\n" ..
        "**Hur länge har du bott här?:** " .. data.lived_here .. "\n" ..
        "**Har du tidigare erfarenhet från polisen?:** " .. data.xp_police .. "\n" ..
        "**Körkort:** " .. data.veh_license .. "\n" ..
        "***--- [Resonering] ---***\n" ..
        "**Berätta om dig själv:** " .. data.info_you .. "\n" ..
        "**Vad innebär ett sunt förnuft?:** " .. data.logic_thinking .. "\n" ..
        "**Vad definierar en bra polis enligt dig?:** " .. data.good_cop .. "\n" ..
        "**Resonera kring polisens uppgifter:** " .. data.police_tasks .. "\n" ..
        "***--- [Vår poliskår] ---***\n" ..
        "**Varför tycker du att vi ska acceptera just dig?:** " .. data.accept_you .. "\n" ..
        "**Berätta om dina planer inom polisen:** " .. data.plans .. "\n" ..
        "**Hur ofta kommer du att vara i tjänst?:** " .. data.in_duty .. "\n" ..
        "**Tillägg:** " .. data.additions
    )
end)

SendDiscordMessage = function(message)
    local embeds = {
        {
            type = "rich",
			color = 3447003,
            title = "Ny polisansökan!",
			description = message,
			footer = {
				text = os.date("%d") .. "/" .. os.date("%m") .. "/" .. os.date("%Y") .. " - " .. os.date("%H") .. ":" .. os.date("%M")
			}
        }
	}

	PerformHttpRequest(Config["Webhook"], function(err, text, headers) end, "POST", json.encode({username = "p1_policeapplication", embeds = embeds}), { ["Content-Type"] = "application/json" })
end
