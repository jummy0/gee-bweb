#include <stdint.h>

const uint8_t test_data[] =
"\
<!DOCTYPE html>\n\
<html>\n\
	<head>\n\
		<title>jummy</title>\n\
<link rel=\"stylesheet\" href=\"/css/default.css\">\n\
<!--<link rel=\"stylesheet\" href=\"/css/good.css\">-->\n\
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=1\"/>\n\
<style>\n\
</style>\n\
	</head>\n\
	<body>\n\
		<header>\n\
	<a href=\"/\">\n\
		<h1>jummy</h1>\n\
	</a>\n\
</header>\n\
<nav>\n\
	<a href=\"/\"><button class=\"nav-button\" tabindex=\"-1\">About</button></a>\n\
	<a href=\"http://jummy.bandcamp.com\"><button class=\"nav-button\" tabindex=\"-1\">&#x1F517; My Music</button></a>\n\
		<a href=\"/cards\"><button class=\"nav-button\" tabindex=\"-1\">Cards Game</button></a>\n\
	<a href=\"/settings\"><button class=\"nav-button\" tabindex=\"-1\">Background color</button></a>\n\
	<a href=\"/contact\"><button class=\"nav-button\" tabindex=\"-1\">File a complaint</button></a>\n\
</nav>\n\
		<main>\n\
			<ul>\n\
				<li>23 years old</li>\n\
				<li>Musical artist</li>\n\
				<li>Programmer</li>\n\
				<li>Linguistics enthusiast</li>\n\
			</ul>\n\
            <h2>My links</h2>\n\
            <p><b>Bandcamp:</b> <a href=\"http://jummy.bandcamp.com\">&#x1F517; jummy</a></p>\n\
            <p><b>Discord:</b> jummy#9589</p>\n\
            <p><b>YouTube:</b> <a href=\"https://www.youtube.com/channel/UCynfXyMWcr876R6jJGkCjgA\">&#x1F517; jummy</a> and <a href=\"https://www.youtube.com/channel/UCY6X-L84Q6EzaoNORWKut9A\">&#x1F517; jummy's game corner</a></p>\n\
            <p><b>SoundCloud:</b> <a href=\"http://www.soundcloud.com/jummy0\">&#x1F517; jummy0</a></p>\n\
            <p><b>GitHub:</b> <a href=\"https://github.com/jummy0\">&#x1F517; jummy0</a></p>\n\
            <p><b>Twitter:</b> <a href=\"http://twitter.com/jummyzero\">&#x1F517; jummyzero</a></p>\n\
            <p><b>Speedrun.com:</b> <a href=\"https://www.speedrun.com/user/jummy0\">&#x1F517; jummy0</a></p>\n\
            <p><b>Twitch:</b> <a href=\"http://twitch.tv/jummy0\">&#x1F517; jummy0</a></p>\n\
            <p><b>Duolingo:</b> <a href=\"https://www.duolingo.com/profile/ProcessedCheese\">&#x1F517; ProcessedCheese</a></p>\n\
            <p>For more assorted content, <a href=\"/~jummy\">visit my subpage here</a>.</p>\n\
\n\
			<!--<h2>News</h2>-->\n\
					</main>\n\
		<footer>\n\
		<p class=\"text-center datetime\">\n\
		2023-05-10 02:35:49 UTC	</p>\n\
	<p class=\"text-center datetime\">\n\
		 ☺ 2018–2023 jummy 	</p>\n\
</footer>\n\
	</body>\n\
</html>\n\
";
const uint16_t sizeof_test_data = sizeof(test_data);