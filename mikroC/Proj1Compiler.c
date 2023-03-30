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

unsigned int i = 0;
unsigned int j = 0;
unsigned int k = 0;
unsigned int l = 0;

unsigned int hours = 11;
unsigned int minutes = 59;

unsigned char timerCount = 0;
char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};

void interrupt() {
    INTCON.f7 = 0; // Disable Global Interrupt
   if (INTCON.f2 == 1) {
        if (timerCount >= 5) {
            timerCount = 0;
        }

        if (timerCount == 1) {
            PORTD = 0x01; // Select the first digit
            PORTC = dispDigit[i];
        }
        if (timerCount == 2) {
            PORTD = 0x02; // Select the second digit
            PORTC = dispDigit[j];
        }
        if (timerCount == 3) {
            PORTD = 0x04; // Select the third digit
            PORTC = dispDigit[k];
        }
        if (timerCount == 4) {
            PORTD = 0x08; // Select the fourth digit
            PORTC = dispDigit[l];
        }

        timerCount++;
        INTCON.f2 = 0; // Clear TMR0 Interrupt Flag
   }

    INTCON.f7 = 1; // Enable Global Interrupt
}

void init() {
    TRISC = 0x00; // PORTC is the data bus
    TRISD = 0x00; // PORTD is the address bus
}

void interruptInit() {
    INTCON.f7 = 1; // Enable Global Interrupt
    INTCON.f6 = 1; // Enable Peripheral Interrupt
    INTCON.f5 = 1; // Enable TMR0 Interrupt
    OPTION_REG.f5 = 0; // Internal Instruction Cycle Clock (CLKO)
    OPTION_REG.f4 = 0; // Increment on Low-to-High Transition on T0CKI Pin
    OPTION_REG.f3 = 0; // Prescaler is assigned to the Timer0 module
    // Prescaler Rate Select bits (111 = 1:256)
    OPTION_REG.f2 = 1;
    OPTION_REG.f1 = 1;
    OPTION_REG.f0 = 1;

    TMR0 = 59; // Load the TMR0 register
}

void main() {
    init();
    interruptInit();
    while(1) {
        i = hours/10; // Get the tens digit of hours
        j = hours%10; // Get the ones digit of hours
        k = minutes/10; // Get the tens digit of minutes
        l = minutes%10; // Get the ones digit of minutes

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