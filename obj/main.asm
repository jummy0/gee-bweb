;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _memcpy
	.globl _sprintf
	.globl _printf
	.globl _wait_vbl_done
	.globl _joypad
	.globl _element_stack
	.globl _charset
	.globl _is_whitespace
	.globl _clear_screen
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_charset::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_element_stack::
	.ds 255
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
;src/main.c:128: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-12
;src/main.c:130: rIE = 0;
	xor	a, a
	ldh	(_IE_REG + 0), a
;src/main.c:131: _safe_lcd_disable(); // make sure in vblank before lcd off
00102$:
	ldh	a, (_LY_REG + 0)
	sub	a, #0x91
	jr	NC, 00104$
	ldh	a, (_LCDC_REG + 0)
	rlca
	jr	C, 00102$
00104$:
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x7f
	ldh	(_LCDC_REG + 0), a
;src/main.c:132: rLCDC = LCDCF_OFF | LCDCF_BGON | LCDCF_OBJON | LCDCF_WINOFF | LCDCF_BG8000;
	ld	a, #0x13
	ldh	(_LCDC_REG + 0), a
;src/main.c:133: BGP_REG = OBP0_REG = OBP1_REG = DMG_PALETTE(DMG_WHITE, DMG_LITE_GRAY, DMG_DARK_GRAY, DMG_BLACK);
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/main.c:135: memcpy(_VRAM8000, hex_tiles, 16 * 256);
	ld	de, #0x1000
	push	de
	ld	bc, #_hex_tiles
	ld	de, #__VRAM8000
	call	_memcpy
;src/main.c:136: for (uint16_t i = 16; i > 3; i --) // clear the nintendo logo tilemap
	ld	bc, #0x0010
00169$:
	ld	e, c
	ld	d, b
	ld	a, #0x03
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00105$
;src/main.c:138: _SCRN0[i + 32 * 9] = 0;
	ld	hl, #0x0120
	add	hl, de
	push	de
	ld	de, #__SCRN0
	add	hl, de
	pop	de
	ld	(hl), #0x00
;src/main.c:139: _SCRN0[i + 32 * 8] = 0;
	ld	hl, #0x0100
	add	hl, de
	ld	de, #__SCRN0
	add	hl, de
	ld	(hl), #0x00
;src/main.c:136: for (uint16_t i = 16; i > 3; i --) // clear the nintendo logo tilemap
	dec	bc
	jr	00169$
00105$:
;src/main.c:141: uint8_t tile_x = 0;
	ldhl	sp,	#9
	ld	(hl), #0x00
;src/main.c:142: uint8_t tile_y = 0;
	ldhl	sp,	#3
	ld	(hl), #0x00
;src/main.c:144: printf("%d", proportional_font_data);
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;src/main.c:145: _screen_peek();
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
00106$:
	call	_joypad
	or	a, a
	jr	NZ, 00106$
00109$:
	call	_joypad
	or	a, a
	jr	Z, 00109$
00113$:
	ldh	a, (_LY_REG + 0)
	sub	a, #0x91
	jr	NC, 00115$
	ldh	a, (_LCDC_REG + 0)
	rlca
	jr	C, 00113$
00115$:
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x7f
	ldh	(_LCDC_REG + 0), a
;src/main.c:147: for (uint8_t y = 0; y < 18; y ++)
	ldhl	sp,	#10
	ld	(hl), #0x00
00175$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x12
	jr	NC, 00117$
;src/main.c:149: for (uint8_t x = 0; x < 20; x ++)
	inc	hl
	ld	(hl), #0x00
00172$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x14
	jr	NC, 00176$
;src/main.c:151: _SCRN0[(y << 5) + x] = x + (y << 4) + (y << 2);
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x05
00384$:
	ldhl	sp,	#7
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00384$
	ldhl	sp,	#11
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#7
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	bc,#__SCRN0
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	swap	a
	and	a, #0xf0
	ld	d, (hl)
	add	a, d
	sla	e
	sla	e
	add	a, e
	ld	(bc), a
;src/main.c:149: for (uint8_t x = 0; x < 20; x ++)
	inc	(hl)
	jr	00172$
