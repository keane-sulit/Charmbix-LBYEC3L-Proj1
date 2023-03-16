/*
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

*/
char count[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

enum project_modes {
    CLOCK,
    STOPWATCH,
    COUNTDOWN_TIMER
};

enum clock_modes {
    CLOCK_12H,
    CLOCK_24H,
};

int mode = CLOCK_12H;      // Default mode is 12h clock

int hours = 12;
int minutes = 59;

int i;

void interrupt() {
    if (INTCON.RBIF) {
        INTCON.RBIF = 0;
        if (PORTB.f7 == 0) {
            if(mode == CLOCK_12H) {
                mode = CLOCK_24H;
            } else {
                mode = CLOCK_12H;
            }
        }
    }
}
void init() {
    TRISB.f7 = 1; // PORTB is the control bus
    TRISC = 0x00; // PORTC is the data bus
    TRISD = 0x00; // PORTD is the address bus
}

void disp_dig(int dig, int seg) {
    switch(seg){
        case 1:
            PORTD = 0x0E;
            PORTC = count[dig];
            delay_ms(10);
            break;
        case 2:
            PORTD = 0x0D;
            PORTC = count[dig];
            delay_ms(10);
            break;
        case 3:
            PORTD = 0x0B;
            PORTC = count[dig];
            delay_ms(10);
            break;
        case 4:
            PORTD = 0x07;
            PORTC = count[dig];
            delay_ms(10);
            break;
    }
}

void disp_time(int hours, int minutes) {
    for (i = 0; i < 25; i++) {
        disp_dig(hours / 10, 1);
        disp_dig(hours % 10, 2);
        disp_dig(minutes / 10, 3);
        disp_dig(minutes % 10, 4);
    }
}

void inc_time() {
    if (minutes > 59) {
        minutes = 0;
        hours++;
        if (mode == CLOCK_12H) {
            if (hours > 12) {
                hours = 1;
            }
        } else {                // mode == CLOCK_24H
            if (hours > 23) {
                hours = 0;
            }
        }
    }
    minutes++;
}

void modes() {
    // Mode 1: CLOCK
    //  - Toggle between 12h and 24h
    //  - Stop / Resume
    //  - Set time (up, down, left, right)
    // Mode 2: STOPWATCH
    //  - Start / Stop
    //  - Pause / Resume
    //  - Reset
    // Mode 3: COUNTDOWN TIMER
    //  - Set time (up, down, left, right)
    //  - Pause / Resume
    //  - Start / Stop
    //  - Reset
}

void main() {
    init();
    disp_time(hours, minutes);
    INTCON.GIE = 1;             // Enable global interrupts
    INTCON.PEIE = 1;            // Enable peripheral interrupts
    INTCON.RBIE = 1;            // Enable RB port change interrupts
    INTCON.RBIF = 0;            // Clear RB port change interrupt flag
    OPTION_REG.f7 = 1;          // Enable pull-up resistor for RB7

    
    while(1) {
        inc_time();
        disp_time(hours, minutes);
    }
}