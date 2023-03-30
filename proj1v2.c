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
char digit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};

enum project_modes {
    CLOCK,
    STOPWATCH,
    COUNTDOWN_TIMER
};

enum clock_modes {
    CLOCK_12H,
    CLOCK_24H,
};

enum project_modes mode = CLOCK;
enum clock_modes clock_mode = CLOCK_12H;

int hours = 12;
int minutes = 59;

int i;

void interrupt() {
    if (INTCON.RBIF) {
        INTCON.RBIF = 0;
        if (PORTB.f7 == 0) {
            if(clock_mode == CLOCK_12H) {
                clock_mode = CLOCK_24H;
            } else {
                clock_mode = CLOCK_12H;
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
            delay_ms(10);                           // TO REMOVE BEFORE WRITING
            break;
        case 2:
            PORTD = 0x0D;
            PORTC = count[dig];
            delay_ms(10);                           // TO REMOVE BEFORE WRITING
            break;
        case 3:
            PORTD = 0x0B;
            PORTC = count[dig];
            delay_ms(10);                           // TO REMOVE BEFORE WRITING
            break;
        case 4:
            PORTD = 0x07;
            PORTC = count[dig];
            delay_ms(10);                           // TO REMOVE BEFORE WRITING
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
        if (clock_mode == CLOCK_12H) {
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