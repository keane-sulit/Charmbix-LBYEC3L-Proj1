
_portInit:

;Proj1Compiler.c,47 :: 		void portInit() {
;Proj1Compiler.c,48 :: 		TRISC = 0x00;  // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,49 :: 		TRISD = 0x00;  // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,50 :: 		}
L_end_portInit:
	RETURN
; end of _portInit

_interruptInit:

;Proj1Compiler.c,52 :: 		void interruptInit() {
;Proj1Compiler.c,53 :: 		INTCON.f7 = 1;      // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,54 :: 		INTCON.f6 = 1;      // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,55 :: 		INTCON.f5 = 1;      // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,56 :: 		INTCON.f4 = 1;      // Enable RB0 External Interrupt Port Change Interrupt
	BSF        INTCON+0, 4
;Proj1Compiler.c,57 :: 		INTCON.f3 = 1;      // Enable RB Port Change Interrupt */
	BSF        INTCON+0, 3
;Proj1Compiler.c,58 :: 		OPTION_REG.f5 = 0;  // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,59 :: 		OPTION_REG.f4 = 0;  // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,60 :: 		OPTION_REG.f3 = 0;  // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,62 :: 		OPTION_REG.f2 = 0;
	BCF        OPTION_REG+0, 2
;Proj1Compiler.c,63 :: 		OPTION_REG.f1 = 1;
	BSF        OPTION_REG+0, 1
;Proj1Compiler.c,64 :: 		OPTION_REG.f0 = 1;
	BSF        OPTION_REG+0, 0
;Proj1Compiler.c,65 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_update:

;Proj1Compiler.c,67 :: 		void update() {
;Proj1Compiler.c,68 :: 		if ((clockMode == 0 || clockMode == 1) && clockState == 1) {
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update85
	MOVLW      0
	XORWF      _clockMode+0, 0
L__update85:
	BTFSC      STATUS+0, 2
	GOTO       L__update79
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update86
	MOVLW      1
	XORWF      _clockMode+0, 0
L__update86:
	BTFSC      STATUS+0, 2
	GOTO       L__update79
	GOTO       L_update4
L__update79:
	MOVLW      0
	XORWF      _clockState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update87
	MOVLW      1
	XORWF      _clockState+0, 0
L__update87:
	BTFSS      STATUS+0, 2
	GOTO       L_update4
L__update78:
;Proj1Compiler.c,69 :: 		return;
	GOTO       L_end_update
;Proj1Compiler.c,70 :: 		} else if ((clockMode == 0 || clockMode == 1) && clockState == 0) {
L_update4:
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update88
	MOVLW      0
	XORWF      _clockMode+0, 0
L__update88:
	BTFSC      STATUS+0, 2
	GOTO       L__update77
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update89
	MOVLW      1
	XORWF      _clockMode+0, 0
L__update89:
	BTFSC      STATUS+0, 2
	GOTO       L__update77
	GOTO       L_update10
L__update77:
	MOVLW      0
	XORWF      _clockState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update90
	MOVLW      0
	XORWF      _clockState+0, 0
L__update90:
	BTFSS      STATUS+0, 2
	GOTO       L_update10
L__update76:
;Proj1Compiler.c,71 :: 		if (seconds > 59) {
	MOVF       _seconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update91
	MOVF       _seconds+0, 0
	SUBLW      59
L__update91:
	BTFSC      STATUS+0, 0
	GOTO       L_update11
;Proj1Compiler.c,72 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,73 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,74 :: 		if (minutes > 59) {
	MOVF       _minutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update92
	MOVF       _minutes+0, 0
	SUBLW      59
L__update92:
	BTFSC      STATUS+0, 0
	GOTO       L_update12
;Proj1Compiler.c,75 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,76 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,77 :: 		}
L_update12:
;Proj1Compiler.c,78 :: 		}
L_update11:
;Proj1Compiler.c,79 :: 		} // TODO: Add incrementing
L_update10:
;Proj1Compiler.c,80 :: 		}
L_end_update:
	RETURN
; end of _update

_updateClockDisplay:

;Proj1Compiler.c,82 :: 		void updateClockDisplay(int num, int segIndex) {
;Proj1Compiler.c,83 :: 		switch (segIndex) {
	GOTO       L_updateClockDisplay13
;Proj1Compiler.c,84 :: 		case 0:
L_updateClockDisplay15:
;Proj1Compiler.c,85 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,86 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,87 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay16:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay16
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay16
;Proj1Compiler.c,88 :: 		break;
	GOTO       L_updateClockDisplay14
;Proj1Compiler.c,89 :: 		case 1:
L_updateClockDisplay17:
;Proj1Compiler.c,90 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,91 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,92 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay18:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay18
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay18
;Proj1Compiler.c,93 :: 		break;
	GOTO       L_updateClockDisplay14
;Proj1Compiler.c,94 :: 		case 2:
L_updateClockDisplay19:
;Proj1Compiler.c,95 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,96 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,97 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay20:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay20
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay20
;Proj1Compiler.c,98 :: 		break;
	GOTO       L_updateClockDisplay14
;Proj1Compiler.c,99 :: 		case 3:
L_updateClockDisplay21:
;Proj1Compiler.c,100 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,101 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,102 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay22:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay22
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay22
;Proj1Compiler.c,103 :: 		break;
	GOTO       L_updateClockDisplay14
;Proj1Compiler.c,104 :: 		}
L_updateClockDisplay13:
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay94
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay94:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay15
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay95
	MOVLW      1
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay95:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay17
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay96
	MOVLW      2
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay96:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay19
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay97
	MOVLW      3
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay97:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay21
L_updateClockDisplay14:
;Proj1Compiler.c,105 :: 		}
L_end_updateClockDisplay:
	RETURN
; end of _updateClockDisplay

_toggleClockTwelve:

;Proj1Compiler.c,107 :: 		void toggleClockTwelve(int hours, int minutes) {
;Proj1Compiler.c,108 :: 		if (0 < hours && hours < 13) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve99
	MOVF       FARG_toggleClockTwelve_hours+0, 0
	SUBLW      0
L__toggleClockTwelve99:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve25
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve100
	MOVLW      13
	SUBWF      FARG_toggleClockTwelve_hours+0, 0
L__toggleClockTwelve100:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve25
L__toggleClockTwelve80:
;Proj1Compiler.c,109 :: 		updateClockDisplay(hours / 10, 0);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwelve_hours+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwelve_hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,110 :: 		updateClockDisplay(hours % 10, 1);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwelve_hours+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwelve_hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,111 :: 		updateClockDisplay(minutes / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwelve_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwelve_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,112 :: 		updateClockDisplay(minutes % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwelve_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwelve_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,113 :: 		} else {
	GOTO       L_toggleClockTwelve26
L_toggleClockTwelve25:
;Proj1Compiler.c,114 :: 		updateClockDisplay(abs(hours - 12) / 10, 0);
	MOVLW      12
	SUBWF      FARG_toggleClockTwelve_hours+0, 0
	MOVWF      FARG_abs_a+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_toggleClockTwelve_hours+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,115 :: 		updateClockDisplay(abs(hours - 12) % 10, 1);
	MOVLW      12
	SUBWF      FARG_toggleClockTwelve_hours+0, 0
	MOVWF      FARG_abs_a+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_toggleClockTwelve_hours+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,116 :: 		updateClockDisplay(minutes / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwelve_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwelve_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,117 :: 		updateClockDisplay(minutes % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwelve_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwelve_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,118 :: 		}
L_toggleClockTwelve26:
;Proj1Compiler.c,119 :: 		}
L_end_toggleClockTwelve:
	RETURN
; end of _toggleClockTwelve

_toggleClockTwentyFour:

;Proj1Compiler.c,121 :: 		void toggleClockTwentyFour(int hours, int minutes) {
;Proj1Compiler.c,122 :: 		if (hours < 24) {
	MOVLW      128
	XORWF      FARG_toggleClockTwentyFour_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwentyFour102
	MOVLW      24
	SUBWF      FARG_toggleClockTwentyFour_hours+0, 0
L__toggleClockTwentyFour102:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwentyFour27
;Proj1Compiler.c,123 :: 		updateClockDisplay(hours / 10, 0);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwentyFour_hours+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwentyFour_hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,124 :: 		updateClockDisplay(hours % 10, 1);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwentyFour_hours+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwentyFour_hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,125 :: 		updateClockDisplay(minutes / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwentyFour_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwentyFour_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,126 :: 		updateClockDisplay(minutes % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwentyFour_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwentyFour_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,127 :: 		} else {
	GOTO       L_toggleClockTwentyFour28
L_toggleClockTwentyFour27:
;Proj1Compiler.c,128 :: 		updateClockDisplay(0, 0);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,129 :: 		updateClockDisplay(0, 1);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,130 :: 		updateClockDisplay(minutes / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwentyFour_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwentyFour_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,131 :: 		updateClockDisplay(minutes % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_toggleClockTwentyFour_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_toggleClockTwentyFour_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateClockDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateClockDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,132 :: 		}
L_toggleClockTwentyFour28:
;Proj1Compiler.c,133 :: 		}
L_end_toggleClockTwentyFour:
	RETURN
; end of _toggleClockTwentyFour

_displayClockTime:

;Proj1Compiler.c,135 :: 		void displayClockTime(int hours, int minutes, int clockMode) {
;Proj1Compiler.c,136 :: 		switch (clockMode) {
	GOTO       L_displayClockTime29
;Proj1Compiler.c,137 :: 		case 0:
L_displayClockTime31:
;Proj1Compiler.c,138 :: 		toggleClockTwelve(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwelve_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwelve_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwelve_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwelve_minutes+1
	CALL       _toggleClockTwelve+0
;Proj1Compiler.c,139 :: 		break;
	GOTO       L_displayClockTime30
;Proj1Compiler.c,140 :: 		case 1:
L_displayClockTime32:
;Proj1Compiler.c,141 :: 		toggleClockTwentyFour(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+1
	CALL       _toggleClockTwentyFour+0
;Proj1Compiler.c,142 :: 		break;
	GOTO       L_displayClockTime30
;Proj1Compiler.c,143 :: 		}
L_displayClockTime29:
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime104
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime104:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime31
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime105
	MOVLW      1
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime105:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime32
L_displayClockTime30:
;Proj1Compiler.c,144 :: 		}
L_end_displayClockTime:
	RETURN
; end of _displayClockTime

_updateStopWatchDisplay:

;Proj1Compiler.c,146 :: 		void updateStopWatchDisplay(int num, int segIndex) {
;Proj1Compiler.c,147 :: 		switch (segIndex) {
	GOTO       L_updateStopWatchDisplay33
;Proj1Compiler.c,148 :: 		case 0:
L_updateStopWatchDisplay35:
;Proj1Compiler.c,149 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,150 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,151 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay36:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay36
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay36
;Proj1Compiler.c,152 :: 		break;
	GOTO       L_updateStopWatchDisplay34
;Proj1Compiler.c,153 :: 		case 1:
L_updateStopWatchDisplay37:
;Proj1Compiler.c,154 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,155 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,156 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay38:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay38
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay38
;Proj1Compiler.c,157 :: 		break;
	GOTO       L_updateStopWatchDisplay34
;Proj1Compiler.c,158 :: 		case 2:
L_updateStopWatchDisplay39:
;Proj1Compiler.c,159 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,160 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,161 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay40:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay40
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay40
;Proj1Compiler.c,162 :: 		break;
	GOTO       L_updateStopWatchDisplay34
;Proj1Compiler.c,163 :: 		case 3:
L_updateStopWatchDisplay41:
;Proj1Compiler.c,164 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,165 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,166 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay42:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay42
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay42
;Proj1Compiler.c,167 :: 		break;
	GOTO       L_updateStopWatchDisplay34
;Proj1Compiler.c,168 :: 		}
L_updateStopWatchDisplay33:
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay107
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay107:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay35
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay108
	MOVLW      1
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay108:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay37
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay109
	MOVLW      2
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay109:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay39
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay110
	MOVLW      3
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay110:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay41
L_updateStopWatchDisplay34:
;Proj1Compiler.c,169 :: 		}
L_end_updateStopWatchDisplay:
	RETURN
; end of _updateStopWatchDisplay

_stopWatch:

;Proj1Compiler.c,171 :: 		void stopWatch(int minutes, int seconds) {
;Proj1Compiler.c,173 :: 		if (minutes < 100) {
	MOVLW      128
	XORWF      FARG_stopWatch_minutes+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stopWatch112
	MOVLW      100
	SUBWF      FARG_stopWatch_minutes+0, 0
L__stopWatch112:
	BTFSC      STATUS+0, 0
	GOTO       L_stopWatch43
;Proj1Compiler.c,174 :: 		updateStopWatchDisplay(minutes / 10, 0);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateStopWatchDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateStopWatchDisplay_num+1
	CLRF       FARG_updateStopWatchDisplay_segIndex+0
	CLRF       FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,175 :: 		updateStopWatchDisplay(minutes % 10, 1);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateStopWatchDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateStopWatchDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,176 :: 		updateStopWatchDisplay(seconds / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_seconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_seconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateStopWatchDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateStopWatchDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,177 :: 		updateStopWatchDisplay(seconds % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_seconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_seconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateStopWatchDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateStopWatchDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,178 :: 		} else {
	GOTO       L_stopWatch44
L_stopWatch43:
;Proj1Compiler.c,179 :: 		updateStopWatchDisplay(0, 0);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	CLRF       FARG_updateStopWatchDisplay_segIndex+0
	CLRF       FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,180 :: 		updateStopWatchDisplay(0, 1);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,181 :: 		updateStopWatchDisplay(seconds / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_seconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_seconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateStopWatchDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateStopWatchDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,182 :: 		updateStopWatchDisplay(seconds % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_seconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_seconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateStopWatchDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateStopWatchDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,183 :: 		}
L_stopWatch44:
;Proj1Compiler.c,184 :: 		}
L_end_stopWatch:
	RETURN
; end of _stopWatch

_displayStopWatchTime:

;Proj1Compiler.c,186 :: 		void displayStopWatchTime(int minutes, int seconds, int stopWatchMode) {
;Proj1Compiler.c,187 :: 		switch (stopWatchMode) {
	GOTO       L_displayStopWatchTime45
;Proj1Compiler.c,188 :: 		case 0:
L_displayStopWatchTime47:
;Proj1Compiler.c,190 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,191 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,192 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime48:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime48
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime48
;Proj1Compiler.c,193 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,194 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,195 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime49:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime49
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime49
;Proj1Compiler.c,196 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,197 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,198 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime50:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime50
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime50
;Proj1Compiler.c,199 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,200 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,201 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime51:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime51
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime51
;Proj1Compiler.c,202 :: 		break;
	GOTO       L_displayStopWatchTime46
;Proj1Compiler.c,203 :: 		case 1:
L_displayStopWatchTime52:
;Proj1Compiler.c,205 :: 		stopWatch(minutes, seconds);
	MOVF       FARG_displayStopWatchTime_minutes+0, 0
	MOVWF      FARG_stopWatch_minutes+0
	MOVF       FARG_displayStopWatchTime_minutes+1, 0
	MOVWF      FARG_stopWatch_minutes+1
	MOVF       FARG_displayStopWatchTime_seconds+0, 0
	MOVWF      FARG_stopWatch_seconds+0
	MOVF       FARG_displayStopWatchTime_seconds+1, 0
	MOVWF      FARG_stopWatch_seconds+1
	CALL       _stopWatch+0
;Proj1Compiler.c,206 :: 		break;
	GOTO       L_displayStopWatchTime46
;Proj1Compiler.c,207 :: 		}
L_displayStopWatchTime45:
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayStopWatchTime114
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+0, 0
L__displayStopWatchTime114:
	BTFSC      STATUS+0, 2
	GOTO       L_displayStopWatchTime47
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayStopWatchTime115
	MOVLW      1
	XORWF      FARG_displayStopWatchTime_stopWatchMode+0, 0
L__displayStopWatchTime115:
	BTFSC      STATUS+0, 2
	GOTO       L_displayStopWatchTime52
L_displayStopWatchTime46:
;Proj1Compiler.c,208 :: 		}
L_end_displayStopWatchTime:
	RETURN
; end of _displayStopWatchTime

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proj1Compiler.c,210 :: 		void interrupt() {
;Proj1Compiler.c,211 :: 		INTCON.f7 = 0;  // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,214 :: 		if (INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt53
;Proj1Compiler.c,215 :: 		if (tmr0Count == 2) {  // Change to 76 after simulation testing
	MOVF       _tmr0Count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt54
;Proj1Compiler.c,216 :: 		tmr0Count = 0;
	CLRF       _tmr0Count+0
;Proj1Compiler.c,218 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Proj1Compiler.c,219 :: 		update();
	CALL       _update+0
;Proj1Compiler.c,220 :: 		} else {
	GOTO       L_interrupt55
L_interrupt54:
;Proj1Compiler.c,221 :: 		tmr0Count++;
	INCF       _tmr0Count+0, 1
;Proj1Compiler.c,222 :: 		}
L_interrupt55:
;Proj1Compiler.c,223 :: 		INTCON.f2 = 0;  // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,224 :: 		}
L_interrupt53:
;Proj1Compiler.c,227 :: 		if (INTCON.f1 == 1) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt56
;Proj1Compiler.c,229 :: 		if (PORTB.f0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt57
;Proj1Compiler.c,230 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt58:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt58
	DECFSZ     R12+0, 1
	GOTO       L_interrupt58
	DECFSZ     R11+0, 1
	GOTO       L_interrupt58
	NOP
	NOP
;Proj1Compiler.c,231 :: 		}
L_interrupt57:
;Proj1Compiler.c,232 :: 		if (clockMode == 0) {
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt118
	MOVLW      0
	XORWF      _clockMode+0, 0
L__interrupt118:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt59
;Proj1Compiler.c,233 :: 		clockMode = 1;
	MOVLW      1
	MOVWF      _clockMode+0
	MOVLW      0
	MOVWF      _clockMode+1
;Proj1Compiler.c,234 :: 		} else {
	GOTO       L_interrupt60
L_interrupt59:
;Proj1Compiler.c,235 :: 		clockMode = 0;
	CLRF       _clockMode+0
	CLRF       _clockMode+1
;Proj1Compiler.c,236 :: 		}
L_interrupt60:
;Proj1Compiler.c,237 :: 		INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
	BCF        INTCON+0, 1
;Proj1Compiler.c,238 :: 		}
L_interrupt56:
;Proj1Compiler.c,241 :: 		if (INTCON.f0 == 1) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt61
;Proj1Compiler.c,243 :: 		if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 1) {
	BTFSC      PORTB+0, 4
	GOTO       L_interrupt64
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt64
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt64
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt64
L__interrupt81:
;Proj1Compiler.c,244 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt65:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt65
	DECFSZ     R12+0, 1
	GOTO       L_interrupt65
	DECFSZ     R11+0, 1
	GOTO       L_interrupt65
	NOP
	NOP
;Proj1Compiler.c,246 :: 		clockState++;
	INCF       _clockState+0, 1
	BTFSC      STATUS+0, 2
	INCF       _clockState+1, 1
;Proj1Compiler.c,247 :: 		if (clockState > 1) {
	MOVF       _clockState+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt119
	MOVF       _clockState+0, 0
	SUBLW      1
L__interrupt119:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt66
;Proj1Compiler.c,248 :: 		clockState = 0;
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,249 :: 		}
L_interrupt66:
;Proj1Compiler.c,250 :: 		}
L_interrupt64:
;Proj1Compiler.c,277 :: 		INTCON.f0 = 0;  // Clear RB Port Change Interrupt Flag
	BCF        INTCON+0, 0
;Proj1Compiler.c,278 :: 		}
L_interrupt61:
;Proj1Compiler.c,279 :: 		INTCON.f7 = 1;  // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,280 :: 		}
L_end_interrupt:
L__interrupt117:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Proj1Compiler.c,282 :: 		void main() {
;Proj1Compiler.c,283 :: 		portInit();
	CALL       _portInit+0
;Proj1Compiler.c,284 :: 		interruptInit();
	CALL       _interruptInit+0
;Proj1Compiler.c,286 :: 		while (1) {
L_main67:
;Proj1Compiler.c,287 :: 		if (sysMode == 0) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main121
	MOVLW      0
	XORWF      _sysMode+0, 0
L__main121:
	BTFSS      STATUS+0, 2
	GOTO       L_main69
;Proj1Compiler.c,288 :: 		displayClockTime(hours, minutes, clockMode);
	MOVF       _hours+0, 0
	MOVWF      FARG_displayClockTime_hours+0
	MOVF       _hours+1, 0
	MOVWF      FARG_displayClockTime_hours+1
	MOVF       _minutes+0, 0
	MOVWF      FARG_displayClockTime_minutes+0
	MOVF       _minutes+1, 0
	MOVWF      FARG_displayClockTime_minutes+1
	MOVF       _clockMode+0, 0
	MOVWF      FARG_displayClockTime_clockMode+0
	MOVF       _clockMode+1, 0
	MOVWF      FARG_displayClockTime_clockMode+1
	CALL       _displayClockTime+0
;Proj1Compiler.c,289 :: 		} else if (sysMode == 1) {
	GOTO       L_main70
L_main69:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main122
	MOVLW      1
	XORWF      _sysMode+0, 0
L__main122:
	BTFSS      STATUS+0, 2
	GOTO       L_main71
;Proj1Compiler.c,291 :: 		displayStopWatchTime(minutes, seconds, stopWatchMode);
	MOVF       _minutes+0, 0
	MOVWF      FARG_displayStopWatchTime_minutes+0
	MOVF       _minutes+1, 0
	MOVWF      FARG_displayStopWatchTime_minutes+1
	MOVF       _seconds+0, 0
	MOVWF      FARG_displayStopWatchTime_seconds+0
	MOVF       _seconds+1, 0
	MOVWF      FARG_displayStopWatchTime_seconds+1
	MOVF       _stopWatchMode+0, 0
	MOVWF      FARG_displayStopWatchTime_stopWatchMode+0
	MOVF       _stopWatchMode+1, 0
	MOVWF      FARG_displayStopWatchTime_stopWatchMode+1
	CALL       _displayStopWatchTime+0
;Proj1Compiler.c,292 :: 		} else if (sysMode == 2) {
	GOTO       L_main72
L_main71:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main123
	MOVLW      2
	XORWF      _sysMode+0, 0
L__main123:
	BTFSS      STATUS+0, 2
	GOTO       L_main73
;Proj1Compiler.c,294 :: 		} else if (sysMode == 3) {
	GOTO       L_main74
L_main73:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main124
	MOVLW      3
	XORWF      _sysMode+0, 0
L__main124:
	BTFSS      STATUS+0, 2
	GOTO       L_main75
;Proj1Compiler.c,296 :: 		}
L_main75:
L_main74:
L_main72:
L_main70:
;Proj1Compiler.c,297 :: 		}
	GOTO       L_main67
;Proj1Compiler.c,298 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
