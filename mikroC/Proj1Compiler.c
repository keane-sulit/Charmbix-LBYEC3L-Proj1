/*
Build Date: 2023.04.09 01:35 PM
This firmware is for the PIC16F877A microcontroller.
It runs on a 20MHz crystal.
It is a digital clock running on a multiplexed 7-segment display.
PORTC is the data bus for the 7-segment display.
PORTD is the address bus for the 7-segment display.
RD0 = Tens digit of hours
RD1 = Ones digit of hours
RD2 = Tens digit of minutes
RD3 = Ones digit of minutes

DEFAULT Operation Mode: CLOCK
RB0 = Clock Mode (24hr/12hr)
RB4 = Mode (CLOCK/STOPWATCH/TIMER/ALARM)
*/

unsigned int i = 0;
unsigned int j = 0;
unsigned int k = 0;
unsigned int l = 0;

unsigned int hoursTens = 0;
unsigned int hoursOnes = 0;
unsigned int minutesTens = 0;
unsigned int minutesOnes = 0;

unsigned int seconds = 0;

unsigned int clockMode = 0;  // 0 = 24hr, 1 = 12hr
unsigned int sysMode = 0;    // 0 = CLOCK, 1 = STOPWATCH, 2 = TIMER, 3 = ALARM
unsigned int stopWatchMode = 0;  // 0 = SET, 1 = RUN, 2 = PAUSE

// Variables to adjust time
unsigned int hours = 11;
unsigned int minutes = 50;

unsigned char tmr0Count = 0;  // Increments every 13.107ms

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
    OPTION_REG.f2 = 0;
    OPTION_REG.f1 = 1;
    OPTION_REG.f0 = 1;
}

void update() {
    if (seconds > 59) {
        seconds = 0;
        minutes++;
        if (minutes > 59) {
            minutes = 0;
            hours++;
        }
    }
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

void stopWatch(int minutes, int seconds) {
    // 00:00 - 99:59
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
            // Set stop watch
            PORTD = 0x01;  // Select the first digit
            PORTC = dispDigit[0];
            delay_ms(1);
            PORTD = 0x02;  // Select the second digit
            PORTC = dispDigit[0];
            delay_ms(1);
            PORTD = 0x04;  // Select the third digit
            PORTC = dispDigit[0];
            delay_ms(1);
            PORTD = 0x08;  // Select the fourth digit
            PORTC = dispDigit[0];
            delay_ms(1);
            break;
        case 1:
            // Start stop watch
            stopWatch(minutes, seconds);
            break;
    }
}

void interrupt() {
    INTCON.f7 = 0;  // Disable Global Interrupt

    // ISR for TMR0
    if (INTCON.f2 == 1) {
        if (tmr0Count == 2) {  // Change to 76 after simulation testing
            tmr0Count = 0;
            // Update time after 1 minute
            seconds++;
            update();
        } else {
            tmr0Count++;
        }
        INTCON.f2 = 0;  // Clear TMR0 Interrupt Flag
    }

    // ISR for RB0 External Interrupt
    if (INTCON.f1 == 1) {
        // Debounce button
        if (PORTB.f0 == 0) {
            delay_ms(50);
        }
        if (clockMode == 0) {
            clockMode = 1;
        } else {
            clockMode = 0;
        }
        INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
    }

    // WIP: ISR for RB Port Change Interrupt
    if (INTCON.f3 == 1) {
        // Debounce button
        if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 1) {
            delay_ms(50);
            sysMode++;
            if (sysMode > 3) {
                sysMode = 0;
            } else if (sysMode == 1) {
                if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 1) {
                    delay_ms(50);
                    stopWatchMode++;
                    if (stopWatchMode > 2) {
                        stopWatchMode = 0;
                    }
                };
            }
        }

        INTCON.f3 = 0;  // Clear RB Port Change Interrupt Flag
    }
    INTCON.f7 = 1;  // Enable Global Interrupt
}

void main() {
    portInit();
    interruptInit();

    while (1) {
        if (sysMode == 0) {
            displayClockTime(hours, minutes, clockMode);
        } else if (sysMode == 1) {
            // NOT WORKING: Stop watch
            displayStopWatchTime(minutes, seconds, stopWatchMode);
        } else if (sysMode == 2) {
            // TODO: Add timer
        } else if (sysMode == 3) {
            // TODO: Set alarm
        }
    }
}