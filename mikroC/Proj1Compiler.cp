#line 1 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
#line 34 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
unsigned int i = 0;
unsigned int j = 0;
unsigned int k = 0;
unsigned int l = 0;

unsigned int hoursTens = 0;
unsigned int hoursOnes = 0;
unsigned int minutesTens = 0;
unsigned int minutesOnes = 0;

unsigned int seconds = 0;

unsigned int clockMode = 0;
unsigned int sysMode = 0;
unsigned int stopWatchMode = 0;
unsigned int clockState = 0;
unsigned int incrementFlag = 0;
unsigned int decrementFlag = 0;
unsigned int selectFlag = 0;


unsigned int hours = 11;
unsigned int minutes = 50;

unsigned char tmr0Count = 0;

char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99,
 0x92, 0x82, 0xF8, 0x80, 0x90};

void portInit() {
 TRISC = 0x00;
 TRISD = 0x00;
}

void interruptInit() {
 INTCON.f7 = 1;
 INTCON.f6 = 1;
 INTCON.f5 = 1;
 INTCON.f4 = 1;
 INTCON.f3 = 1;
 OPTION_REG.f5 = 0;
 OPTION_REG.f4 = 0;
 OPTION_REG.f3 = 0;

 OPTION_REG.f2 = 0;
 OPTION_REG.f1 = 1;
 OPTION_REG.f0 = 1;
}

void update() {
 if ((clockMode == 0 || clockMode == 1) && clockState == 2) {
 if (incrementFlag == 1) {
 if (selectFlag == 0) {
 hours++;
 } else if (selectFlag == 1) {
 minutes++;
 }
 } else if (decrementFlag == 1) {
 if (selectFlag == 0) {
 hours--;
 } else if (selectFlag == 1) {
 minutes--;
 }
 }
 } else if ((clockMode == 0 || clockMode == 1) && clockState == 0) {
 if (seconds > 59) {
 seconds = 0;
 minutes++;
 if (minutes > 59) {
 minutes = 0;
 hours++;
 }
 }
 } else {
 return;
 }
}

void updateClockDisplay(int num, int segIndex) {
 switch (segIndex) {
 case 0:
 PORTD = 0x01;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 case 1:
 PORTD = 0x02;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 case 2:
 PORTD = 0x04;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 case 3:
 PORTD = 0x08;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 }
}

void toggleClockTwelve(int hours, int minutes) {
 if (0 < hours && hours < 13) {
 updateClockDisplay(hours / 10, 0);
 updateClockDisplay(hours % 10, 1);
 updateClockDisplay(minutes / 10, 2);
 updateClockDisplay(minutes % 10, 3);
 } else {
 updateClockDisplay(abs(hours - 12) / 10, 0);
 updateClockDisplay(abs(hours - 12) % 10, 1);
 updateClockDisplay(minutes / 10, 2);
 updateClockDisplay(minutes % 10, 3);
 }
}

void toggleClockTwentyFour(int hours, int minutes) {
 if (hours < 24) {
 updateClockDisplay(hours / 10, 0);
 updateClockDisplay(hours % 10, 1);
 updateClockDisplay(minutes / 10, 2);
 updateClockDisplay(minutes % 10, 3);
 } else {
 updateClockDisplay(0, 0);
 updateClockDisplay(0, 1);
 updateClockDisplay(minutes / 10, 2);
 updateClockDisplay(minutes % 10, 3);
 }
}

void displayClockTime(int hours, int minutes, int clockMode) {
 switch (clockMode) {
 case 0:
 toggleClockTwelve(hours, minutes);
 break;
 case 1:
 toggleClockTwentyFour(hours, minutes);
 break;
 }
}

void updateStopWatchDisplay(int num, int segIndex) {
 switch (segIndex) {
 case 0:
 PORTD = 0x01;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 case 1:
 PORTD = 0x02;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 case 2:
 PORTD = 0x04;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 case 3:
 PORTD = 0x08;
 PORTC = dispDigit[num];
 delay_ms(1);
 break;
 }
}

void stopWatch(int minutes, int seconds) {

 if (minutes < 100) {
 updateStopWatchDisplay(minutes / 10, 0);
 updateStopWatchDisplay(minutes % 10, 1);
 updateStopWatchDisplay(seconds / 10, 2);
 updateStopWatchDisplay(seconds % 10, 3);
 } else {
 updateStopWatchDisplay(0, 0);
 updateStopWatchDisplay(0, 1);
 updateStopWatchDisplay(seconds / 10, 2);
 updateStopWatchDisplay(seconds % 10, 3);
 }
}

void displayStopWatchTime(int minutes, int seconds, int stopWatchMode) {
 switch (stopWatchMode) {
 case 0:

 PORTD = 0x01;
 PORTC = dispDigit[0];
 delay_ms(1);
 PORTD = 0x02;
 PORTC = dispDigit[0];
 delay_ms(1);
 PORTD = 0x04;
 PORTC = dispDigit[0];
 delay_ms(1);
 PORTD = 0x08;
 PORTC = dispDigit[0];
 delay_ms(1);
 break;
 case 1:

 stopWatch(minutes, seconds);
 break;
 }
}

void selectDigit() {
 if (selectFlag == 0) {
 PORTD = 0x01;
 PORTC = dispDigit[0 ];
 delay_ms(1);
 } else if (selectFlag == 1) {
 PORTD = 0x02;
 PORTC = dispDigit[0 ];
 delay_ms(1);
 } else if (selectFlag == 2) {
 PORTD = 0x04;
 PORTC = dispDigit[0 ];
 delay_ms(1);
 } else if (selectFlag == 3) {
 PORTD = 0x08;
 PORTC = dispDigit[0 ];
 delay_ms(1);
 }
}

void interrupt() {
 INTCON.f7 = 0;


 if (INTCON.f2 == 1) {
 if (tmr0Count == 2) {
 tmr0Count = 0;

 seconds++;
 update();
 } else {
 tmr0Count++;
 }
 INTCON.f2 = 0;
 }


 if (INTCON.f1 == 1) {

 if (PORTB.f0 == 0) {
 delay_ms(50);
 }
 if (clockMode == 0) {
 clockMode = 1;
 } else {
 clockMode = 0;
 }
 INTCON.f1 = 0;
 }


 if (INTCON.f0 == 1) {

 if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 1) {
 delay_ms(50);

 clockState++;
 if (clockState > 1) {
 clockState = 0;

 }
 }





 if (PORTB.f4 == 1 && PORTB.f5 == 0 && PORTB.f6 == 1 && PORTB.f7 == 1) {
 delay_ms(50);
 selectFlag++;
 if (selectFlag > 3) {
 selectFlag = 0;
 }
 selectDigit();
 }

 if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 0) {
 delay_ms(50);
 if (clockMode != 2) {
 clockMode = 2;
 incrementFlag = 0;
 decrementFlag = 0;
 selectFlag = 0;
 }

 else {
 clockMode = 0;
 }
 }
#line 357 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
 INTCON.f0 = 0;
 }
 INTCON.f7 = 1;
}

void main() {
 portInit();
 interruptInit();

 while (1) {
 if (sysMode == 0) {
 displayClockTime(hours, minutes, clockMode);
 } else if (sysMode == 1) {

 displayStopWatchTime(minutes, seconds, stopWatchMode);
 } else if (sysMode == 2) {

 } else if (sysMode == 3) {

 }
 }
}
