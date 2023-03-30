#line 1 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
#line 16 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
unsigned int i = 0;
unsigned int j = 0;
unsigned int k = 0;
unsigned int l = 0;

unsigned int hoursTens = 0;
unsigned int hoursOnes = 0;
unsigned int minutesTens = 0;
unsigned int minutesOnes = 0;

unsigned int seconds = 0;

unsigned int hours = 11;
unsigned int minutes = 59;

unsigned char tmr0Count = 0;

char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};

void interrupt() {
 INTCON.f7 = 0;



 if (INTCON.f2 == 1) {

 tmr0Count++;

 if (tmr0Count >= 76) {
 tmr0Count = 0;
 seconds++;
 }

 TMR0 = 0;
 INTCON.f2 = 0;
 }

 INTCON.f7 = 1;
}

int updateHoursTens() {
 hoursTens = (hours/10)%10;
 return hoursTens;
}

int updateHoursOnes() {
 hoursOnes = hours%10;
 return hoursOnes;
}

int updateMinutesTens() {
 minutesTens = (minutes/10)%10;
 return minutesTens;
}

int updateMinutesOnes() {
 minutesOnes = minutes%10;
 return minutesOnes;
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

 TMR0 = 0;
}

void main() {
 init();
 interruptInit();



 while(1) {

 PORTC = dispDigit[i];
 PORTD = 0x01;
 delay_ms(50);
 PORTC = dispDigit[j];
 PORTD = 0x02;
 delay_ms(50);
 PORTC = dispDigit[k];
 PORTD = 0x04;
 delay_ms(50);
 PORTC = dispDigit[l];
 PORTD = 0x08;
 delay_ms(50);

 updateHoursTens();
 updateHoursOnes();
 updateMinutesTens();
 updateMinutesOnes();

 i = hoursTens;
 j = hoursOnes;
 k = minutesTens;
 l = minutesOnes;
#line 136 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
 }
}
