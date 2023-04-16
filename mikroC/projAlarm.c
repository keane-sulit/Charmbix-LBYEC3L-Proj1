/*
Project: PIC16F877A Digital Clock
Build Date: 2023.04.16 03:43 PM

Build Status
- [o] Clock Mode (24hr/12hr)
- [P] Mode (CLOCK/STOPWATCH/TIMER/ALARM)
- [P] Set/Adjust Time (CLOCK/TIMER/ALARM)
- [o] Pause/Resume Stopwatch (CLOCK/STOPWATCH/TIMER)
- [o] Clock Logic
- [o] Stopwatch Logic
- [o] Timer Logic
- [P] Alarm Logic

This firmware is for the PIC16F877A microcontroller.
It runs on a 20MHz crystal.
It is a digital clock running on a multiplexed 7-segment display.
PORTC is the data bus for the 7-segment display.
PORTD is the address bus for the 7-segment display.
RD0 = Tens digit of hours
RD1 = Ones digit of hours
RD2 = Tens digit of minutes
RD3 = Ones digit of minutes
*/

unsigned int i = 0;  // General purpose counter      unused
unsigned int j = 0;  // General purpose counter      unused
unsigned int k = 0;  // General purpose counter      unused
unsigned int l = 0;  // General purpose counter      unused

unsigned int hoursTens = 0;    // 0 = Not set, 1 = Set     unused
unsigned int hoursOnes = 0;    // 0 = Not set, 1 = Set     unused
unsigned int minutesTens = 0;  // 0 = Not set, 1 = Set     unused
unsigned int minutesOnes = 0;  // 0 = Not set, 1 = Set     unused

// Internal clock variables
unsigned char tmr0Count = 0;  // Increments every 13.107ms

// Time variables
unsigned int hours = 12;
unsigned int minutes = 50;
unsigned int seconds = 0;
unsigned int swSeconds = 0;     // Stopwatch seconds
unsigned int swMinutes = 0;     // Stopwatch minutes
unsigned int tmrSeconds = 0;    // Timer seconds
unsigned int tmrMinutes = 2;    // Timer minutes
unsigned int alarmHours = 0;    // Alarm hours
unsigned int alarmMinutes = 0;  // Alarm minutes
unsigned int alarmSeconds = 0;  // Alarm seconds

// Modes
unsigned int sysMode = 0;        // 0 = 12H CLOCK, 1 = 24H CLOCK, 2 = STOPWATCH, 3 = TIMER, 4 = DISPLAY ALARM, 5 = SET ALARM
unsigned int clockMode = 0;      // 0 = 24hr, 1 = 12hr
unsigned int stopWatchMode = 0;  // 0 = Default
unsigned int timerMode = 0;      // 0 = Default
unsigned int alarmMode = 0;      // 0 = Default

// States for clock, stopwatch, timer
unsigned int clockState = 0;  // 0 = GO, 1 = PAUSE
unsigned int swState = 0;     // 0 = PAUSE, 1 = RUN
unsigned int tmrState = 0;    // 0 = PAUSE, 1 = RUN
unsigned int alarmState = 0;  // 0 = OFF, 1 = ON

unsigned int setFlag = 0;    // 0 = No, 1 = Yes
unsigned int digitFlag = 0;  // 0 = None, 1 = hours, 2 = minutes

unsigned int incrementFlag = 0;  // 0 = No, 1 = Yes
unsigned int decrementFlag = 0;  // 0 = No, 1 = Yes     unused
unsigned int selectFlag = 0;     // 0 = No, 1 = Yes     unused

char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99,
                      0x92, 0x82, 0xF8, 0x80, 0x90};

void portInit() {
    TRISC = 0x00;  // PORTC is the data bus
    TRISD = 0x00;  // PORTD is the address bus
}