00176$:
;src/main.c:147: for (uint8_t y = 0; y < 18; y ++)
	ldhl	sp,	#10
	inc	(hl)
	jr	00175$
00117$:
;src/main.c:154: const uint8_t A[3] = {0b01111000, 0b00100100, 0b01111110};
	ldhl	sp,	#0
	ld	a, #0x78
	ld	(hl+), a
	ld	a, #0x24
	ld	(hl+), a
	ld	(hl), #0x7e
;src/main.c:156: for (uint8_t j = 0; j < 3; j ++)
	ld	c, #0x00
00181$:
	ld	a, c
	sub	a, #0x03
	jp	NC, 00119$
;src/main.c:158: for (uint8_t i = 0; i < 8; i ++)
	push	hl
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ld	l, c
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	b, #0x00
00178$:
	ld	a, b
	sub	a, #0x08
	jr	NC, 00182$
;src/main.c:160: horiz_pixel_strip = ((A[j] >> i) & 1) << (7 - j & 7);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	inc	a
	jr	00386$
00385$:
	srl	l
00386$:
	dec	a
	jr	NZ, 00385$
	ld	a, l
	and	a, #0x01
	ld	e, a
	ld	d, c
	ld	a, #0x07
	sub	a, d
	and	a, #0x07
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	l
	jr	00388$
00387$:
	sla	e
00388$:
	dec	l
	jr	NZ,00387$
	ldhl	sp,	#6
	ld	(hl), e
;src/main.c:161: *(_VRAM8000 + (i << 1)) |= horiz_pixel_strip; // bitplane 1
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl, #__VRAM8000
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, b
	add	a, a
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	hl, #__VRAM8000
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	or	a, (hl)
	inc	hl
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;src/main.c:162: *(_VRAM8000 + (i << 1) + 1) |= horiz_pixel_strip; // bitplane 2
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	inc	de
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	or	a, (hl)
	ld	(de), a
;src/main.c:158: for (uint8_t i = 0; i < 8; i ++)
	inc	b
	jr	00178$
00182$:
;src/main.c:156: for (uint8_t j = 0; j < 3; j ++)
	inc	c
	jp	00181$
00119$:
;src/main.c:167: _screen_peek();
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
00120$:
	call	_joypad
	or	a, a
	jr	NZ, 00120$
00123$:
	call	_joypad
	or	a, a
	jr	Z, 00123$
00127$:
	ldh	a, (_LY_REG + 0)
	sub	a, #0x91
	jr	NC, 00129$
	ldh	a, (_LCDC_REG + 0)
	rlca
	jr	C, 00127$
00129$:
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x7f
	ldh	(_LCDC_REG + 0), a
;src/main.c:179: uint16_t i = 0;
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
;src/main.c:180: while (i < sizeof_test_data)
	ld	bc, #_test_data+0
00156$:
	ld	hl, #_sizeof_test_data
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jp	NC, 00158$
;src/main.c:183: switch (test_data[i])
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	sub	a, #0x3c
	jr	NZ, 00134$
;src/main.c:190: do
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00131$:
;src/main.c:192: i ++;
	inc	de
;src/main.c:193: } while (test_data[i] != '>');
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, (hl)
	sub	a, #0x3e
	jr	NZ, 00131$
;src/main.c:194: i ++;
	inc	de
	ldhl	sp,	#10
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/main.c:195: break;
	jr	00141$
;src/main.c:196: default:
00134$:
;src/main.c:197: if (is_whitespace(test_data[i]))
	push	bc
	ld	a, l
	call	_is_whitespace
	ldhl	sp,	#8
	ld	(hl), a
	pop	bc
;src/main.c:203: _SCRN0[tile_y * 32 + tile_x] = ' ';
	ldhl	sp,	#3
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#9
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
;src/main.c:204: tile_x ++;
	xor	a, a
	ld	(hl+), a
	inc	(hl)
;src/main.c:203: _SCRN0[tile_y * 32 + tile_x] = ' ';
	dec	hl
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #__SCRN0
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
;src/main.c:197: if (is_whitespace(test_data[i]))
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00139$
;src/main.c:199: do
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00135$:
;src/main.c:201: i ++;
	inc	de
;src/main.c:202: } while (is_whitespace(test_data[i]));
	ld	l, e
	ld	h, d
	add	hl, bc
	ld	l, (hl)
