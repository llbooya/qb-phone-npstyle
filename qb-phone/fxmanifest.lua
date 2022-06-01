fx_version 'cerulean'
game 'gta5'

author 'Booya#0001'
description 'Edits and additionals with Jerzy#9709\'s assistance. Original inspiration and editing from amir_expert#1911'
version 'Release'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    '@qb-apartments/config.lua',
    '@qb-garages/config.lua',
}

client_scripts {
    'client/main.lua',
    'client/animation.lua',
    'client/videoCallclient.lua',
    "client/NakresvideoCallcamera.lua",
    'client/discordia.lua',
    'client/room_creation.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/videoCallserver.lua',
    'server/discordia.lua',
    'server/room_creation.lua'
}

files {
    "module/*.js",
    "module/animation/tracks/*.js",
    "module/animation/*.js",
    "module/audio/*js",
    "module/cameras/*.js",
    "module/core/*.js",
    "module/extras/core/*.js",
    "module/extras/curves/*.js",
    "module/extras/objects/*.js",
    "module/extras/*.js",
    "module/geometries/*.js",
    "module/helpers/*.js",
    "module/lights/*.js",
    "module/loaders/*.js",
    "module/materials/*.js",
    "module/math/interpolants/*.js",
    "module/math/*.js",
    "module/objects/*.js",
    "module/renderers/shaders/*.js",
    "module/renderers/shaders/ShaderChunk/*.js",
    "module/renderers/shaders/ShaderLib/*.js",
    "module/renderers/webgl/*.js",
    "module/renderers/webxr/*.js",
    "module/renderers/webvr/*.js",
    "module/renderers/*.js",
    "module/scenes/*.js",
    "module/textures/*.js",
    "script.js",

    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/css/*.css',
    'html/fonts/*.ttf',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/img/backgrounds/*.png',
    'html/img/apps/*.png',
}

exports {
    'InPhone'
}

lua54 'yes'

dependency '/assetpacks'