void interruptInit() {
    INTCON.f7 = 1;      // Enable Global Interrupt
    INTCON.f6 = 1;      // Enable Peripheral Interrupt
    INTCON.f5 = 1;      // Enable TMR0 Interrupt
    INTCON.f4 = 1;      // Enable RB0 External Interrupt Port Change Interrupt
    INTCON.f3 = 1;      // Enable RB Port Change Interrupt */
    OPTION_REG.f5 = 0;  // Internal Instruction Cycle Clock (CLKO)
    OPTION_REG.f4 = 0;  // Increment on Low-to-High Transition on T0CKI Pin
    OPTION_REG.f3 = 0;  // Prescaler is assigned to the Timer0 module
    // Prescaler Rate Select bits (111 = 1:256)
    OPTION_REG.f2 = 1;
    OPTION_REG.f1 = 0;
    OPTION_REG.f0 = 0;
}

void update() {
    // Clock continuously updates regardless of mode
    seconds++;
    if (seconds > 59) {  // CLOCK
        seconds = 0;
        minutes++;
        if (minutes > 59) {
            minutes = 0;
            hours++;
        }
    }

    // Update stopwatch
    if (sysMode == 2 && swState == 0) {
        swSeconds++;
        if (swSeconds > 59) {
            swSeconds = 0;
            swMinutes++;
        }
    } else if (sysMode == 2 && swState == 1) {
        // Do nothing since clock is paused.
        return;
    }

    // Update timer
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
        // Do nothing since clock is paused.
        return;
    }

    // TODO: Update alarm
    if (sysMode == 4 && alarmState == 0) {  // ALARM
        // No need to update alarm since it is only used to compare with clock
    } else if (sysMode == 4 && alarmState == 1) {
        // Do nothing since clock is paused.
        return;
    }
}

void interrupt() {
    INTCON.f7 = 0;  // Disable Global Interrupt

    // ISR for TMR0
    if (INTCON.f2 == 1) {
        if (tmr0Count == 10) {  // Change to 76 after simulation testing
            tmr0Count = 0;
            // Update time after 1 minute
            update();
        } else {
            tmr0Count++;
        }
        INTCON.f2 = 0;  // Clear TMR0 Interrupt Flag
    }

    // ISR for RB0 External Interrupt
    if (INTCON.f1 == 1) {
        // TODO: Add alarm mode in main menu
        if (PORTB.f0 == 0) {
            delay_ms(50);
        }
        // Toggle between 12H and 24H clock
        sysMode++;
        if (sysMode == 1) {  // 24H clock
            clockMode = 1;
            clockState = 0;
        } else if (sysMode == 2) {  // Stopwatch
            stopWatchMode = 0;
            swState = 1;  // Pause
        } else if (sysMode == 3) {
            timerMode = 0;
            tmrState = 1;           // Pause
        } else if (sysMode == 4) {  // Alarm
            alarmMode = 0;
            alarmState = 0;  // Alarm OFF
        } else if (sysMode == 5) {
            alarmState = 1;         // Alarm ON
        } else if (sysMode == 6) {  // TEMPORARY
            sysMode = 0;            // Reset to 12H clock
            clockMode = 0;
            clockState = 0;
        }

        INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
    }

    // TODO: ISR for RB Port Change Interrupt
    if (INTCON.f0 == 1) {
        if (PORTB.f4 == 0) {
            delay_ms(50);
            // Clock pause
            if (sysMode == 0 || sysMode == 1) {
                if (clockState == 0) {
                    clockState = 1;
                } else {
                    clockState = 0;
                }
            }
            // Stopwatch pause
            if (sysMode == 2) {
                if (swState == 0) {
                    swState = 1;
                } else {
                    swState = 0;
                }
            }
            // Timer pause
            if (sysMode == 3) {
                if (tmrState == 0) {
                    tmrState = 1;
                } else {
                    tmrState = 0;
                }
            }

            // Display and set alarm time

            // Toggle alarm on/off
            if (sysMode == 5) {
                if (alarmState == 0) {
                    alarmState = 1;
                } else {
                    alarmState = 0;
                }
            }
        }

        // TODO: SET: Select digit to set
        if (PORTB.f5 == 0) {
            delay_ms(50);
            // Digit set select
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
            // Clock reset
            if (sysMode == 0 || sysMode == 1) {
                seconds = 0;
                minutes = 0;
                hours = 0;
            }
            // Stopwatch reset
            if (sysMode == 2) {
                swSeconds = 0;
                swMinutes = 0;
            }
            // Timer reset
            if (sysMode == 3) {
                tmrSeconds = 0;
                tmrMinutes = 0;
            }
        }

        // TODO: SET: Increment digit
        // FIXME: Stack underflow
        if (PORTB.f7 == 0) {
            delay_ms(50);
            // Clock set increment
            if (digitFlag == 1 && (clockMode == 0 || clockMode == 1)) {
                hours = (hours + 1) % 24;
            } else if (digitFlag == 2) {
                minutes = (minutes + 1) % 60;
            }

            // Timer set increment
            if (digitFlag == 1 && timerMode == 0) {
                tmrMinutes = (tmrMinutes + 1) % 60;
            } else if (digitFlag == 2 && sysMode == 3) {
                tmrSeconds = (tmrSeconds + 1) % 60;
            }

            // TODO: Alarm set increment
            if (digitFlag == 1 && alarmMode == 0) {
                alarmHours = (alarmHours + 1) % 24;
            } else if (digitFlag == 2 && sysMode == 4) {
                alarmMinutes = (alarmMinutes + 1) % 60;
            }
        }

        INTCON.f0 = 0;  // Clear RB Port Change Interrupt Flag
    }

    INTCON.f7 = 1;  // Enable Global Interrupt
}

