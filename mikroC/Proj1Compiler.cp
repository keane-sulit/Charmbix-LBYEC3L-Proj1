#line 1 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
#line 16 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
unsigned int i = 0;
unsigned int j = 0;
unsigned int k = 0;
unsigned int l = 0;

unsigned int hours = 11;
unsigned int minutes = 59;

unsigned char timerCount = 0;
char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};

void interrupt() {
 INTCON.f7 = 0;
 if (INTCON.f2 == 1) {
 if (timerCount >= 5) {
 timerCount = 0;
 }

 if (timerCount == 1) {
 PORTD = 0x01;
 PORTC = dispDigit[i];
 }
 if (timerCount == 2) {
 PORTD = 0x02;
 PORTC = dispDigit[j];
 }
 if (timerCount == 3) {
 PORTD = 0x04;
 PORTC = dispDigit[k];
 }
 if (timerCount == 4) {
 PORTD = 0x08;
 PORTC = dispDigit[l];
 }

 timerCount++;
 INTCON.f2 = 0;
 }

 INTCON.f7 = 1;
}

void init() {
 TRISC = 0x00;
 TRISD = 0x00;
}

void interruptInit() {
 INTCON.f7 = 1;
 INTCON.f6 = 1;
 INTCON.f5 = 1;
 OPTION_REG.f5 = 0;
 OPTION_REG.f4 = 0;
 OPTION_REG.f3 = 0;

 OPTION_REG.f2 = 1;
 OPTION_REG.f1 = 1;
 OPTION_REG.f0 = 1;

 TMR0 = 59;
}

void main() {
 init();
 interruptInit();
 while(1) {
 i = hours/10;
 j = hours%10;
 k = minutes/10;
 l = minutes%10;

 minutes++;
 if (minutes == 60) {
 minutes = 0;
 hours++;
 if (hours == 13) {
 hours = 1;
 }
 }
 delay_ms(1000);
 }
}
