
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proj1Compiler.c,35 :: 		void interrupt() {
;Proj1Compiler.c,36 :: 		INTCON.f7 = 0; // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,40 :: 		if (INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Proj1Compiler.c,42 :: 		tmr0Count++;
	INCF       _tmr0Count+0, 1
;Proj1Compiler.c,44 :: 		if (tmr0Count >= 76) {
	MOVLW      76
	SUBWF      _tmr0Count+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt1
;Proj1Compiler.c,45 :: 		tmr0Count = 0;
	CLRF       _tmr0Count+0
;Proj1Compiler.c,46 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Proj1Compiler.c,47 :: 		}
L_interrupt1:
;Proj1Compiler.c,49 :: 		TMR0 = 0; // Load the TMR0 register
	CLRF       TMR0+0
;Proj1Compiler.c,50 :: 		INTCON.f2 = 0; // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,51 :: 		}
L_interrupt0:
;Proj1Compiler.c,53 :: 		INTCON.f7 = 1; // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,54 :: 		}
L_end_interrupt:
L__interrupt9:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_updateHoursTens:

;Proj1Compiler.c,56 :: 		int updateHoursTens() {
;Proj1Compiler.c,57 :: 		hoursTens = (hours/10)%10; // Get the tens digit of hours
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hours+0, 0
	MOVWF      R0+0
	MOVF       _hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _hoursTens+0
	MOVF       R0+1, 0
	MOVWF      _hoursTens+1
;Proj1Compiler.c,58 :: 		return hoursTens;
;Proj1Compiler.c,59 :: 		}
L_end_updateHoursTens:
	RETURN
; end of _updateHoursTens

_updateHoursOnes:

;Proj1Compiler.c,61 :: 		int updateHoursOnes() {
;Proj1Compiler.c,62 :: 		hoursOnes = hours%10; // Get the ones digit of hours
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hours+0, 0
	MOVWF      R0+0
	MOVF       _hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _hoursOnes+0
	MOVF       R0+1, 0
	MOVWF      _hoursOnes+1
;Proj1Compiler.c,63 :: 		return hoursOnes;
;Proj1Compiler.c,64 :: 		}
L_end_updateHoursOnes:
	RETURN
; end of _updateHoursOnes

_updateMinutesTens:

;Proj1Compiler.c,66 :: 		int updateMinutesTens() {
;Proj1Compiler.c,67 :: 		minutesTens = (minutes/10)%10; // Get the tens digit of minutes
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minutes+0, 0
	MOVWF      R0+0
	MOVF       _minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _minutesTens+0
	MOVF       R0+1, 0
	MOVWF      _minutesTens+1
;Proj1Compiler.c,68 :: 		return minutesTens;
;Proj1Compiler.c,69 :: 		}
L_end_updateMinutesTens:
	RETURN
; end of _updateMinutesTens

_updateMinutesOnes:

;Proj1Compiler.c,71 :: 		int updateMinutesOnes() {
;Proj1Compiler.c,72 :: 		minutesOnes = minutes%10; // Get the ones digit of minutes
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minutes+0, 0
	MOVWF      R0+0
	MOVF       _minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _minutesOnes+0
	MOVF       R0+1, 0
	MOVWF      _minutesOnes+1
;Proj1Compiler.c,73 :: 		return minutesOnes;
;Proj1Compiler.c,74 :: 		}
L_end_updateMinutesOnes:
	RETURN
; end of _updateMinutesOnes

_init:

;Proj1Compiler.c,76 :: 		void init() {
;Proj1Compiler.c,77 :: 		TRISC = 0x00; // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,78 :: 		TRISD = 0x00; // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,79 :: 		}
L_end_init:
	RETURN
; end of _init

_interruptInit:

;Proj1Compiler.c,81 :: 		void interruptInit() {
;Proj1Compiler.c,82 :: 		INTCON.f7 = 1; // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,83 :: 		INTCON.f6 = 1; // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,84 :: 		INTCON.f5 = 1; // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,85 :: 		OPTION_REG.f5 = 0; // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,86 :: 		OPTION_REG.f4 = 0; // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,87 :: 		OPTION_REG.f3 = 0; // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,89 :: 		OPTION_REG.f2 = 1;
	BSF        OPTION_REG+0, 2
;Proj1Compiler.c,90 :: 		OPTION_REG.f1 = 1;
	BSF        OPTION_REG+0, 1
;Proj1Compiler.c,91 :: 		OPTION_REG.f0 = 1;
	BSF        OPTION_REG+0, 0
;Proj1Compiler.c,93 :: 		TMR0 = 0; // Load the TMR0 register
	CLRF       TMR0+0
;Proj1Compiler.c,94 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_main:

;Proj1Compiler.c,96 :: 		void main() {
;Proj1Compiler.c,97 :: 		init();
	CALL       _init+0
;Proj1Compiler.c,98 :: 		interruptInit();
	CALL       _interruptInit+0
;Proj1Compiler.c,102 :: 		while(1) {
L_main2:
;Proj1Compiler.c,104 :: 		PORTC = dispDigit[i];
	MOVF       _i+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,105 :: 		PORTD = 0x01; // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,106 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
	NOP
	NOP
;Proj1Compiler.c,107 :: 		PORTC = dispDigit[j];
	MOVF       _j+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,108 :: 		PORTD = 0x02; // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,109 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;Proj1Compiler.c,110 :: 		PORTC = dispDigit[k];
	MOVF       _k+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,111 :: 		PORTD = 0x04; // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,112 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;Proj1Compiler.c,113 :: 		PORTC = dispDigit[l];
	MOVF       _l+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,114 :: 		PORTD = 0x08; // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,115 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;Proj1Compiler.c,117 :: 		updateHoursTens();
	CALL       _updateHoursTens+0
;Proj1Compiler.c,118 :: 		updateHoursOnes();
	CALL       _updateHoursOnes+0
;Proj1Compiler.c,119 :: 		updateMinutesTens();
	CALL       _updateMinutesTens+0
;Proj1Compiler.c,120 :: 		updateMinutesOnes();
	CALL       _updateMinutesOnes+0
;Proj1Compiler.c,122 :: 		i = hoursTens;
	MOVF       _hoursTens+0, 0
	MOVWF      _i+0
	MOVF       _hoursTens+1, 0
	MOVWF      _i+1
;Proj1Compiler.c,123 :: 		j = hoursOnes;
	MOVF       _hoursOnes+0, 0
	MOVWF      _j+0
	MOVF       _hoursOnes+1, 0
	MOVWF      _j+1
;Proj1Compiler.c,124 :: 		k = minutesTens;
	MOVF       _minutesTens+0, 0
	MOVWF      _k+0
	MOVF       _minutesTens+1, 0
	MOVWF      _k+1
;Proj1Compiler.c,125 :: 		l = minutesOnes;
	MOVF       _minutesOnes+0, 0
	MOVWF      _l+0
	MOVF       _minutesOnes+1, 0
	MOVWF      _l+1
;Proj1Compiler.c,136 :: 		}
	GOTO       L_main2
;Proj1Compiler.c,137 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
