#line 1 "E:/Users/Hamzeh/Dropbox/Academic/Courses/Computer Organization_Bilkent/2015 Spring/LAB9/Example Projects/Push_button/Push_button.c"
#line 17 "E:/Users/Hamzeh/Dropbox/Academic/Courses/Computer Organization_Bilkent/2015 Spring/LAB9/Example Projects/Push_button/Push_button.c"
void Wait() {
 Delay_ms(1000);
}

void main() {

 AD1PCFG = 0xFFFF;

 DDPCON.JTAGEN = 0;

 TRISA = 0x0000;
 TRISE = 0XFFFF;

 LATA = 0Xffff;
 LATE = 0X0000;


 LATA=0xffff;
 Wait();
 LATA=0x0000;
 Wait();


 while(1)
 {
 portA = portE;
 }

}
