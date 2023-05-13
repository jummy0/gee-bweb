#include <gb/gb.h>
#include <gb/hardware.h>
#include <stdint.h> //uintX_t
#include <stdio.h> //sprintf
#include <string.h> //memcpy

#include <res/font.h>
#include <res/hex.h>
#include <testdata.h>
#include <proportional_font.h>

#define _ensure_vblank() while (rLY < 145 && (rLCDC & LCDCF_ON)){}
#define _await_any_key() while (joypad()){} while (!joypad()){}
#define _safe_lcd_disable() _ensure_vblank(); rLCDC &= ~LCDCF_ON;
#define _screen_peek() rLCDC |= LCDCF_ON; _await_any_key(); _safe_lcd_disable();

enum Charsets {
	ENC_UNREAD = 0,
	ENC_UNDEFINED,
	ENC_DEFINED_UNKNOWN,
	ENC_UTF8,
	ENC_WINDOWS1252 // superset and alias of ISO-8859-1 and US-ASCII
} charset;

enum ActivableTag {
	// tags and types of tags that uniquely affect document flow/style. for element stack.
	// more generally, the effects of these tags can be "interrupted" by the screen filling up and halting rendering
	// thus we must track any ongoing effects across screen breaks.
	// inline tags with no visual effect can be excluded.
	TGROUP_BLOCK, // generic block element
	
	// specific tags with explicit support
	TAG_A,
	TAG_ABBR,
	TAG_AREA, // alt text
	TAG_B,
	TAG_BLOCKQUOTE,
	TAG_BUTTON,
	TAG_CODE,
	TAG_DD,
	TAG_DETAILS,
	TAG_FIELDSET, // border (necessary?)
	TAG_H1,
	TAG_H2,
	TAG_H3,
	TAG_H4,
	TAG_H5,
	TAG_H6,
	TAG_I,
	TAG_IMG, // alt text
	TAG_LI,
	TAG_METER, // inner text
	TAG_OL,
	TAG_PRE,
	// TAG_Q, // treat "<q>" and "</q>" as '"'.
	TAG_S,
	// TAG_SUB, // we can't do subscripts, so treat "<sub>" as "_(" and "</sub>" as ")".
	TAG_SUMMARY, // unsure if necessary depending on specific interaction with <details>
	//TAG_SUP, // we can't do superscripts, so treat "<sup>" as "^(" and "</sup>" as ")".
	TAG_TD,
	TAG_TEXTAREA, // inner text
	TAG_TH,
	TAG_U,
	TAG_UL,
	
	// unify similar tags
	TAG_ACRONYM  = TAG_ABBR,
	TAG_ADDRESS  = TAG_I,
	TAG_CITE     = TAG_I,
	TAG_DEL      = TAG_S,
	TAG_DIR      = TAG_UL,
	TAG_EM       = TAG_I,
	TAG_INS      = TAG_U,
	TAG_KBD      = TAG_CODE,
	TAG_MARK     = TAG_U,
	TAG_PROGRESS = TAG_METER,
	TAG_SAMP     = TAG_CODE,
	TAG_STRIKE   = TAG_S,
	TAG_STRONG   = TAG_B,
	TAG_TT       = TAG_CODE,
	TAG_VAR      = TAG_I,
	
	// tags we can treat as generic block elements
	TAG_ARTICLE    = TGROUP_BLOCK,
	TAG_ASIDE      = TGROUP_BLOCK,
	TAG_AUDIO      = TGROUP_BLOCK, // has fallback text
	TAG_CANVAS     = TGROUP_BLOCK, // has fallback text
	TAG_DIV        = TGROUP_BLOCK,
	TAG_DL         = TGROUP_BLOCK,
	TAG_DT         = TGROUP_BLOCK,
	TAG_FIGCAPTION = TGROUP_BLOCK,
	TAG_FIGURE     = TGROUP_BLOCK,
	TAG_FOOTER     = TGROUP_BLOCK,
	TAG_FRAMESET   = TGROUP_BLOCK,
	TAG_HEADER     = TGROUP_BLOCK,
	TAG_IFRAME     = TGROUP_BLOCK,
	TAG_LEGEND     = TGROUP_BLOCK,
	TAG_MAIN       = TGROUP_BLOCK,
	TAG_NAV        = TGROUP_BLOCK,
	TAG_NOFRAMES   = TGROUP_BLOCK,
	TAG_NOSCRIPT   = TGROUP_BLOCK,
	TAG_OBJECT     = TGROUP_BLOCK,
	TAG_P          = TGROUP_BLOCK,
	TAG_PICTURE    = TGROUP_BLOCK,
	TAG_SECTION    = TGROUP_BLOCK,
	TAG_TABLE      = TGROUP_BLOCK,
	TAG_TBODY      = TGROUP_BLOCK,
	TAG_TFOOT      = TGROUP_BLOCK,
	TAG_THEAD      = TGROUP_BLOCK,
	TAG_TR         = TGROUP_BLOCK,
	TAG_VIDEO      = TGROUP_BLOCK, // has fallback text
	
	TAG_MAX
};

enum Attribute {
	ATTR_
};

#define IS_HTML TRUE
#define MAX_ELEMENT_STACK 255

enum ActivableTag element_stack[MAX_ELEMENT_STACK] = {0}; // track any "active" tags to aid screen breaks

