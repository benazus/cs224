#line 1 "E:/Users/Hamzeh/Dropbox/Academic/Courses/Computer Organization_Bilkent/2015 Spring/LAB9/Example Projects/LED_Blinking/Led_Blinking.c"
#line 11 "E:/Users/Hamzeh/Dropbox/Academic/Courses/Computer Organization_Bilkent/2015 Spring/LAB9/Example Projects/LED_Blinking/Led_Blinking.c"
void Wait() {
 Delay_ms(1000);
}

void main() {

 AD1PCFG = 0xFFFF;

 DDPCON.JTAGEN = 0;

 TRISA = 0x0000;
 TRISE = 0x0000;

 LATA = 0Xffff;
 LATE = 0Xffff;
#line 34 "E:/Users/Hamzeh/Dropbox/Academic/Courses/Computer Organization_Bilkent/2015 Spring/LAB9/Example Projects/LED_Blinking/Led_Blinking.c"
 while (1) {

 LATA = 0Xffff;
 LATE = 0Xffff;
 Wait();

 LATA = 0X0000;
 LATE = 0X0000;
 Wait();

 }

}
