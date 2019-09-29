; Disassembly of "mbctest.gb"
; This file was created with mgbdis v1.3 - Game Boy ROM disassembler by Matt Currie.
; https://github.com/mattcurrie/mgbdis

ld_long: MACRO
    IF STRLWR("\1") == "a" 
        ; ld a, [$ff40]
        db $FA
        dw \2
    ELSE 
        IF STRLWR("\2") == "a" 
            ; ld [$ff40], a
            db $EA
            dw \1
        ENDC
    ENDC
ENDM

INCLUDE "hardware.inc"
INCLUDE "bank_000.asm"
INCLUDE "bank_001.asm"
INCLUDE "bank_002.asm"
INCLUDE "bank_003.asm"
INCLUDE "bank_004.asm"
INCLUDE "bank_005.asm"
INCLUDE "bank_006.asm"
INCLUDE "bank_007.asm"
INCLUDE "bank_008.asm"
INCLUDE "bank_009.asm"
INCLUDE "bank_00a.asm"
INCLUDE "bank_00b.asm"
INCLUDE "bank_00c.asm"
INCLUDE "bank_00d.asm"
INCLUDE "bank_00e.asm"
INCLUDE "bank_00f.asm"
INCLUDE "bank_010.asm"
INCLUDE "bank_011.asm"
INCLUDE "bank_012.asm"
INCLUDE "bank_013.asm"
INCLUDE "bank_014.asm"
INCLUDE "bank_015.asm"
INCLUDE "bank_016.asm"
INCLUDE "bank_017.asm"
INCLUDE "bank_018.asm"
INCLUDE "bank_019.asm"
INCLUDE "bank_01a.asm"
INCLUDE "bank_01b.asm"
INCLUDE "bank_01c.asm"
INCLUDE "bank_01d.asm"
INCLUDE "bank_01e.asm"
INCLUDE "bank_01f.asm"
INCLUDE "bank_020.asm"
INCLUDE "bank_021.asm"
INCLUDE "bank_022.asm"
INCLUDE "bank_023.asm"
INCLUDE "bank_024.asm"
INCLUDE "bank_025.asm"
INCLUDE "bank_026.asm"
INCLUDE "bank_027.asm"
INCLUDE "bank_028.asm"
INCLUDE "bank_029.asm"
INCLUDE "bank_02a.asm"
INCLUDE "bank_02b.asm"
INCLUDE "bank_02c.asm"
INCLUDE "bank_02d.asm"
INCLUDE "bank_02e.asm"
INCLUDE "bank_02f.asm"
INCLUDE "bank_030.asm"
INCLUDE "bank_031.asm"
INCLUDE "bank_032.asm"
INCLUDE "bank_033.asm"
INCLUDE "bank_034.asm"
INCLUDE "bank_035.asm"
INCLUDE "bank_036.asm"
INCLUDE "bank_037.asm"
INCLUDE "bank_038.asm"
INCLUDE "bank_039.asm"
INCLUDE "bank_03a.asm"
INCLUDE "bank_03b.asm"
INCLUDE "bank_03c.asm"
INCLUDE "bank_03d.asm"
INCLUDE "bank_03e.asm"
INCLUDE "bank_03f.asm"
INCLUDE "bank_040.asm"
INCLUDE "bank_041.asm"
INCLUDE "bank_042.asm"
INCLUDE "bank_043.asm"
INCLUDE "bank_044.asm"
INCLUDE "bank_045.asm"
INCLUDE "bank_046.asm"
INCLUDE "bank_047.asm"
INCLUDE "bank_048.asm"
INCLUDE "bank_049.asm"
INCLUDE "bank_04a.asm"
INCLUDE "bank_04b.asm"
INCLUDE "bank_04c.asm"
INCLUDE "bank_04d.asm"
INCLUDE "bank_04e.asm"
INCLUDE "bank_04f.asm"
INCLUDE "bank_050.asm"
INCLUDE "bank_051.asm"
INCLUDE "bank_052.asm"
INCLUDE "bank_053.asm"
INCLUDE "bank_054.asm"
INCLUDE "bank_055.asm"
INCLUDE "bank_056.asm"
INCLUDE "bank_057.asm"
INCLUDE "bank_058.asm"
INCLUDE "bank_059.asm"
INCLUDE "bank_05a.asm"
INCLUDE "bank_05b.asm"
INCLUDE "bank_05c.asm"
INCLUDE "bank_05d.asm"
INCLUDE "bank_05e.asm"
INCLUDE "bank_05f.asm"
INCLUDE "bank_060.asm"
INCLUDE "bank_061.asm"
INCLUDE "bank_062.asm"
INCLUDE "bank_063.asm"
INCLUDE "bank_064.asm"
INCLUDE "bank_065.asm"
INCLUDE "bank_066.asm"
INCLUDE "bank_067.asm"
INCLUDE "bank_068.asm"
INCLUDE "bank_069.asm"
INCLUDE "bank_06a.asm"
INCLUDE "bank_06b.asm"
INCLUDE "bank_06c.asm"
INCLUDE "bank_06d.asm"
INCLUDE "bank_06e.asm"
INCLUDE "bank_06f.asm"
INCLUDE "bank_070.asm"
INCLUDE "bank_071.asm"
INCLUDE "bank_072.asm"
INCLUDE "bank_073.asm"
INCLUDE "bank_074.asm"
INCLUDE "bank_075.asm"
INCLUDE "bank_076.asm"
INCLUDE "bank_077.asm"
INCLUDE "bank_078.asm"
INCLUDE "bank_079.asm"
INCLUDE "bank_07a.asm"
INCLUDE "bank_07b.asm"
INCLUDE "bank_07c.asm"
INCLUDE "bank_07d.asm"
INCLUDE "bank_07e.asm"
INCLUDE "bank_07f.asm"
INCLUDE "bank_080.asm"
INCLUDE "bank_081.asm"
INCLUDE "bank_082.asm"
INCLUDE "bank_083.asm"
INCLUDE "bank_084.asm"
INCLUDE "bank_085.asm"
INCLUDE "bank_086.asm"
INCLUDE "bank_087.asm"
INCLUDE "bank_088.asm"
INCLUDE "bank_089.asm"
INCLUDE "bank_08a.asm"
INCLUDE "bank_08b.asm"
INCLUDE "bank_08c.asm"
INCLUDE "bank_08d.asm"
INCLUDE "bank_08e.asm"
INCLUDE "bank_08f.asm"
INCLUDE "bank_090.asm"
INCLUDE "bank_091.asm"
INCLUDE "bank_092.asm"
INCLUDE "bank_093.asm"
INCLUDE "bank_094.asm"
INCLUDE "bank_095.asm"
INCLUDE "bank_096.asm"
INCLUDE "bank_097.asm"
INCLUDE "bank_098.asm"
INCLUDE "bank_099.asm"
INCLUDE "bank_09a.asm"
INCLUDE "bank_09b.asm"
INCLUDE "bank_09c.asm"
INCLUDE "bank_09d.asm"
INCLUDE "bank_09e.asm"
INCLUDE "bank_09f.asm"
INCLUDE "bank_0a0.asm"
INCLUDE "bank_0a1.asm"
INCLUDE "bank_0a2.asm"
INCLUDE "bank_0a3.asm"
INCLUDE "bank_0a4.asm"
INCLUDE "bank_0a5.asm"
INCLUDE "bank_0a6.asm"
INCLUDE "bank_0a7.asm"
INCLUDE "bank_0a8.asm"
INCLUDE "bank_0a9.asm"
INCLUDE "bank_0aa.asm"
INCLUDE "bank_0ab.asm"
INCLUDE "bank_0ac.asm"
INCLUDE "bank_0ad.asm"
INCLUDE "bank_0ae.asm"
INCLUDE "bank_0af.asm"
INCLUDE "bank_0b0.asm"
INCLUDE "bank_0b1.asm"
INCLUDE "bank_0b2.asm"
INCLUDE "bank_0b3.asm"
INCLUDE "bank_0b4.asm"
INCLUDE "bank_0b5.asm"
INCLUDE "bank_0b6.asm"
INCLUDE "bank_0b7.asm"
INCLUDE "bank_0b8.asm"
INCLUDE "bank_0b9.asm"
INCLUDE "bank_0ba.asm"
INCLUDE "bank_0bb.asm"
INCLUDE "bank_0bc.asm"
INCLUDE "bank_0bd.asm"
INCLUDE "bank_0be.asm"
INCLUDE "bank_0bf.asm"
INCLUDE "bank_0c0.asm"
INCLUDE "bank_0c1.asm"
INCLUDE "bank_0c2.asm"
INCLUDE "bank_0c3.asm"
INCLUDE "bank_0c4.asm"
INCLUDE "bank_0c5.asm"
INCLUDE "bank_0c6.asm"
INCLUDE "bank_0c7.asm"
INCLUDE "bank_0c8.asm"
INCLUDE "bank_0c9.asm"
INCLUDE "bank_0ca.asm"
INCLUDE "bank_0cb.asm"
INCLUDE "bank_0cc.asm"
INCLUDE "bank_0cd.asm"
INCLUDE "bank_0ce.asm"
INCLUDE "bank_0cf.asm"
INCLUDE "bank_0d0.asm"
INCLUDE "bank_0d1.asm"
INCLUDE "bank_0d2.asm"
INCLUDE "bank_0d3.asm"
INCLUDE "bank_0d4.asm"
INCLUDE "bank_0d5.asm"
INCLUDE "bank_0d6.asm"
INCLUDE "bank_0d7.asm"
INCLUDE "bank_0d8.asm"
INCLUDE "bank_0d9.asm"
INCLUDE "bank_0da.asm"
INCLUDE "bank_0db.asm"
INCLUDE "bank_0dc.asm"
INCLUDE "bank_0dd.asm"
INCLUDE "bank_0de.asm"
INCLUDE "bank_0df.asm"
INCLUDE "bank_0e0.asm"
INCLUDE "bank_0e1.asm"
INCLUDE "bank_0e2.asm"
INCLUDE "bank_0e3.asm"
INCLUDE "bank_0e4.asm"
INCLUDE "bank_0e5.asm"
INCLUDE "bank_0e6.asm"
INCLUDE "bank_0e7.asm"
INCLUDE "bank_0e8.asm"
INCLUDE "bank_0e9.asm"
INCLUDE "bank_0ea.asm"
INCLUDE "bank_0eb.asm"
INCLUDE "bank_0ec.asm"
INCLUDE "bank_0ed.asm"
INCLUDE "bank_0ee.asm"
INCLUDE "bank_0ef.asm"
INCLUDE "bank_0f0.asm"
INCLUDE "bank_0f1.asm"
INCLUDE "bank_0f2.asm"
INCLUDE "bank_0f3.asm"
INCLUDE "bank_0f4.asm"
INCLUDE "bank_0f5.asm"
INCLUDE "bank_0f6.asm"
INCLUDE "bank_0f7.asm"
INCLUDE "bank_0f8.asm"
INCLUDE "bank_0f9.asm"
INCLUDE "bank_0fa.asm"
INCLUDE "bank_0fb.asm"
INCLUDE "bank_0fc.asm"
INCLUDE "bank_0fd.asm"
INCLUDE "bank_0fe.asm"