void updateClockDisplay(int num, int segIndex) {
    switch (segIndex) {
        case 0:
            PORTD = 0x01;  // Select the first digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 1:
            PORTD = 0x02;  // Select the second digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 2:
            PORTD = 0x04;  // Select the third digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 3:
            PORTD = 0x08;  // Select the fourth digit
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
            PORTD = 0x01;  // Select the first digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 1:
            PORTD = 0x02;  // Select the second digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 2:
            PORTD = 0x04;  // Select the third digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 3:
            PORTD = 0x08;  // Select the fourth digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
    }
}

void stopWatch(int swMinutes, int swSeconds) {
    // 00:00 - 99:59
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
            PORTD = 0x01;  // Select the first digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 1:
            PORTD = 0x02;  // Select the second digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 2:
            PORTD = 0x04;  // Select the third digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 3:
            PORTD = 0x08;  // Select the fourth digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
    }
}

void timer(int tmrMinutes, int tmrSeconds) {
    // 99:59 - 00:00
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

// CHECK: If this function is used
void set() {
    // Set time
    hoursTens = hours / 10;
    hoursOnes = hours % 10;
    minutesTens = minutes / 10;
    minutesOnes = minutes % 10;
}

void updateAlarmDisplay(int num, int segIndex) {
    switch (segIndex) {
        case 0:
            PORTD = 0x01;  // Select the first digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 1:
            PORTD = 0x02;  // Select the second digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 2:
            PORTD = 0x04;  // Select the third digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
        case 3:
            PORTD = 0x08;  // Select the fourth digit
            PORTC = dispDigit[num];
            delay_ms(1);
            break;
    }
}

void displayAlarmTimeDisplay(int hours, int minutes) {
    // Display alarm time being set
    updateAlarmDisplay(hours / 10, 0);
    updateAlarmDisplay(hours % 10, 1);
    updateAlarmDisplay(minutes / 10, 2);
    updateAlarmDisplay(minutes % 10, 3);
}

// FIXME: Fix this function since it recurses infinitely
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
        } else if (sysMode == 4) {
            displayAlarmTimeDisplay(alarmHours, alarmMinutes);
        }
        // TODO: Add a case for the alarm
    }
}