

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'client/*.lua',
    'config.lua'
}

ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/script.js",
	"ui/style.css",
	"ui/crock.ttf",
	"ui/health.png",
	"ui/stamina.png",
	"ui/hunger.png",
	"ui/thirst.png",
	"ui/horse_health.png",
	"ui/horse_stamina.png",
	"ui/progress.png",
}

shared_script 'config.lua'

server_scripts {
    'server/*.lua',
    'config.lua',    
}

export 'getThirst'
export 'getHunger'