
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proj1Compiler.c,27 :: 		void interrupt() {
;Proj1Compiler.c,28 :: 		INTCON.f7 = 0; // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,29 :: 		if (INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Proj1Compiler.c,30 :: 		if (timerCount >= 5) {
	MOVLW      5
	SUBWF      _timerCount+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt1
;Proj1Compiler.c,31 :: 		timerCount = 0;
	CLRF       _timerCount+0
;Proj1Compiler.c,32 :: 		}
L_interrupt1:
;Proj1Compiler.c,34 :: 		if (timerCount == 1) {
	MOVF       _timerCount+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;Proj1Compiler.c,35 :: 		PORTD = 0x01; // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,36 :: 		PORTC = dispDigit[i];
	MOVF       _i+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,37 :: 		}
L_interrupt2:
;Proj1Compiler.c,38 :: 		if (timerCount == 2) {
	MOVF       _timerCount+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;Proj1Compiler.c,39 :: 		PORTD = 0x02; // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,40 :: 		PORTC = dispDigit[j];
	MOVF       _j+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,41 :: 		}
L_interrupt3:
;Proj1Compiler.c,42 :: 		if (timerCount == 3) {
	MOVF       _timerCount+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;Proj1Compiler.c,43 :: 		PORTD = 0x04; // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,44 :: 		PORTC = dispDigit[k];
	MOVF       _k+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,45 :: 		}
L_interrupt4:
;Proj1Compiler.c,46 :: 		if (timerCount == 4) {
	MOVF       _timerCount+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
;Proj1Compiler.c,47 :: 		PORTD = 0x08; // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,48 :: 		PORTC = dispDigit[l];
	MOVF       _l+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,49 :: 		}
L_interrupt5:
;Proj1Compiler.c,51 :: 		timerCount++;
	INCF       _timerCount+0, 1
;Proj1Compiler.c,52 :: 		INTCON.f2 = 0; // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,53 :: 		}
L_interrupt0:
;Proj1Compiler.c,55 :: 		INTCON.f7 = 1; // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,56 :: 		}
L_end_interrupt:
L__interrupt12:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_init:

;Proj1Compiler.c,58 :: 		void init() {
;Proj1Compiler.c,59 :: 		TRISC = 0x00; // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,60 :: 		TRISD = 0x00; // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,61 :: 		}
L_end_init:
	RETURN
; end of _init

_interruptInit:

;Proj1Compiler.c,63 :: 		void interruptInit() {
;Proj1Compiler.c,64 :: 		INTCON.f7 = 1; // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,65 :: 		INTCON.f6 = 1; // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,66 :: 		INTCON.f5 = 1; // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,67 :: 		OPTION_REG.f5 = 0; // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,68 :: 		OPTION_REG.f4 = 0; // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,69 :: 		OPTION_REG.f3 = 0; // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,71 :: 		OPTION_REG.f2 = 1;
	BSF        OPTION_REG+0, 2
;Proj1Compiler.c,72 :: 		OPTION_REG.f1 = 1;
	BSF        OPTION_REG+0, 1
;Proj1Compiler.c,73 :: 		OPTION_REG.f0 = 1;
	BSF        OPTION_REG+0, 0
;Proj1Compiler.c,75 :: 		TMR0 = 59; // Load the TMR0 register
	MOVLW      59
	MOVWF      TMR0+0
;Proj1Compiler.c,76 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_main:

;Proj1Compiler.c,78 :: 		void main() {
;Proj1Compiler.c,79 :: 		init();
	CALL       _init+0
;Proj1Compiler.c,80 :: 		interruptInit();
	CALL       _interruptInit+0
;Proj1Compiler.c,81 :: 		while(1) {
L_main6:
;Proj1Compiler.c,82 :: 		i = hours/10; // Get the tens digit of hours
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hours+0, 0
	MOVWF      R0+0
	MOVF       _hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _i+0
	MOVF       R0+1, 0
	MOVWF      _i+1
;Proj1Compiler.c,83 :: 		j = hours%10; // Get the ones digit of hours
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
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
;Proj1Compiler.c,84 :: 		k = minutes/10; // Get the tens digit of minutes
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minutes+0, 0
	MOVWF      R0+0
	MOVF       _minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      _k+0
	MOVF       R0+1, 0
	MOVWF      _k+1
;Proj1Compiler.c,85 :: 		l = minutes%10; // Get the ones digit of minutes
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
	MOVWF      _l+0
	MOVF       R0+1, 0
	MOVWF      _l+1
;Proj1Compiler.c,87 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,88 :: 		if (minutes == 60) {
	MOVLW      0
	XORWF      _minutes+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      60
	XORWF      _minutes+0, 0
L__main16:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;Proj1Compiler.c,89 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,90 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,91 :: 		if (hours == 13) {
	MOVLW      0
	XORWF      _hours+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      13
	XORWF      _hours+0, 0
L__main17:
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;Proj1Compiler.c,92 :: 		hours = 1;
	MOVLW      1
	MOVWF      _hours+0
	MOVLW      0
	MOVWF      _hours+1
;Proj1Compiler.c,93 :: 		}
L_main9:
;Proj1Compiler.c,94 :: 		}
L_main8:
;Proj1Compiler.c,95 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
;Proj1Compiler.c,96 :: 		}
	GOTO       L_main6
;Proj1Compiler.c,97 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
