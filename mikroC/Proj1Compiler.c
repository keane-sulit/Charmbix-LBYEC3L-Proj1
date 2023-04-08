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

unsigned int hoursTens = 0;
unsigned int hoursOnes = 0;
unsigned int minutesTens = 0;
unsigned int minutesOnes = 0;

unsigned int seconds = 0;

unsigned int hoursFlag = 0; // 0 = 12 hour mode, 1 = 24 hour mode

// Variables to adjust time
unsigned int hours = 12;
unsigned int minutes = 50;

unsigned char tmr0Count = 0; // Increments every 13.107ms

char dispDigit[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};

void interrupt()
{
    INTCON.f7 = 0; // Disable Global Interrupt

    // ISR for TMR0
    if (INTCON.f2 == 1)
    {
        if (tmr0Count == 2)
        { // Change to 76 after simulation testing
            tmr0Count = 0;
            // Update time after 1 minute
            seconds++;
            if (seconds > 59)
            {
                seconds = 0;
                minutes++;
                if (minutes > 59)
                {
                    minutes = 0;
                    hours++;

                    // Toggle between 12 and 24 hour mode
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
        INTCON.f2 = 0; // Clear TMR0 Interrupt Flag
    }

    // ISR for RB0 External Interrupt
    // ISR for RB0 External Interrupt
    if (INTCON.f1 == 1)
    {

        hoursFlag = ~hoursFlag; // Toggle between 12 and 24 hour mode
        INTCON.f1 = 0;          // Clear RB0 External Interrupt Flag
    }

    INTCON.f7 = 1; // Enable Global Interrupt
}

int updateHoursTens()
{
    hoursTens = hours / 10; // Get the tens digit of hours
    return hoursTens;
}

int updateHoursOnes()
{
    hoursOnes = hours % 10; // Get the ones digit of hours
    return hoursOnes;
}

int updateMinutesTens()
{
    minutesTens = minutes / 10; // Get the tens digit of minutes
    return minutesTens;
}

int updateMinutesOnes()
{
    minutesOnes = minutes % 10; // Get the ones digit of minutes
    return minutesOnes;
}

void portInit()
{
    TRISC = 0x00; // PORTC is the data bus
    TRISD = 0x00; // PORTD is the address bus
}

void interruptInit()
{
    INTCON.f7 = 1; // Enable Global Interrupt
    INTCON.f6 = 1; // Enable Peripheral Interrupt
    INTCON.f5 = 1; // Enable TMR0 Interrupt
    INTCON.f4 = 1; // Enable RB0 External Interrupt Port Change Interrupt
    /*INTCON.f3 = 1; // Enable RB Port Change Interrupt */
    OPTION_REG.f5 = 0; // Internal Instruction Cycle Clock (CLKO)
    OPTION_REG.f4 = 0; // Increment on Low-to-High Transition on T0CKI Pin
    OPTION_REG.f3 = 0; // Prescaler is assigned to the Timer0 module
    // Prescaler Rate Select bits (111 = 1:256)
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
        PORTD = 0x01; // Select the first digit
        PORTC = dispDigit[i];
        delay_ms(1);
        PORTD = 0x02; // Select the second digit
        PORTC = dispDigit[j];
        delay_ms(1);
        PORTD = 0x04; // Select the third digit
        PORTC = dispDigit[k];
        delay_ms(1);
        PORTD = 0x08; // Select the fourth digit
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
    }
}