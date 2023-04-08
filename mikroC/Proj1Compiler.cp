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

unsigned int hoursFlag = 0;


unsigned int hours = 12;
unsigned int minutes = 50;

unsigned char tmr0Count = 0;

char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};

void interrupt()
{
 INTCON.f7 = 0;


 if (INTCON.f2 == 1)
 {
 if (tmr0Count == 2)
 {
 tmr0Count = 0;

 seconds++;
 if (seconds > 59)
 {
 seconds = 0;
 minutes++;
 if (minutes > 59)
 {
 minutes = 0;
 hours++;


 switch (hoursFlag)
 {
 case 0:
 if (hours == 13)
 {
 hours = 1;
 }
 break;
 case 1:
 if (hours == 24)
 {
 hours = 0;
 }
 break;
 }
 }
 }
 }
 else
 {
 tmr0Count++;
 }
 INTCON.f2 = 0;
 }



 if (INTCON.f1 == 1)
 {

 hoursFlag = ~hoursFlag;
 INTCON.f1 = 0;
 }

 INTCON.f7 = 1;
}

int updateHoursTens()
{
 hoursTens = hours / 10;
 return hoursTens;
}

int updateHoursOnes()
{
 hoursOnes = hours % 10;
 return hoursOnes;
}

int updateMinutesTens()
{
 minutesTens = minutes / 10;
 return minutesTens;
}

int updateMinutesOnes()
{
 minutesOnes = minutes % 10;
 return minutesOnes;
}

void portInit()
{
 TRISC = 0x00;
 TRISD = 0x00;
}

void interruptInit()
{
 INTCON.f7 = 1;
 INTCON.f6 = 1;
 INTCON.f5 = 1;
 INTCON.f4 = 1;

 OPTION_REG.f5 = 0;
 OPTION_REG.f4 = 0;
 OPTION_REG.f3 = 0;

 OPTION_REG.f2 = 0;
 OPTION_REG.f1 = 0;
 OPTION_REG.f0 = 1;
}

void main()
{
 portInit();
 interruptInit();

 while (1)
 {
 PORTD = 0x01;
 PORTC = dispDigit[i];
 delay_ms(1);
 PORTD = 0x02;
 PORTC = dispDigit[j];
 delay_ms(1);
 PORTD = 0x04;
 PORTC = dispDigit[k];
 delay_ms(1);
 PORTD = 0x08;
 PORTC = dispDigit[l];
 delay_ms(1);

 updateHoursTens();
 updateHoursOnes();
 updateMinutesTens();
 updateMinutesOnes();

 i = hoursTens;
 j = hoursOnes;
 k = minutesTens;
 l = minutesOnes;
#line 182 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
 }
}
