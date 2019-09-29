;MBC Test ROM V1.0
;Tests MBC chips
;Created by HyperHacker on Dec 30 2003, designed for tniASM V0.3


; DEFINES
tilemap: EQU $9800	;Tilemap in VRAM
rombank: EQU $2000	;ROM Bank
lcdctrl: EQU $FF40	;LCD Control register
lcdyloc: EQU $FF44	;LCD Yloc register
bgpal: EQU $FF47	;BG Palette data
intflag: EQU $FF0F	;Interrupt flag
intenable: EQU $FFFF	;Interrupt enable

;CODE
CPU GBZ80
FNAME "mbctest.gb"

FORG $100
ORG $100
nop
jp start

;Nintendo logo
DB $CE, $ED, $66, $66, $CC, $0D, $00, $0B 
DB $03, $73, $00, $83, $00, $0C, $00, $0D 
DB $00, $08, $11, $1F, $88, $89, $00, $0E 
DB $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99 
DB $BB, $BB, $67, $63, $6E, $0E, $EC, $CC 
DB $DD, $DC, $99, $9F, $BB, $B9, $33, $3E

;Title
DB "MBC TEST V1.0",0,0

DB $00 ;GB Color (no)
DB "HH" ;Licensee
DB $00 ;Super GB (no)
DB $11 ;ROM, MBC3, Clock, RAM, Battery (cart type)
DB 7 ;256 ROM Banks (4MB)
DB 0 ;No RAM
DB 1 ;Non-Japanese (MADE IN CANADA!)
DB $33 ;Old Licensee: See new licensee
DB 0 ;Version
DB $D4 ;Header Checksum
DB 0,0 ;ROM Checksum (not important, and due to the dynamic nature of this ROM I'm leaving it)

start: ld sp,$DFFF
call soundoff ;Save the batteries!
call screenoff

ld de,$8000 ;Write to $8000
ld hl,$3000 ;Copy from $3000
ld bc,$270  ;Copy $270 bytes
call copybinary ;Copy graphics to memory

ld hl,tilemap ;Ready to clear tilemap
push hl ;Gonna need it again
ld bc,$300 ;Only need to clear parts we'll be using
call clearmem

pop de ;ow write "TESTING BANK" text
ld hl,$3270
ld bc,13
call copybinary

;Set palettes
ld a,%00011110 ;3, 4, 2, 1 (higher=darker)
ld [bgpal],a

;Draw grid Y
ld hl,$9821
ld c,16
ld a,1
grid1: ldi [hl],a
inc a
dec c
jr nz,grid1

;Draw grid X
ld hl,$9840
ld c,16
ld de,$20
ld a,1
grid2: ld [hl],a
add hl,de ;Up by $20
inc a
dec c
jr nz,grid2

call screenon ;Turn screen back on

;Test the banks
ld a,1 ;Starting bank (you can change this but the display will still start at 0,0 in the grid)
ld hl,$4000 ;Address to check in each bank (changing this will cause all checks to fail)
ld de,$9841 ;Address to start writing grid (yes I know it should be 9842 but... well try it and see ;)
ld c,$10 ;How much to add to DE to get to the next Y position of the grid (don't change)
testloop: rst $10 ;Bankswitch

push af
push hl
ld hl,$980D
call showhex ;Display the bank # we're testing
pop hl
pop af

ld b,a ;Bank to B
ld a,[hl] ;Get data
cp b ;Check if it's the bank #
jr z,pass ;Goto pass if true

fail: 
push af
rst $18 ;Wait for VBlank
pop af

ld a,b
push af
ld a,$26 ;Fail grid tile
jr write

pass: push af
rst $18
pop af
ld a,b
push af
ld a,$25 ;Pass grid tile

write: ld [de],a ;Write the tile
inc de
pop af ;Get bank # back
push af ;Save it again
and $F ;Cut off the high bits
cp 0 ;See if we need to reset DE yet
jr nz, nooverflow

;Update DE
ld b,0
push de ;Swap DE/HL
push hl
pop de
pop hl

add hl,bc ;Add $10 to DE (the $10 being in C) to get to the next Y position

push de ;Swap back
push hl
pop de
pop hl

nooverflow: pop af ;Restore A
cp $FF
jr z,end ;If we've tested all the banks, exit the loop
inc a ;Next bank
jp testloop

end: ld de,tilemap
ld hl,$3270+13
ld bc,15
call copybinary ;Write "TEST COMPLETE" text
ld bc,$FFFF ;Delay several seconds and reboot
ld a,7
loop: dec c
jr nz, loop
dec b
jr nz, loop
dec a
jr nz, loop
rst 0

;Display numbers in hex (A=number, HL=Dest)
showhex: push af
rst $18
pop af
push af
swap a
and $F
inc a
ldi [hl],a
pop af
and $F
inc a
ldi [hl],a
ret


;Some functions we'll be using
;Copies binary data - HL=Source, DE=Destination, BC=Count
copybinary: inc c
inc b
.loop: ldi a,[hl]
ld [de],a
inc de
dec c
;Check if bc=0
jr nz, copybinary.loop
dec b
jr nz, copybinary.loop
ret

;Screen Off
screenoff: ld a,[lcdctrl]
bit 7,a
ret z
xor a
ld [intflag],a
ld a,[intenable]
ld b,a
res 0,a
ld [intenable],a
rst $18 ;WaitVBlnk
ld a,[lcdctrl]
and $7F
ld [lcdctrl],a
xor a
ld [intflag],a
ld a,b
ld [intenable],a
ret

;Screen On
screenon: ld a,[lcdctrl]
set 7,a
ld [lcdctrl],a
ret

;Clear Memory - HL = Destination, BC = Count
clearmem: xor a
inc c
inc b
.loop: ldi [hl],a
dec c
jr nz,clearmem.loop
dec b
jr nz,clearmem.loop
ret

;Wait for VBlank
waitvblnk: ccf
.loop: ld a,[lcdyloc]
cp $90 ;Exit if >= 90
jr c,waitvblnk.loop
ret

;Shut off sound
soundoff: xor a
ld [$FF26],a
ret

;Set up references in the reserved ROM area
FORG 0
jp $100

FORG $10
romswitch: ;ld [memrombank],a
ld [rombank],a
ret

FORG $18
jp waitvblnk

;Graphics file
FORG $3000
INCBIN "graphics.bin"
;Text
FORG $3270
db $1E, $F, $1D, $1E, $13, $18, $11, $0, $C, $B, $18, $15, $0 ;"TESTING BANK "
db $1E, $F, $1D, $1E, $0, $D, $19, $17, $1A, $16, $F, $1E, $F, $0, $0 ;"TEST COMPLETE"


;Here's how the testing actually works
;At the start of each bank is its bank number
;If it doesn't match, that bank was not accessed properly
;You can comment out any of them if you want to trim down the ROM size or cause a certain bank to fail for some reason
;Also note that the last bank will only be one byte, if this is an issue you can simply pad it.
FORG $4000
db 1
FORG $8000
db 2
FORG $C000
db 3
FORG $10000
db 4
FORG $14000
db 5
FORG $18000
db 6
FORG $1C000
db 7
FORG $20000
db 8
FORG $24000
db 9
FORG $28000
db 10
FORG $2C000
db 11
FORG $30000
db 12
FORG $34000
db 13
FORG $38000
db 14
FORG $3C000
db 15
FORG $40000
db 16
FORG $44000
db 17
FORG $48000
db 18
FORG $4C000
db 19
FORG $50000
db 20
FORG $54000
db 21
FORG $58000
db 22
FORG $5C000
db 23
FORG $60000
db 24
FORG $64000
db 25
FORG $68000
db 26
FORG $6C000
db 27
FORG $70000
db 28
FORG $74000
db 29
FORG $78000
db 30
FORG $7C000
db 31
FORG $80000
db 32
FORG $84000
db 33
FORG $88000
db 34
FORG $8C000
db 35
FORG $90000
db 36
FORG $94000
db 37
FORG $98000
db 38
FORG $9C000
db 39
FORG $A0000
db 40
FORG $A4000
db 41
FORG $A8000
db 42
FORG $AC000
db 43
FORG $B0000
db 44
FORG $B4000
db 45
FORG $B8000
db 46
FORG $BC000
db 47
FORG $C0000
db 48
FORG $C4000
db 49
FORG $C8000
db 50
FORG $CC000
db 51
FORG $D0000
db 52
FORG $D4000
db 53
FORG $D8000
db 54
FORG $DC000
db 55
FORG $E0000
db 56
FORG $E4000
db 57
FORG $E8000
db 58
FORG $EC000
db 59
FORG $F0000
db 60
FORG $F4000
db 61
FORG $F8000
db 62
FORG $FC000
db 63
FORG $100000
db 64
FORG $104000
db 65
FORG $108000
db 66
FORG $10C000
db 67
FORG $110000
db 68
FORG $114000
db 69
FORG $118000
db 70
FORG $11C000
db 71
FORG $120000
db 72
FORG $124000
db 73
FORG $128000
db 74
FORG $12C000
db 75
FORG $130000
db 76
FORG $134000
db 77
FORG $138000
db 78
FORG $13C000
db 79
FORG $140000
db 80
FORG $144000
db 81
FORG $148000
db 82
FORG $14C000
db 83
FORG $150000
db 84
FORG $154000
db 85
FORG $158000
db 86
FORG $15C000
db 87
FORG $160000
db 88
FORG $164000
db 89
FORG $168000
db 90
FORG $16C000
db 91
FORG $170000
db 92
FORG $174000
db 93
FORG $178000
db 94
FORG $17C000
db 95
FORG $180000
db 96
FORG $184000
db 97
FORG $188000
db 98
FORG $18C000
db 99
FORG $190000
db 100
FORG $194000
db 101
FORG $198000
db 102
FORG $19C000
db 103
FORG $1A0000
db 104
FORG $1A4000
db 105
FORG $1A8000
db 106
FORG $1AC000
db 107
FORG $1B0000
db 108
FORG $1B4000
db 109
FORG $1B8000
db 110
FORG $1BC000
db 111
FORG $1C0000
db 112
FORG $1C4000
db 113
FORG $1C8000
db 114
FORG $1CC000
db 115
FORG $1D0000
db 116
FORG $1D4000
db 117
FORG $1D8000
db 118
FORG $1DC000
db 119
FORG $1E0000
db 120
FORG $1E4000
db 121
FORG $1E8000
db 122
FORG $1EC000
db 123
FORG $1F0000
db 124
FORG $1F4000
db 125
FORG $1F8000
db 126
FORG $1FC000
db 127
FORG $200000
db 128
FORG $204000
db 129
FORG $208000
db 130
FORG $20C000
db 131
FORG $210000
db 132
FORG $214000
db 133
FORG $218000
db 134
FORG $21C000
db 135
FORG $220000
db 136
FORG $224000
db 137
FORG $228000
db 138
FORG $22C000
db 139
FORG $230000
db 140
FORG $234000
db 141
FORG $238000
db 142
FORG $23C000
db 143
FORG $240000
db 144
FORG $244000
db 145
FORG $248000
db 146
FORG $24C000
db 147
FORG $250000
db 148
FORG $254000
db 149
FORG $258000
db 150
FORG $25C000
db 151
FORG $260000
db 152
FORG $264000
db 153
FORG $268000
db 154
FORG $26C000
db 155
FORG $270000
db 156
FORG $274000
db 157
FORG $278000
db 158
FORG $27C000
db 159
FORG $280000
db 160
FORG $284000
db 161
FORG $288000
db 162
FORG $28C000
db 163
FORG $290000
db 164
FORG $294000
db 165
FORG $298000
db 166
FORG $29C000
db 167
FORG $2A0000
db 168
FORG $2A4000
db 169
FORG $2A8000
db 170
FORG $2AC000
db 171
FORG $2B0000
db 172
FORG $2B4000
db 173
FORG $2B8000
db 174
FORG $2BC000
db 175
FORG $2C0000
db 176
FORG $2C4000
db 177
FORG $2C8000
db 178
FORG $2CC000
db 179
FORG $2D0000
db 180
FORG $2D4000
db 181
FORG $2D8000
db 182
FORG $2DC000
db 183
FORG $2E0000
db 184
FORG $2E4000
db 185
FORG $2E8000
db 186
FORG $2EC000
db 187
FORG $2F0000
db 188
FORG $2F4000
db 189
FORG $2F8000
db 190
FORG $2FC000
db 191
FORG $300000
db 192
FORG $304000
db 193
FORG $308000
db 194
FORG $30C000
db 195
FORG $310000
db 196
FORG $314000
db 197
FORG $318000
db 198
FORG $31C000
db 199
FORG $320000
db 200
FORG $324000
db 201
FORG $328000
db 202
FORG $32C000
db 203
FORG $330000
db 204
FORG $334000
db 205
FORG $338000
db 206
FORG $33C000
db 207
FORG $340000
db 208
FORG $344000
db 209
FORG $348000
db 210
FORG $34C000
db 211
FORG $350000
db 212
FORG $354000
db 213
FORG $358000
db 214
FORG $35C000
db 215
FORG $360000
db 216
FORG $364000
db 217
FORG $368000
db 218
FORG $36C000
db 219
FORG $370000
db 220
FORG $374000
db 221
FORG $378000
db 222
FORG $37C000
db 223
FORG $380000
db 224
FORG $384000
db 225
FORG $388000
db 226
FORG $38C000
db 227
FORG $390000
db 228
FORG $394000
db 229
FORG $398000
db 230
FORG $39C000
db 231
FORG $3A0000
db 232
FORG $3A4000
db 233
FORG $3A8000
db 234
FORG $3AC000
db 235
FORG $3B0000
db 236
FORG $3B4000
db 237
FORG $3B8000
db 238
FORG $3BC000
db 239
FORG $3C0000
db 240
FORG $3C4000
db 241
FORG $3C8000
db 242
FORG $3CC000
db 243
FORG $3D0000
db 244
FORG $3D4000
db 245
FORG $3D8000
db 246
FORG $3DC000
db 247
FORG $3E0000
db 248
FORG $3E4000
db 249
FORG $3E8000
db 250
FORG $3EC000
db 251
FORG $3F0000
db 252
FORG $3F4000
db 253
FORG $3F8000
db 254
FORG $3FC000
db 255