uint8_t is_whitespace(uint8_t character);
void clear_screen();

void main()
{
	rIE = 0;
	_safe_lcd_disable(); // make sure in vblank before lcd off
	rLCDC = LCDCF_OFF | LCDCF_BGON | LCDCF_OBJON | LCDCF_WINOFF | LCDCF_BG8000;
	BGP_REG = OBP0_REG = OBP1_REG = DMG_PALETTE(DMG_WHITE, DMG_LITE_GRAY, DMG_DARK_GRAY, DMG_BLACK);
	//memcpy(_VRAM8000, font_tiles, 16 * 256);
	memcpy(_VRAM8000, hex_tiles, 16 * 256);
	for (uint16_t i = 16; i > 3; i --) // clear the nintendo logo tilemap
	{
		_SCRN0[i + 32 * 9] = 0;
		_SCRN0[i + 32 * 8] = 0;
	}
	uint8_t tile_x = 0;
	uint8_t tile_y = 0;
	
	printf("%d", proportional_font_data.exclamation_mark);
	_screen_peek();
	
	for (uint8_t y = 0; y < 18; y ++)
	{
		for (uint8_t x = 0; x < 20; x ++)
		{
			_SCRN0[(y << 5) + x] = x + (y << 4) + (y << 2);
		}
	}
	const uint8_t A[3] = {0b01111000, 0b00100100, 0b01111110};
	uint8_t horiz_pixel_strip = 0;
	for (uint8_t j = 0; j < 3; j ++)
	{
		for (uint8_t i = 0; i < 8; i ++)
		{
			horiz_pixel_strip = ((A[j] >> i) & 1) << (7 - j & 7);
			*(_VRAM8000 + (i << 1)) |= horiz_pixel_strip; // bitplane 1
			*(_VRAM8000 + (i << 1) + 1) |= horiz_pixel_strip; // bitplane 2
			// consider reordering palette so normal black text uses only 1 bitplane
		}
	}
	
	_screen_peek();
	
	// testing shit
	/*
	sprintf(_SCRN0, "cpu=#%d,sgb=%d,gba=%d", _cpu, sgb_check(), _is_GBA);
	sprintf(_SCRN0 + 32, "%d %d", TAG_ABBR, TAG_ACRONYM);
	sprintf(_SCRN0 + 64, "1st data char\'%c\'%X", test_data[0], test_data[0]);
	sprintf(_SCRN0 + 96, "We are %sHTML!", IS_HTML ? "" : "not ");
	_screen_peek();
	clear_screen();
	*/
	{
		uint16_t i = 0;
		while (i < sizeof_test_data)
		{
			#if IS_HTML
				switch (test_data[i])
				{
				/*case '\n':
					tile_x = 0;
					tile_y += 2;
					break;*/
				case '<':
					do
					{
						i ++;
					} while (test_data[i] != '>');
					i ++;
					break;
				default:
					if (is_whitespace(test_data[i]))
					{
						do
						{
							i ++;
						} while (is_whitespace(test_data[i]));
						_SCRN0[tile_y * 32 + tile_x] = ' ';
						tile_x ++;
					}
					else
					{
						_SCRN0[tile_y * 32 + tile_x] = test_data[i];
						tile_x ++;
						i ++;
					}
				}
				if (tile_x >= 20)
				{
					tile_x = 0;
					tile_y += 2;
				}
				if (tile_y >= 17)
				{
					tile_y = 0;
					_SCRN0[32*17+19] = 0x85; // '...' indicate waiting for user input
					_screen_peek()
					clear_screen();
				}
			#else
					_SCRN0[tile_y * 32 + tile_x] = test_data[i];
					switch (test_data[i])
					{
					case '\n':
						tile_x = 0;
						tile_y ++;
						i ++;
						break;
					default:
						tile_x ++;
						i ++;
					}
					if (tile_x >= 20)
					{
						tile_x = 0;
						tile_y ++;
						
					}
					if (tile_y >= 17)
					{
						tile_y = 0;
						_SCRN0[32*17+19] = 0x85; // '...' indicate waiting for user input
						_screen_peek();
						clear_screen();
					}
			#endif
		}
	}
	rLCDC |= LCDCF_ON;
	_await_any_key();
	/*
	_safe_lcd_disable();
	clear_screen();
	memcpy(_SCRN0 + 32 * 5, "  CONGRATURATIONS!  ", 20);
	memcpy(_SCRN0 + 32 * 7, "All Pages displayed.", 20);
	memcpy(_SCRN0 + 32 * 9, "     THANK YOU!     ", 20);
	_SCRN0[32*10+3] = ',';
	memcpy(_SCRN0 + 32 * 11, "Youre great debugger", 20);
	rLCDC |= LCDCF_ON;
	*/
	rIE |= IEF_VBLANK; // must enable vblank interrupt before wait_vbl_done() else freeze
	// Done processing, yield CPU and wait for start of next frame
	while (1)
	{
		sprintf(_SCRN0 + 32 * 17 - 2, "%X", joypad());
		wait_vbl_done();
	}
}

uint8_t is_whitespace(uint8_t character)
{
	return character <= ' ';
}

void clear_screen()
{
	for (uint16_t i = 0; i < 32*32; i ++)
	{
		_SCRN0[i] = 0;
	}
}