fx_version "cerulean"

game "gta5"

author "P1-ref#2189"

description "Polisansökan in-game, svaren skickas via webhook till discord."

client_script "client.lua"
server_script "server.lua"
shared_script "config.lua"

ui_page "nui/index.html"

files {
    "nui/index.html",
    "nui/script.js",
    "nui/style.css"
}