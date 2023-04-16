/*
Project: PIC16F877A Digital Clock using Multiplexed 7-Segment Displays

Build Date: 2023.04.16 10:50 PM
Final Build Version: 1.0.1

Fixes:
1.0.0 - Initial build
1.0.1 - `blink()` function was removed since it was causing the clock to break.

Build Status
- [o] Clock Mode (24hr/12hr)
- [o] Mode (CLOCK / STOPWATCH / TIMER / ALARM (NI) ), NI = Not Implemented
- [o] Set/Adjust Time
- [o] Start/Stop Stopwatch
- [o] Pause/Resume Stopwatch
- [o] Clock
- [o] Stopwatch
- [o] Timer
- [x] Alarm (Not implemented since Proteus lags when simulating)

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
unsigned int minutes = 58;
unsigned int seconds = 0;
unsigned int swSeconds = 0;   // Stopwatch seconds
unsigned int swMinutes = 0;   // Stopwatch minutes
unsigned int tmrSeconds = 0;  // Timer seconds
unsigned int tmrMinutes = 2;  // Timer minutes

// Modes
unsigned int sysMode = 0;        // 0 = 12H CLOCK, 1 = 24H CLOCK, 2 = STOPWATCH, 3 = TIMER, 4 = ALARM
unsigned int clockMode = 0;      // 0 = 24hr, 1 = 12hr
unsigned int stopWatchMode = 0;  // 0 = Default
unsigned int timerMode = 0;      // 0 = Default

// Flags for the states of the clock, stopwatch, and timer
unsigned int clockState = 0;  // 0 = GO, 1 = PAUSE
unsigned int swState = 0;     // 0 = PAUSE, 1 = RUN
unsigned int tmrState = 0;    // 0 = PAUSE, 1 = RUN

// Flags for setting time
unsigned int digitFlag = 0;  // 0 = None, 1 = hours, 2 = minutes

// Flags for incrementing time
unsigned int incrementFlag = 0;  // 0 = No, 1 = Yes

// 7-segment display variables
char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99,
                      0x92, 0x82, 0xF8, 0x80, 0x90};

// Function to initialize the ports
void portInit() {
    TRISC = 0x00;  // PORTC is the data bus
    TRISD = 0x00;  // PORTD is the address bus
}

// Function to initialize the interrupts

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
    // Change to 100 = 1:16 when performing simulation testing
    OPTION_REG.f2 = 1;
    OPTION_REG.f1 = 0;
    OPTION_REG.f0 = 0;
}

// Function to update the time variables
void update() {
    // Clock continuously updates regardless of mode
    // TODO: Add condition - sysMode != 4
    // Update clock
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

    // SOON: Update alarm
    /* if (sysMode == 4) {  // ALARM

    } else {
        // Do nothing since clock is paused.
        return;
    } */
}

// Function for interrupt service routines
void interrupt() {
    INTCON.f7 = 0;  // Disable Global Interrupt

    // ISR for TMR0
    if (INTCON.f2 == 1) {
        if (tmr0Count == 10) {  // Change to 76 after simulation testing
            tmr0Count = 0;
            update();           // Update time variables
        } else {
            tmr0Count++;
        }
        INTCON.f2 = 0;          // Clear TMR0 Interrupt Flag
    }

    // ISR for RB0 External Interrupt
    if (INTCON.f1 == 1) {

        // Mode button
        if (PORTB.f0 == 0) {
            delay_ms(50);           // Debounce
        }

        // Loop through system modes
        sysMode++;                  // Increment mode
        if (sysMode == 1) {         // 24H CLOCK
            clockMode = 1;          // 24H
            clockState = 0;         // GO
        } else if (sysMode == 2) {  // STOPWATCH
            stopWatchMode = 0;      // Default
            swState = 1;            // Pause
        } else if (sysMode == 3) {  // TIMER
            timerMode = 0;          // Default
            tmrState = 1;           // Pause
        } else if (sysMode == 4) {  // 12H CLOCK
            sysMode = 0;            // Reset to 12H
            clockMode = 0;          // 12H
            clockState = 0;         // GO
        }

        INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
    }

    // ISR for RB Port Change Interrupt
    if (INTCON.f0 == 1) {

        // PAUSE/GO button: Pause or resume system
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
        }
        
        // RESET button: Reset time variables
        if (PORTB.f5 == 0) {
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

        // SET button: Select digit to set
        if (PORTB.f6 == 0) {
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

        // INCREMENT button: Increment time variables
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
        }

        INTCON.f0 = 0;  // Clear RB Port Change Interrupt Flag
    }

    INTCON.f7 = 1;  // Enable Global Interrupt
}

// Function to update the clock display
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

// Function to toggle 12H clock display
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

// Function to toggle 24H clock display
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

// Function to display clock time
void clock(int hours, int minutes, int clockMode) {
    switch (clockMode) {
        case 0:
            toggleClockTwelve(hours, minutes);
            break;
        case 1:
            toggleClockTwentyFour(hours, minutes);
            break;
    }
}

// Function to update the stopwatch display
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

// Function to display stopwatch time
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

// Function to update the timer display
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

// Function to display timer time
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

// FIXME: Fix this function since it recurses infinitely
/* void blink() {
    if (tmrSeconds == 0 && tmrMinutes == 0) {
        for (i == 0; i < 10; i++) {
            PORTD = 0x00;
            PORTC = 0x00;
            delay_ms(500);
            PORTD = 0x0F;
            PORTC = 0xFF;
            delay_ms(500);
        }
        return;
    }
} */

// Main function
void main() {
    portInit();                 // Initialize the ports
    interruptInit();            // Initialize the interrupts
    // Infinite loop for the program
    while (1) {
        if (sysMode == 0 || sysMode == 1) {
            clock(hours, minutes, clockMode);
        } else if (sysMode == 2) {
            stopWatch(swMinutes, swSeconds);
        } else if (sysMode == 3) {
            timer(tmrMinutes, tmrSeconds);
            /* blink(); */
        }  // TODO: Add a case for the alarm
    }
}