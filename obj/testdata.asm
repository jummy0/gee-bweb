;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (MINGW64)
;--------------------------------------------------------
	.module testdata
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sizeof_test_data
	.globl _test_data
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_test_data:
	.ascii "<!DOCTYPE html>"
	.db 0x0a
	.ascii "<html>"
	.db 0x0a
	.db 0x09
	.ascii "<head>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "<title>jummy</title>"
	.db 0x0a
	.ascii "<link rel="
	.db 0x22
	.ascii "stylesheet"
	.db 0x22
	.ascii " href="
	.db 0x22
	.ascii "/css/default.css"
	.db 0x22
	.ascii ">"
	.db 0x0a
	.ascii "<!--<link rel="
	.db 0x22
	.ascii "stylesheet"
	.db 0x22
	.ascii " href="
	.db 0x22
	.ascii "/css/good.css"
	.db 0x22
	.ascii ">-->"
	.db 0x0a
	.ascii "<meta name="
	.db 0x22
	.ascii "viewport"
	.db 0x22
	.ascii " content="
	.db 0x22
	.ascii "width=device-width, initial-scale=1, maximum-scale=1, user-s"
	.ascii "calable=1"
	.db 0x22
	.ascii "/>"
	.db 0x0a
	.ascii "<style>"
	.db 0x0a
	.ascii "</style>"
	.db 0x0a
	.db 0x09
	.ascii "</head>"
	.db 0x0a
	.db 0x09
	.ascii "<body>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "<header>"
	.db 0x0a
	.db 0x09
	.ascii "<a href="
	.db 0x22
	.ascii "/"
	.db 0x22
	.ascii ">"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "<h1>jummy</h1>"
	.db 0x0a
	.db 0x09
	.ascii "</a>"
	.db 0x0a
	.ascii "</header>"
	.db 0x0a
	.ascii "<nav>"
	.db 0x0a
	.db 0x09
	.ascii "<a href="
	.db 0x22
	.ascii "/"
	.db 0x22
	.ascii "><button class="
	.db 0x22
	.ascii "nav-button"
	.db 0x22
	.ascii " tabindex="
	.db 0x22
	.ascii "-1"
	.db 0x22
	.ascii ">About</button></a>"
	.db 0x0a
	.db 0x09
	.ascii "<a href="
	.db 0x22
	.ascii "http://jummy.bandcamp.com"
	.db 0x22
	.ascii "><button class="
	.db 0x22
	.ascii "nav-button"
	.db 0x22
	.ascii " tabindex="
	.db 0x22
	.ascii "-1"
	.db 0x22
	.ascii ">&#x1F517; My Music</button></a>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "<a href="
	.db 0x22
	.ascii "/cards"
	.db 0x22
	.ascii "><button class="
	.db 0x22
	.ascii "nav-button"
	.db 0x22
	.ascii " tabindex="
	.db 0x22
	.ascii "-1"
	.db 0x22
	.ascii ">Cards Game</button></a>"
	.db 0x0a
	.db 0x09
	.ascii "<a href="
	.db 0x22
	.ascii "/settings"
	.db 0x22
	.ascii "><button class="
	.db 0x22
	.ascii "nav-button"
	.db 0x22
	.ascii " tabindex="
	.db 0x22
	.ascii "-1"
	.db 0x22
	.ascii ">Background color</button></a>"
	.db 0x0a
	.db 0x09
	.ascii "<a href="
	.db 0x22
	.ascii "/contact"
	.db 0x22
	.ascii "><button class="
	.db 0x22
	.ascii "nav-button"
	.db 0x22
	.ascii " tabindex="
	.db 0x22
	.ascii "-1"
	.db 0x22
	.ascii ">File a complaint</button></a>"
	.db 0x0a
	.ascii "</nav>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "<main>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "<ul>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "<li>23 years old</li>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "<li>Musical artist</li>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "<li>Programmer</li>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "<li>Linguistics enthusiast</li>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "</ul>"
	.db 0x0a
	.ascii "            <h2>My links</h2>"
	.db 0x0a
	.ascii "            <p><b>Bandcamp:</b> <a href="
	.db 0x22
	.ascii "http://jummy.bandcamp.com"
	.db 0x22
	.ascii ">&#x1F517; jummy</a></p>"
	.db 0x0a
	.ascii "            <p><b>Discord:</b> jummy#9589</p>"
	.db 0x0a
	.ascii "            <p><b>YouTube:</b> <a href="
	.db 0x22
	.ascii "https://www.youtube.com/channel/UCynfXyMWcr876R6jJGkCjgA"
	.db 0x22
	.ascii ">&#x1F517; jummy</a> and <a href="
	.db 0x22
	.ascii "https://www.youtube.com/channel/UCY6X-L84Q6EzaoNORWKut9A"
	.db 0x22
	.ascii ">&#x1F517; jummy's game corner</a></p>"
	.db 0x0a
	.ascii "            <p><b>SoundCloud:</b> <a href="
	.db 0x22
	.ascii "http://www.soundcloud.com/jummy0"
	.db 0x22
	.ascii ">&#x1F517; jummy0</a></p>"
	.db 0x0a
	.ascii "            <p><b>GitHub:</b> <a href="
	.db 0x22
	.ascii "https://github.com/jummy0"
	.db 0x22
	.ascii ">&#x1F517; jummy0</a></p>"
	.db 0x0a
	.ascii "            <p><b>Twitter:</b> <a href="
	.db 0x22
	.ascii "http://twitter.com/jummyzero"
	.db 0x22
	.ascii ">&#x1F517; jummyzero</a></p>"
	.db 0x0a
	.ascii "            <p><b>Speedrun.com:</b> <a href="
	.db 0x22
	.ascii "https://www.speedrun.com/user/jummy0"
	.db 0x22
	.ascii ">&#x1F517; jummy0</a></p>"
	.db 0x0a
	.ascii "            <p><b>Twitch:</b> <a href="
	.db 0x22
	.ascii "http://twitch.tv/jummy0"
	.db 0x22
	.ascii ">&#x1F517; jummy0</a></p>"
	.db 0x0a
	.ascii "            <p><b>Duolingo:</b> <a href="
	.db 0x22
	.ascii "https://www.duolingo.com/profile/ProcessedCheese"
	.db 0x22
	.ascii ">&#x1F517; ProcessedCheese</a></p>"
	.db 0x0a
	.ascii "            <p>For more assorted content, <a href="
	.db 0x22
	.ascii "/~jummy"
	.db 0x22
	.ascii ">visit my subpage here</a>.</p>"
	.db 0x0a
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "<!--<h2>News</h2>-->"
	.db 0x0a
	.db 0x09
	.db 0x09
	.db 0x09
	.db 0x09
	.db 0x09
	.ascii "</main>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "<footer>"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "<p class="
	.db 0x22
	.ascii "text-center datetime"
	.db 0x22
	.ascii ">"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii "2023-05-10"
	.db 0xe2
	.db 0x80
	.db 0x83
	.ascii "02:35:49 UTC"
	.db 0x09
	.ascii "</p>"
	.db 0x0a
	.db 0x09
	.ascii "<p class="
	.db 0x22
	.ascii "text-center datetime"
	.db 0x22
	.ascii ">"
	.db 0x0a
	.db 0x09
	.db 0x09
	.ascii " "
	.db 0xe2
	.db 0x98
	.db 0xba
	.ascii " 2018"
	.db 0xe2
	.db 0x80
	.db 0x93
	.ascii "2023 jummy "
	.db 0x09
	.ascii "</p>"
	.db 0x0a
	.ascii "</footer>"
	.db 0x0a
	.db 0x09
	.ascii "</body>"
	.db 0x0a
	.ascii "</html>"
	.db 0x0a
	.db 0x00
_sizeof_test_data:
	.dw #0x08d6
	.area _INITIALIZER
	.area _CABS (ABS)
