_Wait:
;Led_Blinking.c,11 :: 		void Wait() {
;Led_Blinking.c,12 :: 		Delay_ms(1000);
LUI	R24, 406
ORI	R24, R24, 59050
L_Wait0:
ADDIU	R24, R24, -1
BNE	R24, R0, L_Wait0
NOP	
;Led_Blinking.c,13 :: 		}
L_end_Wait:
JR	RA
NOP	
; end of _Wait
_main:
;Led_Blinking.c,15 :: 		void main() {
;Led_Blinking.c,17 :: 		AD1PCFG = 0xFFFF;       // configure AN pins as digital
ORI	R2, R0, 65535
SW	R2, Offset(AD1PCFG+0)(GP)
;Led_Blinking.c,19 :: 		DDPCON.JTAGEN = 0;      //jtag disable
LBU	R2, Offset(DDPCON+0)(GP)
INS	R2, R0, 3, 1
SB	R2, Offset(DDPCON+0)(GP)
;Led_Blinking.c,21 :: 		TRISA = 0x0000;         // port A is output
SW	R0, Offset(TRISA+0)(GP)
;Led_Blinking.c,22 :: 		TRISE = 0x0000;         // port E is output
SW	R0, Offset(TRISE+0)(GP)
;Led_Blinking.c,24 :: 		LATA  = 0Xffff;         // turn OFF the PORTA leds
ORI	R2, R0, 65535
SW	R2, Offset(LATA+0)(GP)
;Led_Blinking.c,25 :: 		LATE  = 0Xffff;         // turn OFF the PORTE led ( single green LED on PIC32 Beti)
ORI	R2, R0, 65535
SW	R2, Offset(LATE+0)(GP)
;Led_Blinking.c,34 :: 		while (1) {
L_main2:
;Led_Blinking.c,36 :: 		LATA  = 0Xffff;                          // turn OFF the PORTE leds
ORI	R2, R0, 65535
SW	R2, Offset(LATA+0)(GP)
;Led_Blinking.c,37 :: 		LATE  = 0Xffff;                          // turn OFF the PORTE leds
ORI	R2, R0, 65535
SW	R2, Offset(LATE+0)(GP)
;Led_Blinking.c,38 :: 		Wait();                                  // 1s pause
JAL	_Wait+0
NOP	
;Led_Blinking.c,40 :: 		LATA  = 0X0000;                          // turn OFF the PORTE leds
SW	R0, Offset(LATA+0)(GP)
;Led_Blinking.c,41 :: 		LATE  = 0X0000;                          // turn OFF the PORTE leds
SW	R0, Offset(LATE+0)(GP)
;Led_Blinking.c,42 :: 		Wait();                                  // 1s pause
JAL	_Wait+0
NOP	
;Led_Blinking.c,44 :: 		}//while
J	L_main2
NOP	
;Led_Blinking.c,46 :: 		}//main
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main
