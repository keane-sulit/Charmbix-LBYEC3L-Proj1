#line 1 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
#line 27 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
unsigned int i = 0;
unsigned int j = 0;
unsigned int k = 0;
unsigned int l = 0;

unsigned int hoursTens = 0;
unsigned int hoursOnes = 0;
unsigned int minutesTens = 0;
unsigned int minutesOnes = 0;

unsigned int seconds = 0;
unsigned int swSeconds = 0;
unsigned int swMinutes = 0;
unsigned int tmrSeconds = 0;
unsigned int tmrMinutes = 2;

unsigned int sysMode = 0;
unsigned int clockMode = 0;

unsigned int clockState = 0;
unsigned int swState = 0;
unsigned int tmrState = 0;

unsigned int setFlag = 0;
unsigned int digitFlag = 0;
unsigned int stopWatchMode = 0;
unsigned int timerMode = 0;
unsigned int incrementFlag = 0;
unsigned int decrementFlag = 0;
unsigned int selectFlag = 0;


unsigned int hours = 12;
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

 OPTION_REG.f2 = 1;
 OPTION_REG.f1 = 0;
 OPTION_REG.f0 = 0;
}

void update() {
 seconds++;
 if (seconds > 59) {
 seconds = 0;
 minutes++;
 if (minutes > 59) {
 minutes = 0;
 hours++;
 }
 }

 if (sysMode == 2 && swState == 0) {
 swSeconds++;
 if (swSeconds > 59) {
 swSeconds = 0;
 swMinutes++;
 }
 } else if (sysMode == 2 && swState == 1) {

 return;
 }

 if (sysMode == 3 && tmrState == 0) {
 if (tmrSeconds > 0) {
 tmrSeconds--;
 } else {
 if (tmrMinutes > 0) {
 tmrMinutes--;
 tmrSeconds = 59;
 }
 }
 } else if (sysMode == 3 && tmrState == 1) {

 return;
 }

 if (sysMode == 4) {

 } else {

 return;
 }


}

void interrupt() {
 INTCON.f7 = 0;


 if (INTCON.f2 == 1) {
 if (tmr0Count == 10) {
 tmr0Count = 0;

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

 sysMode++;
 if (sysMode == 1) {
 clockMode = 1;
 clockState = 0;
 } else if (sysMode == 2) {
 stopWatchMode = 0;
 swState = 1;
 } else if (sysMode == 3) {
 timerMode = 0;
 tmrState = 1;
 } else if (sysMode == 4) {
 sysMode = 0;
 clockMode = 0;
 clockState = 0;
 }

 INTCON.f1 = 0;
 }


 if (INTCON.f0 == 1) {

 if (PORTB.f4 == 0) {
 delay_ms(50);

 if (sysMode == 0 || sysMode == 1) {
 if (clockState == 0) {
 clockState = 1;
 } else {
 clockState = 0;
 }
 }

 if (sysMode == 2) {
 if (swState == 0) {
 swState = 1;
 } else {
 swState = 0;
 }
 }

 if (sysMode == 3) {
 if (tmrState == 0) {
 tmrState = 1;
 } else {
 tmrState = 0;
 }
 }
 }


 if (PORTB.f5 == 0) {
 delay_ms(50);

 if (digitFlag == 0) {
 digitFlag = 1;
 } else if (digitFlag == 1) {
 digitFlag = 2;
 } else if (digitFlag == 2) {
 digitFlag = 0;
 }
 }


 if (PORTB.f6 == 0) {
 delay_ms(50);

 if (sysMode == 0 || sysMode == 1) {
 seconds = 0;
 minutes = 0;
 hours = 0;
 }

 if (sysMode == 2) {
 swSeconds = 0;
 swMinutes = 0;
 }

 if (sysMode == 3) {
 tmrSeconds = 0;
 tmrMinutes = 0;
 }

 }


 if (PORTB.f7 == 0) {
 delay_ms(50);

 if (digitFlag == 1 && (clockMode == 0 || clockMode == 1)) {
 hours = (hours + 1) % 24;
 } else if (digitFlag == 2) {
 minutes = (minutes + 1) % 60;
 }

 if (digitFlag == 1 && stopWatchMode == 0) {
 swMinutes = (swMinutes + 1) % 60;
 } else if (digitFlag == 2 && sysMode == 2) {
 swSeconds = (swSeconds + 1) % 60;
 }
#line 261 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
 }

 INTCON.f0 = 0;
 }

 INTCON.f7 = 1;
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

void stopWatch(int swMinutes, int swSeconds) {

 if (swMinutes < 100) {
 updateStopWatchDisplay(swMinutes / 10, 0);
 updateStopWatchDisplay(swMinutes % 10, 1);
 updateStopWatchDisplay(swSeconds / 10, 2);
 updateStopWatchDisplay(swSeconds % 10, 3);
 } else {
 updateStopWatchDisplay(0, 0);
 updateStopWatchDisplay(0, 1);
 updateStopWatchDisplay(swSeconds / 10, 2);
 updateStopWatchDisplay(swSeconds % 10, 3);
 }
}

void updateTimerDisplay(int num, int segIndex) {
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

void timer(int tmrMinutes, int tmrSeconds) {

 if (tmrMinutes < 100) {
 updateTimerDisplay(tmrMinutes / 10, 0);
 updateTimerDisplay(tmrMinutes % 10, 1);
 updateTimerDisplay(tmrSeconds / 10, 2);
 updateTimerDisplay(tmrSeconds % 10, 3);
 } else {
 updateTimerDisplay(0, 0);
 updateTimerDisplay(0, 1);
 updateTimerDisplay(tmrSeconds / 10, 2);
 updateTimerDisplay(tmrSeconds % 10, 3);
 }
}

void set() {

 hoursTens = hours / 10;
 hoursOnes = hours % 10;
 minutesTens = minutes / 10;
 minutesOnes = minutes % 10;
}


void blink() {
 if (tmrSeconds == 0 && tmrMinutes == 0) {
 PORTD = 0x00;
 PORTC = 0x00;
 delay_ms(500);
 PORTD = 0x0F;
 PORTC = 0xFF;
 delay_ms(500);
 }
}

void main() {
 portInit();
 interruptInit();

 while (1) {
 if (sysMode == 0 || sysMode == 1) {
 displayClockTime(hours, minutes, clockMode);
 } else if (sysMode == 2) {

 stopWatch(swMinutes, swSeconds);
 } else if (sysMode == 3) {

 timer(tmrMinutes, tmrSeconds);
 blink();
 }
 }
}
