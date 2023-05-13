#include <stdint.h>

struct ProportionalFontData {
	uint8_t null_character[4];
	uint8_t space[2];
	uint8_t exclamation_mark[2];
	uint8_t double_quote[4];
};

const struct ProportionalFontData proportional_font_data = {
	.null_character = {3, 0b11111111, 0b11111111, 0b11111111},
	.space = {1, 0b00000000},
	.exclamation_mark = {1, 0b01011110},
	.double_quote = {3, 0b00000110, 0b00000000, 0b00000110}
};