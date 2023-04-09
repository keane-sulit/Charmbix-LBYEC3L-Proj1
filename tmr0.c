int count = 0;

// Interrupt Service Routine
void interrupt() {
    INTCON.f7 = 0; // Disable Global Interrupt

    if (INTCON.f1 == 1) {
        PORTC.f0 = ~PORTC.f0;   // Toggle LED
        INTCON.f1 = 0; // Clear INT0 Interrupt Flag
    }

    else if (INTCON.f2 == 1) {
        if (count == 76) {           // Switch LED every 1 second (76*13ms approx. 1s)
            // Toggle LED
            PORTC.f0= !PORTC.f0;
            PORTC.f1 = !PORTC.f1;
            count = 0;
        }
        else {
            count++;
        }
        INTCON.f2 = 0; // Clear TMR0 Interrupt Flag
    }
    INTCON.f7 = 1; // Enable Global Interrupt
}

void init() {
    TRISC = 0x00; // PORTC is the data bus
    INTCON.f7 = 1; // Enable Global Interrupt
    INTCON.f6 = 1; // Enable Peripheral Interrupt
    INTCON.f5 = 1; // Enable TMR0 Interrupt
    INTCON.f4 = 1; // External Interrupt Edge Select bit (1 = falling edge)
    OPTION_REG.f5 = 0; // Internal Instruction Cycle Clock (CLKO)
    OPTION_REG.f3 = 0; // Prescaler is assigned to the Timer0 module
    OPTION_REG.f2 = 1; // Prescaler Rate Select bits (111 = 1:256)
    OPTION_REG.f1 = 1;
    OPTION_REG.f0 = 1;
}

void main() {
    init();
    while(1) {
    }
}