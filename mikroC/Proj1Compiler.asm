
_portInit:

;Proj1Compiler.c,43 :: 		void portInit() {
;Proj1Compiler.c,44 :: 		TRISC = 0x00;  // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,45 :: 		TRISD = 0x00;  // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,46 :: 		}
L_end_portInit:
	RETURN
; end of _portInit

_interruptInit:

;Proj1Compiler.c,48 :: 		void interruptInit() {
;Proj1Compiler.c,49 :: 		INTCON.f7 = 1;      // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,50 :: 		INTCON.f6 = 1;      // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,51 :: 		INTCON.f5 = 1;      // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,52 :: 		INTCON.f4 = 1;      // Enable RB0 External Interrupt Port Change Interrupt
	BSF        INTCON+0, 4
;Proj1Compiler.c,53 :: 		INTCON.f3 = 1;      // Enable RB Port Change Interrupt */
	BSF        INTCON+0, 3
;Proj1Compiler.c,54 :: 		OPTION_REG.f5 = 0;  // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,55 :: 		OPTION_REG.f4 = 0;  // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,56 :: 		OPTION_REG.f3 = 0;  // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,58 :: 		OPTION_REG.f2 = 0;
	BCF        OPTION_REG+0, 2
;Proj1Compiler.c,59 :: 		OPTION_REG.f1 = 1;
	BSF        OPTION_REG+0, 1
;Proj1Compiler.c,60 :: 		OPTION_REG.f0 = 1;
	BSF        OPTION_REG+0, 0
;Proj1Compiler.c,61 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_update:

;Proj1Compiler.c,63 :: 		void update() {
;Proj1Compiler.c,64 :: 		if (seconds > 59) {
	MOVF       _seconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update78
	MOVF       _seconds+0, 0
	SUBLW      59
L__update78:
	BTFSC      STATUS+0, 0
	GOTO       L_update0
;Proj1Compiler.c,65 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,66 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,67 :: 		if (minutes > 59) {
	MOVF       _minutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update79
	MOVF       _minutes+0, 0
	SUBLW      59
L__update79:
	BTFSC      STATUS+0, 0
	GOTO       L_update1
;Proj1Compiler.c,68 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,69 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,70 :: 		}
L_update1:
;Proj1Compiler.c,71 :: 		}
L_update0:
;Proj1Compiler.c,72 :: 		}
L_end_update:
	RETURN
; end of _update

_updateClockDisplay:

;Proj1Compiler.c,74 :: 		void updateClockDisplay(int num, int segIndex) {
;Proj1Compiler.c,75 :: 		switch (segIndex) {
	GOTO       L_updateClockDisplay2
;Proj1Compiler.c,76 :: 		case 0:
L_updateClockDisplay4:
;Proj1Compiler.c,77 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,78 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,79 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay5:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay5
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay5
;Proj1Compiler.c,80 :: 		break;
	GOTO       L_updateClockDisplay3
;Proj1Compiler.c,81 :: 		case 1:
L_updateClockDisplay6:
;Proj1Compiler.c,82 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,83 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,84 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay7:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay7
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay7
;Proj1Compiler.c,85 :: 		break;
	GOTO       L_updateClockDisplay3
;Proj1Compiler.c,86 :: 		case 2:
L_updateClockDisplay8:
;Proj1Compiler.c,87 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,88 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,89 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay9:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay9
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay9
;Proj1Compiler.c,90 :: 		break;
	GOTO       L_updateClockDisplay3
;Proj1Compiler.c,91 :: 		case 3:
L_updateClockDisplay10:
;Proj1Compiler.c,92 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,93 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,94 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay11:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay11
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay11
;Proj1Compiler.c,95 :: 		break;
	GOTO       L_updateClockDisplay3
;Proj1Compiler.c,96 :: 		}
L_updateClockDisplay2:
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay81
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay81:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay4
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay82
	MOVLW      1
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay82:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay6
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay83
	MOVLW      2
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay83:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay8
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay84
	MOVLW      3
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay84:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay10
L_updateClockDisplay3:
;Proj1Compiler.c,97 :: 		}
L_end_updateClockDisplay:
	RETURN
; end of _updateClockDisplay

_toggleClockTwelve:

;Proj1Compiler.c,99 :: 		void toggleClockTwelve(int hours, int minutes) {
;Proj1Compiler.c,100 :: 		if (0 < hours && hours < 13) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve86
	MOVF       FARG_toggleClockTwelve_hours+0, 0
	SUBLW      0
L__toggleClockTwelve86:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve14
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve87
	MOVLW      13
	SUBWF      FARG_toggleClockTwelve_hours+0, 0
L__toggleClockTwelve87:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve14
L__toggleClockTwelve72:
;Proj1Compiler.c,101 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,102 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,103 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,104 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,105 :: 		} else {
	GOTO       L_toggleClockTwelve15
L_toggleClockTwelve14:
;Proj1Compiler.c,106 :: 		updateClockDisplay(abs(hours - 12) / 10, 0);
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
;Proj1Compiler.c,107 :: 		updateClockDisplay(abs(hours - 12) % 10, 1);
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
;Proj1Compiler.c,108 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,109 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,110 :: 		}
L_toggleClockTwelve15:
;Proj1Compiler.c,111 :: 		}
L_end_toggleClockTwelve:
	RETURN
; end of _toggleClockTwelve

_toggleClockTwentyFour:

;Proj1Compiler.c,113 :: 		void toggleClockTwentyFour(int hours, int minutes) {
;Proj1Compiler.c,114 :: 		if (hours < 24) {
	MOVLW      128
	XORWF      FARG_toggleClockTwentyFour_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwentyFour89
	MOVLW      24
	SUBWF      FARG_toggleClockTwentyFour_hours+0, 0
L__toggleClockTwentyFour89:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwentyFour16
;Proj1Compiler.c,115 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,116 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,117 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,118 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,119 :: 		} else {
	GOTO       L_toggleClockTwentyFour17
L_toggleClockTwentyFour16:
;Proj1Compiler.c,120 :: 		updateClockDisplay(0, 0);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,121 :: 		updateClockDisplay(0, 1);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,122 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,123 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,124 :: 		}
L_toggleClockTwentyFour17:
;Proj1Compiler.c,125 :: 		}
L_end_toggleClockTwentyFour:
	RETURN
; end of _toggleClockTwentyFour

_displayClockTime:

;Proj1Compiler.c,127 :: 		void displayClockTime(int hours, int minutes, int clockMode) {
;Proj1Compiler.c,128 :: 		switch (clockMode) {
	GOTO       L_displayClockTime18
;Proj1Compiler.c,129 :: 		case 0:
L_displayClockTime20:
;Proj1Compiler.c,130 :: 		toggleClockTwelve(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwelve_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwelve_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwelve_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwelve_minutes+1
	CALL       _toggleClockTwelve+0
;Proj1Compiler.c,131 :: 		break;
	GOTO       L_displayClockTime19
;Proj1Compiler.c,132 :: 		case 1:
L_displayClockTime21:
;Proj1Compiler.c,133 :: 		toggleClockTwentyFour(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+1
	CALL       _toggleClockTwentyFour+0
;Proj1Compiler.c,134 :: 		break;
	GOTO       L_displayClockTime19
;Proj1Compiler.c,135 :: 		}
L_displayClockTime18:
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime91
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime91:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime20
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime92
	MOVLW      1
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime92:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime21
L_displayClockTime19:
;Proj1Compiler.c,136 :: 		}
L_end_displayClockTime:
	RETURN
; end of _displayClockTime

_updateStopWatchDisplay:

;Proj1Compiler.c,138 :: 		void updateStopWatchDisplay(int num, int segIndex) {
;Proj1Compiler.c,139 :: 		switch (segIndex) {
	GOTO       L_updateStopWatchDisplay22
;Proj1Compiler.c,140 :: 		case 0:
L_updateStopWatchDisplay24:
;Proj1Compiler.c,141 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,142 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,143 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay25:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay25
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay25
;Proj1Compiler.c,144 :: 		break;
	GOTO       L_updateStopWatchDisplay23
;Proj1Compiler.c,145 :: 		case 1:
L_updateStopWatchDisplay26:
;Proj1Compiler.c,146 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,147 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,148 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay27:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay27
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay27
;Proj1Compiler.c,149 :: 		break;
	GOTO       L_updateStopWatchDisplay23
;Proj1Compiler.c,150 :: 		case 2:
L_updateStopWatchDisplay28:
;Proj1Compiler.c,151 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,152 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,153 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay29:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay29
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay29
;Proj1Compiler.c,154 :: 		break;
	GOTO       L_updateStopWatchDisplay23
;Proj1Compiler.c,155 :: 		case 3:
L_updateStopWatchDisplay30:
;Proj1Compiler.c,156 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,157 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,158 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay31:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay31
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay31
;Proj1Compiler.c,159 :: 		break;
	GOTO       L_updateStopWatchDisplay23
;Proj1Compiler.c,160 :: 		}
L_updateStopWatchDisplay22:
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay94
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay94:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay24
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay95
	MOVLW      1
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay95:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay26
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay96
	MOVLW      2
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay96:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay28
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay97
	MOVLW      3
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay97:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay30
L_updateStopWatchDisplay23:
;Proj1Compiler.c,161 :: 		}
L_end_updateStopWatchDisplay:
	RETURN
; end of _updateStopWatchDisplay

_stopWatch:

;Proj1Compiler.c,163 :: 		void stopWatch(int minutes, int seconds) {
;Proj1Compiler.c,165 :: 		if (minutes < 100) {
	MOVLW      128
	XORWF      FARG_stopWatch_minutes+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stopWatch99
	MOVLW      100
	SUBWF      FARG_stopWatch_minutes+0, 0
L__stopWatch99:
	BTFSC      STATUS+0, 0
	GOTO       L_stopWatch32
;Proj1Compiler.c,166 :: 		updateStopWatchDisplay(minutes / 10, 0);
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
;Proj1Compiler.c,167 :: 		updateStopWatchDisplay(minutes % 10, 1);
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
;Proj1Compiler.c,168 :: 		updateStopWatchDisplay(seconds / 10, 2);
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
;Proj1Compiler.c,169 :: 		updateStopWatchDisplay(seconds % 10, 3);
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
;Proj1Compiler.c,170 :: 		} else {
	GOTO       L_stopWatch33
L_stopWatch32:
;Proj1Compiler.c,171 :: 		updateStopWatchDisplay(0, 0);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	CLRF       FARG_updateStopWatchDisplay_segIndex+0
	CLRF       FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,172 :: 		updateStopWatchDisplay(0, 1);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,173 :: 		updateStopWatchDisplay(seconds / 10, 2);
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
;Proj1Compiler.c,174 :: 		updateStopWatchDisplay(seconds % 10, 3);
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
;Proj1Compiler.c,175 :: 		}
L_stopWatch33:
;Proj1Compiler.c,176 :: 		}
L_end_stopWatch:
	RETURN
; end of _stopWatch

_displayStopWatchTime:

;Proj1Compiler.c,178 :: 		void displayStopWatchTime(int minutes, int seconds, int stopWatchMode) {
;Proj1Compiler.c,179 :: 		switch (stopWatchMode) {
	GOTO       L_displayStopWatchTime34
;Proj1Compiler.c,180 :: 		case 0:
L_displayStopWatchTime36:
;Proj1Compiler.c,182 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,183 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,184 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime37:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime37
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime37
;Proj1Compiler.c,185 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,186 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,187 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime38:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime38
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime38
;Proj1Compiler.c,188 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,189 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,190 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime39:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime39
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime39
;Proj1Compiler.c,191 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,192 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,193 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime40:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime40
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime40
;Proj1Compiler.c,194 :: 		break;
	GOTO       L_displayStopWatchTime35
;Proj1Compiler.c,195 :: 		case 1:
L_displayStopWatchTime41:
;Proj1Compiler.c,197 :: 		stopWatch(minutes, seconds);
	MOVF       FARG_displayStopWatchTime_minutes+0, 0
	MOVWF      FARG_stopWatch_minutes+0
	MOVF       FARG_displayStopWatchTime_minutes+1, 0
	MOVWF      FARG_stopWatch_minutes+1
	MOVF       FARG_displayStopWatchTime_seconds+0, 0
	MOVWF      FARG_stopWatch_seconds+0
	MOVF       FARG_displayStopWatchTime_seconds+1, 0
	MOVWF      FARG_stopWatch_seconds+1
	CALL       _stopWatch+0
;Proj1Compiler.c,198 :: 		break;
	GOTO       L_displayStopWatchTime35
;Proj1Compiler.c,199 :: 		}
L_displayStopWatchTime34:
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayStopWatchTime101
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+0, 0
L__displayStopWatchTime101:
	BTFSC      STATUS+0, 2
	GOTO       L_displayStopWatchTime36
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayStopWatchTime102
	MOVLW      1
	XORWF      FARG_displayStopWatchTime_stopWatchMode+0, 0
L__displayStopWatchTime102:
	BTFSC      STATUS+0, 2
	GOTO       L_displayStopWatchTime41
L_displayStopWatchTime35:
;Proj1Compiler.c,200 :: 		}
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

;Proj1Compiler.c,202 :: 		void interrupt() {
;Proj1Compiler.c,203 :: 		INTCON.f7 = 0;  // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,206 :: 		if (INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt42
;Proj1Compiler.c,207 :: 		if (tmr0Count == 2) {  // Change to 76 after simulation testing
	MOVF       _tmr0Count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt43
;Proj1Compiler.c,208 :: 		tmr0Count = 0;
	CLRF       _tmr0Count+0
;Proj1Compiler.c,210 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Proj1Compiler.c,211 :: 		update();
	CALL       _update+0
;Proj1Compiler.c,212 :: 		} else {
	GOTO       L_interrupt44
L_interrupt43:
;Proj1Compiler.c,213 :: 		tmr0Count++;
	INCF       _tmr0Count+0, 1
;Proj1Compiler.c,214 :: 		}
L_interrupt44:
;Proj1Compiler.c,215 :: 		INTCON.f2 = 0;  // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,216 :: 		}
L_interrupt42:
;Proj1Compiler.c,219 :: 		if (INTCON.f1 == 1) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt45
;Proj1Compiler.c,221 :: 		if (PORTB.f0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt46
;Proj1Compiler.c,222 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt47:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt47
	DECFSZ     R12+0, 1
	GOTO       L_interrupt47
	DECFSZ     R11+0, 1
	GOTO       L_interrupt47
	NOP
	NOP
;Proj1Compiler.c,223 :: 		}
L_interrupt46:
;Proj1Compiler.c,224 :: 		if (clockMode == 0) {
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt105
	MOVLW      0
	XORWF      _clockMode+0, 0
L__interrupt105:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt48
;Proj1Compiler.c,225 :: 		clockMode = 1;
	MOVLW      1
	MOVWF      _clockMode+0
	MOVLW      0
	MOVWF      _clockMode+1
;Proj1Compiler.c,226 :: 		} else {
	GOTO       L_interrupt49
L_interrupt48:
;Proj1Compiler.c,227 :: 		clockMode = 0;
	CLRF       _clockMode+0
	CLRF       _clockMode+1
;Proj1Compiler.c,228 :: 		}
L_interrupt49:
;Proj1Compiler.c,229 :: 		INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
	BCF        INTCON+0, 1
;Proj1Compiler.c,230 :: 		}
L_interrupt45:
;Proj1Compiler.c,233 :: 		if (INTCON.f3 == 1) {
	BTFSS      INTCON+0, 3
	GOTO       L_interrupt50
;Proj1Compiler.c,235 :: 		if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 1) {
	BTFSC      PORTB+0, 4
	GOTO       L_interrupt53
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt53
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt53
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt53
L__interrupt74:
;Proj1Compiler.c,236 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt54:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt54
	DECFSZ     R12+0, 1
	GOTO       L_interrupt54
	DECFSZ     R11+0, 1
	GOTO       L_interrupt54
	NOP
	NOP
;Proj1Compiler.c,237 :: 		sysMode++;
	INCF       _sysMode+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sysMode+1, 1
;Proj1Compiler.c,238 :: 		if (sysMode > 3) {
	MOVF       _sysMode+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt106
	MOVF       _sysMode+0, 0
	SUBLW      3
L__interrupt106:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt55
;Proj1Compiler.c,239 :: 		sysMode = 0;
	CLRF       _sysMode+0
	CLRF       _sysMode+1
;Proj1Compiler.c,240 :: 		} else if (sysMode == 1) {
	GOTO       L_interrupt56
L_interrupt55:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt107
	MOVLW      1
	XORWF      _sysMode+0, 0
L__interrupt107:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt57
;Proj1Compiler.c,241 :: 		if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 1) {
	BTFSC      PORTB+0, 4
	GOTO       L_interrupt60
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt60
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt60
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt60
L__interrupt73:
;Proj1Compiler.c,242 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt61:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt61
	DECFSZ     R12+0, 1
	GOTO       L_interrupt61
	DECFSZ     R11+0, 1
	GOTO       L_interrupt61
	NOP
	NOP
;Proj1Compiler.c,243 :: 		stopWatchMode++;
	INCF       _stopWatchMode+0, 1
	BTFSC      STATUS+0, 2
	INCF       _stopWatchMode+1, 1
;Proj1Compiler.c,244 :: 		if (stopWatchMode > 2) {
	MOVF       _stopWatchMode+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt108
	MOVF       _stopWatchMode+0, 0
	SUBLW      2
L__interrupt108:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt62
;Proj1Compiler.c,245 :: 		stopWatchMode = 0;
	CLRF       _stopWatchMode+0
	CLRF       _stopWatchMode+1
;Proj1Compiler.c,246 :: 		}
L_interrupt62:
;Proj1Compiler.c,247 :: 		};
L_interrupt60:
;Proj1Compiler.c,248 :: 		}
L_interrupt57:
L_interrupt56:
;Proj1Compiler.c,249 :: 		}
L_interrupt53:
;Proj1Compiler.c,251 :: 		INTCON.f3 = 0;  // Clear RB Port Change Interrupt Flag
	BCF        INTCON+0, 3
;Proj1Compiler.c,252 :: 		}
L_interrupt50:
;Proj1Compiler.c,253 :: 		INTCON.f7 = 1;  // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,254 :: 		}
L_end_interrupt:
L__interrupt104:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Proj1Compiler.c,256 :: 		void main() {
;Proj1Compiler.c,257 :: 		portInit();
	CALL       _portInit+0
;Proj1Compiler.c,258 :: 		interruptInit();
	CALL       _interruptInit+0
;Proj1Compiler.c,260 :: 		while (1) {
L_main63:
;Proj1Compiler.c,261 :: 		if (sysMode == 0) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main110
	MOVLW      0
	XORWF      _sysMode+0, 0
L__main110:
	BTFSS      STATUS+0, 2
	GOTO       L_main65
;Proj1Compiler.c,262 :: 		displayClockTime(hours, minutes, clockMode);
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
;Proj1Compiler.c,263 :: 		} else if (sysMode == 1) {
	GOTO       L_main66
L_main65:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main111
	MOVLW      1
	XORWF      _sysMode+0, 0
L__main111:
	BTFSS      STATUS+0, 2
	GOTO       L_main67
;Proj1Compiler.c,265 :: 		displayStopWatchTime(minutes, seconds, stopWatchMode);
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
;Proj1Compiler.c,266 :: 		} else if (sysMode == 2) {
	GOTO       L_main68
L_main67:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main112
	MOVLW      2
	XORWF      _sysMode+0, 0
L__main112:
	BTFSS      STATUS+0, 2
	GOTO       L_main69
;Proj1Compiler.c,268 :: 		} else if (sysMode == 3) {
	GOTO       L_main70
L_main69:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main113
	MOVLW      3
	XORWF      _sysMode+0, 0
L__main113:
	BTFSS      STATUS+0, 2
	GOTO       L_main71
;Proj1Compiler.c,270 :: 		}
L_main71:
L_main70:
L_main68:
L_main66:
;Proj1Compiler.c,271 :: 		}
	GOTO       L_main63
;Proj1Compiler.c,272 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
