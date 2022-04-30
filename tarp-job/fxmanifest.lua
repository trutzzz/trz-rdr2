description 'ta-job'

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
   'config.lua',
   'client/*.lua'
}

server_scripts {
   'config.lua',
   'server/*.lua'
}

shared_scripts {
	'locale.lua',
	'locales/en.lua',
}