;	spillPairReg hl
	push	bc
	push	de
	ld	a, l
	call	_is_whitespace
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00135$
;src/main.c:203: _SCRN0[tile_y * 32 + tile_x] = ' ';
	ldhl	sp,	#10
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#7
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x20
;src/main.c:204: tile_x ++;
	jr	00141$
00139$:
;src/main.c:208: _SCRN0[tile_y * 32 + tile_x] = test_data[i];
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;src/main.c:209: tile_x ++;
;src/main.c:210: i ++;
	ldhl	sp,	#10
	inc	(hl)
	jr	NZ, 00396$
	inc	hl
	inc	(hl)
00396$:
;src/main.c:212: }
00141$:
;src/main.c:213: if (tile_x >= 20)
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x14
	jr	C, 00143$
;src/main.c:215: tile_x = 0;
	ld	(hl), #0x00
;src/main.c:216: tile_y += 2;
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
00143$:
;src/main.c:218: if (tile_y >= 17)
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x11
	jp	C, 00156$
;src/main.c:220: tile_y = 0;
	ld	(hl), #0x00
;src/main.c:221: _SCRN0[32*17+19] = 0x85; // '...' indicate waiting for user input
	ld	hl, #(__SCRN0 + 563)
	ld	(hl), #0x85
;src/main.c:222: _screen_peek()
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
00144$:
	call	_joypad
	or	a, a
	jr	NZ, 00144$
00147$:
	call	_joypad
	or	a, a
	jr	Z, 00147$
00151$:
	ldh	a, (_LY_REG + 0)
	sub	a, #0x91
	jr	NC, 00153$
	ldh	a, (_LCDC_REG + 0)
	rlca
	jr	C, 00151$
00153$:
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x7f
	ldh	(_LCDC_REG + 0), a
;src/main.c:223: clear_screen();
	push	bc
	call	_clear_screen
	pop	bc
	jp	00156$
00158$:
;src/main.c:254: rLCDC |= LCDCF_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:255: _await_any_key();
00159$:
	call	_joypad
	or	a, a
	jr	NZ, 00159$
00162$:
	call	_joypad
	or	a, a
	jr	Z, 00162$
;src/main.c:266: rIE |= IEF_VBLANK; // must enable vblank interrupt before wait_vbl_done() else freeze
	ldh	a, (_IE_REG + 0)
	or	a, #0x01
	ldh	(_IE_REG + 0), a
;src/main.c:268: while (1)
00166$:
;src/main.c:270: sprintf(_SCRN0 + 32 * 17 - 2, "%X", joypad());
	call	_joypad
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	ld	de, #(__SCRN0 + 542)
	push	de
	call	_sprintf
	add	sp, #6
;src/main.c:271: wait_vbl_done();
	call	_wait_vbl_done
	jr	00166$
;src/main.c:273: }
	add	sp, #12
	ret
___str_0:
	.ascii "%d"
	.db 0x00
___str_1:
	.ascii "%X"
	.db 0x00
;src/main.c:275: uint8_t is_whitespace(uint8_t character)
;	---------------------------------
; Function is_whitespace
; ---------------------------------
_is_whitespace::
	ld	c, a
;src/main.c:277: return character <= ' ';
	ld	a, #0x20
	sub	a, c
	ld	a, #0x00
	rla
	xor	a, #0x01
;src/main.c:278: }
	ret
;src/main.c:280: void clear_screen()
;	---------------------------------
; Function clear_screen
; ---------------------------------
_clear_screen::
;src/main.c:282: for (uint16_t i = 0; i < 32*32; i ++)
	ld	bc, #0x0000
00103$:
	ld	a, b
	sub	a, #0x04
	ret	NC
;src/main.c:284: _SCRN0[i] = 0;
	ld	hl, #__SCRN0
	add	hl, bc
	ld	(hl), #0x00
;src/main.c:282: for (uint16_t i = 0; i < 32*32; i ++)
	inc	bc
;src/main.c:286: }
	jr	00103$
	.area _CODE
	.area _INITIALIZER
__xinit__element_stack:
	.db #0x00	; 0
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.area _CABS (ABS)
