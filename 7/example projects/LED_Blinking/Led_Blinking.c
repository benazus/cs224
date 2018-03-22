
/*
Attention!
Configuration for LED blinking project :

Connect portA to LEDs
Jumpers of portA are : 5V, pull up ( both of the to the left side )

*/

void Wait() {
  Delay_ms(1000);
}

void main() {
  
  AD1PCFG = 0xFFFF;       // configure AN pins as digital
  
  DDPCON.JTAGEN = 0;      //jtag disable
  
  TRISA = 0x0000;         // port A is output
  TRISE = 0x0000;         // port E is output

  LATA  = 0Xffff;         // turn OFF the PORTA leds
  LATE  = 0Xffff;         // turn OFF the PORTE led ( single green LED on PIC32 Beti)

/*odcA  = 0xffff;
  odcD  = 0xffff;
  odcE  = 0xffff;
  odcF  = 0xffff;
  odcG  = 0xffff;
*/
  
  while (1) {

  LATA  = 0Xffff;                          // turn OFF the PORTE leds
  LATE  = 0Xffff;                          // turn OFF the PORTE leds
  Wait();                                  // 1s pause

  LATA  = 0X0000;                          // turn OFF the PORTE leds
  LATE  = 0X0000;                          // turn OFF the PORTE leds
  Wait();                                  // 1s pause

  }//while

}//main