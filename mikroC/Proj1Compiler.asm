
_portInit:

;Proj1Compiler.c,63 :: 		void portInit() {
;Proj1Compiler.c,64 :: 		TRISC = 0x00;  // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,65 :: 		TRISD = 0x00;  // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,66 :: 		}
L_end_portInit:
	RETURN
; end of _portInit

_interruptInit:

;Proj1Compiler.c,68 :: 		void interruptInit() {
;Proj1Compiler.c,69 :: 		INTCON.f7 = 1;      // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,70 :: 		INTCON.f6 = 1;      // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,71 :: 		INTCON.f5 = 1;      // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,72 :: 		INTCON.f4 = 1;      // Enable RB0 External Interrupt Port Change Interrupt
	BSF        INTCON+0, 4
;Proj1Compiler.c,73 :: 		INTCON.f3 = 1;      // Enable RB Port Change Interrupt */
	BSF        INTCON+0, 3
;Proj1Compiler.c,74 :: 		OPTION_REG.f5 = 0;  // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,75 :: 		OPTION_REG.f4 = 0;  // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,76 :: 		OPTION_REG.f3 = 0;  // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,78 :: 		OPTION_REG.f2 = 0;
	BCF        OPTION_REG+0, 2
;Proj1Compiler.c,79 :: 		OPTION_REG.f1 = 1;
	BSF        OPTION_REG+0, 1
;Proj1Compiler.c,80 :: 		OPTION_REG.f0 = 1;
	BSF        OPTION_REG+0, 0
;Proj1Compiler.c,81 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_update:

;Proj1Compiler.c,83 :: 		void update() {
;Proj1Compiler.c,84 :: 		if ((clockMode == 0 || clockMode == 1) && clockState == 2) {
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update119
	MOVLW      0
	XORWF      _clockMode+0, 0
L__update119:
	BTFSC      STATUS+0, 2
	GOTO       L__update111
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update120
	MOVLW      1
	XORWF      _clockMode+0, 0
L__update120:
	BTFSC      STATUS+0, 2
	GOTO       L__update111
	GOTO       L_update4
L__update111:
	MOVLW      0
	XORWF      _clockState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update121
	MOVLW      2
	XORWF      _clockState+0, 0
L__update121:
	BTFSS      STATUS+0, 2
	GOTO       L_update4
L__update110:
;Proj1Compiler.c,85 :: 		if (incrementFlag == 1) {
	MOVLW      0
	XORWF      _incrementFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update122
	MOVLW      1
	XORWF      _incrementFlag+0, 0
L__update122:
	BTFSS      STATUS+0, 2
	GOTO       L_update5
;Proj1Compiler.c,86 :: 		if (selectFlag == 0) {
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update123
	MOVLW      0
	XORWF      _selectFlag+0, 0
L__update123:
	BTFSS      STATUS+0, 2
	GOTO       L_update6
;Proj1Compiler.c,87 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,88 :: 		} else if (selectFlag == 1) {
	GOTO       L_update7
L_update6:
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update124
	MOVLW      1
	XORWF      _selectFlag+0, 0
L__update124:
	BTFSS      STATUS+0, 2
	GOTO       L_update8
;Proj1Compiler.c,89 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,90 :: 		}
L_update8:
L_update7:
;Proj1Compiler.c,91 :: 		} else if (decrementFlag == 1) {
	GOTO       L_update9
L_update5:
	MOVLW      0
	XORWF      _decrementFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update125
	MOVLW      1
	XORWF      _decrementFlag+0, 0
L__update125:
	BTFSS      STATUS+0, 2
	GOTO       L_update10
;Proj1Compiler.c,92 :: 		if (selectFlag == 0) {
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update126
	MOVLW      0
	XORWF      _selectFlag+0, 0
L__update126:
	BTFSS      STATUS+0, 2
	GOTO       L_update11
;Proj1Compiler.c,93 :: 		hours--;
	MOVLW      1
	SUBWF      _hours+0, 1
	BTFSS      STATUS+0, 0
	DECF       _hours+1, 1
;Proj1Compiler.c,94 :: 		} else if (selectFlag == 1) {
	GOTO       L_update12
L_update11:
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update127
	MOVLW      1
	XORWF      _selectFlag+0, 0
L__update127:
	BTFSS      STATUS+0, 2
	GOTO       L_update13
;Proj1Compiler.c,95 :: 		minutes--;
	MOVLW      1
	SUBWF      _minutes+0, 1
	BTFSS      STATUS+0, 0
	DECF       _minutes+1, 1
;Proj1Compiler.c,96 :: 		}
L_update13:
L_update12:
;Proj1Compiler.c,97 :: 		}
L_update10:
L_update9:
;Proj1Compiler.c,98 :: 		} else if ((clockMode == 0 || clockMode == 1) && clockState == 0) {
	GOTO       L_update14
L_update4:
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update128
	MOVLW      0
	XORWF      _clockMode+0, 0
L__update128:
	BTFSC      STATUS+0, 2
	GOTO       L__update109
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update129
	MOVLW      1
	XORWF      _clockMode+0, 0
L__update129:
	BTFSC      STATUS+0, 2
	GOTO       L__update109
	GOTO       L_update19
L__update109:
	MOVLW      0
	XORWF      _clockState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update130
	MOVLW      0
	XORWF      _clockState+0, 0
L__update130:
	BTFSS      STATUS+0, 2
	GOTO       L_update19
L__update108:
;Proj1Compiler.c,99 :: 		if (seconds > 59) {
	MOVF       _seconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update131
	MOVF       _seconds+0, 0
	SUBLW      59
L__update131:
	BTFSC      STATUS+0, 0
	GOTO       L_update20
;Proj1Compiler.c,100 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,101 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,102 :: 		if (minutes > 59) {
	MOVF       _minutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update132
	MOVF       _minutes+0, 0
	SUBLW      59
L__update132:
	BTFSC      STATUS+0, 0
	GOTO       L_update21
;Proj1Compiler.c,103 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,104 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,105 :: 		}
L_update21:
;Proj1Compiler.c,106 :: 		}
L_update20:
;Proj1Compiler.c,107 :: 		} else {
	GOTO       L_update22
L_update19:
;Proj1Compiler.c,108 :: 		return;
	GOTO       L_end_update
;Proj1Compiler.c,109 :: 		}
L_update22:
L_update14:
;Proj1Compiler.c,110 :: 		}
L_end_update:
	RETURN
; end of _update

_updateClockDisplay:

;Proj1Compiler.c,112 :: 		void updateClockDisplay(int num, int segIndex) {
;Proj1Compiler.c,113 :: 		switch (segIndex) {
	GOTO       L_updateClockDisplay23
;Proj1Compiler.c,114 :: 		case 0:
L_updateClockDisplay25:
;Proj1Compiler.c,115 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,116 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,117 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay26:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay26
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay26
;Proj1Compiler.c,118 :: 		break;
	GOTO       L_updateClockDisplay24
;Proj1Compiler.c,119 :: 		case 1:
L_updateClockDisplay27:
;Proj1Compiler.c,120 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,121 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,122 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay28:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay28
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay28
;Proj1Compiler.c,123 :: 		break;
	GOTO       L_updateClockDisplay24
;Proj1Compiler.c,124 :: 		case 2:
L_updateClockDisplay29:
;Proj1Compiler.c,125 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,126 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,127 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay30:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay30
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay30
;Proj1Compiler.c,128 :: 		break;
	GOTO       L_updateClockDisplay24
;Proj1Compiler.c,129 :: 		case 3:
L_updateClockDisplay31:
;Proj1Compiler.c,130 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,131 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,132 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay32:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay32
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay32
;Proj1Compiler.c,133 :: 		break;
	GOTO       L_updateClockDisplay24
;Proj1Compiler.c,134 :: 		}
L_updateClockDisplay23:
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay134
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay134:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay25
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay135
	MOVLW      1
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay135:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay27
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay136
	MOVLW      2
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay136:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay29
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay137
	MOVLW      3
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay137:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay31
L_updateClockDisplay24:
;Proj1Compiler.c,135 :: 		}
L_end_updateClockDisplay:
	RETURN
; end of _updateClockDisplay

_toggleClockTwelve:

;Proj1Compiler.c,137 :: 		void toggleClockTwelve(int hours, int minutes) {
;Proj1Compiler.c,138 :: 		if (0 < hours && hours < 13) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve139
	MOVF       FARG_toggleClockTwelve_hours+0, 0
	SUBLW      0
L__toggleClockTwelve139:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve35
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve140
	MOVLW      13
	SUBWF      FARG_toggleClockTwelve_hours+0, 0
L__toggleClockTwelve140:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve35
L__toggleClockTwelve112:
;Proj1Compiler.c,139 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,140 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,141 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,142 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,143 :: 		} else {
	GOTO       L_toggleClockTwelve36
L_toggleClockTwelve35:
;Proj1Compiler.c,144 :: 		updateClockDisplay(abs(hours - 12) / 10, 0);
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
;Proj1Compiler.c,145 :: 		updateClockDisplay(abs(hours - 12) % 10, 1);
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
;Proj1Compiler.c,146 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,147 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,148 :: 		}
L_toggleClockTwelve36:
;Proj1Compiler.c,149 :: 		}
L_end_toggleClockTwelve:
	RETURN
; end of _toggleClockTwelve

_toggleClockTwentyFour:

;Proj1Compiler.c,151 :: 		void toggleClockTwentyFour(int hours, int minutes) {
;Proj1Compiler.c,152 :: 		if (hours < 24) {
	MOVLW      128
	XORWF      FARG_toggleClockTwentyFour_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwentyFour142
	MOVLW      24
	SUBWF      FARG_toggleClockTwentyFour_hours+0, 0
L__toggleClockTwentyFour142:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwentyFour37
;Proj1Compiler.c,153 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,154 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,155 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,156 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,157 :: 		} else {
	GOTO       L_toggleClockTwentyFour38
L_toggleClockTwentyFour37:
;Proj1Compiler.c,158 :: 		updateClockDisplay(0, 0);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,159 :: 		updateClockDisplay(0, 1);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,160 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,161 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,162 :: 		}
L_toggleClockTwentyFour38:
;Proj1Compiler.c,163 :: 		}
L_end_toggleClockTwentyFour:
	RETURN
; end of _toggleClockTwentyFour

_displayClockTime:

;Proj1Compiler.c,165 :: 		void displayClockTime(int hours, int minutes, int clockMode) {
;Proj1Compiler.c,166 :: 		switch (clockMode) {
	GOTO       L_displayClockTime39
;Proj1Compiler.c,167 :: 		case 0:
L_displayClockTime41:
;Proj1Compiler.c,168 :: 		toggleClockTwelve(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwelve_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwelve_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwelve_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwelve_minutes+1
	CALL       _toggleClockTwelve+0
;Proj1Compiler.c,169 :: 		break;
	GOTO       L_displayClockTime40
;Proj1Compiler.c,170 :: 		case 1:
L_displayClockTime42:
;Proj1Compiler.c,171 :: 		toggleClockTwentyFour(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+1
	CALL       _toggleClockTwentyFour+0
;Proj1Compiler.c,172 :: 		break;
	GOTO       L_displayClockTime40
;Proj1Compiler.c,173 :: 		}
L_displayClockTime39:
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime144
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime144:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime41
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime145
	MOVLW      1
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime145:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime42
L_displayClockTime40:
;Proj1Compiler.c,174 :: 		}
L_end_displayClockTime:
	RETURN
; end of _displayClockTime

_updateStopWatchDisplay:

;Proj1Compiler.c,176 :: 		void updateStopWatchDisplay(int num, int segIndex) {
;Proj1Compiler.c,177 :: 		switch (segIndex) {
	GOTO       L_updateStopWatchDisplay43
;Proj1Compiler.c,178 :: 		case 0:
L_updateStopWatchDisplay45:
;Proj1Compiler.c,179 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,180 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,181 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay46:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay46
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay46
;Proj1Compiler.c,182 :: 		break;
	GOTO       L_updateStopWatchDisplay44
;Proj1Compiler.c,183 :: 		case 1:
L_updateStopWatchDisplay47:
;Proj1Compiler.c,184 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,185 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,186 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay48:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay48
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay48
;Proj1Compiler.c,187 :: 		break;
	GOTO       L_updateStopWatchDisplay44
;Proj1Compiler.c,188 :: 		case 2:
L_updateStopWatchDisplay49:
;Proj1Compiler.c,189 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,190 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,191 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay50:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay50
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay50
;Proj1Compiler.c,192 :: 		break;
	GOTO       L_updateStopWatchDisplay44
;Proj1Compiler.c,193 :: 		case 3:
L_updateStopWatchDisplay51:
;Proj1Compiler.c,194 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,195 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,196 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay52:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay52
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay52
;Proj1Compiler.c,197 :: 		break;
	GOTO       L_updateStopWatchDisplay44
;Proj1Compiler.c,198 :: 		}
L_updateStopWatchDisplay43:
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay147
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay147:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay45
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay148
	MOVLW      1
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay148:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay47
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay149
	MOVLW      2
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay149:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay49
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay150
	MOVLW      3
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay150:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay51
L_updateStopWatchDisplay44:
;Proj1Compiler.c,199 :: 		}
L_end_updateStopWatchDisplay:
	RETURN
; end of _updateStopWatchDisplay

_stopWatch:

;Proj1Compiler.c,201 :: 		void stopWatch(int minutes, int seconds) {
;Proj1Compiler.c,203 :: 		if (minutes < 100) {
	MOVLW      128
	XORWF      FARG_stopWatch_minutes+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stopWatch152
	MOVLW      100
	SUBWF      FARG_stopWatch_minutes+0, 0
L__stopWatch152:
	BTFSC      STATUS+0, 0
	GOTO       L_stopWatch53
;Proj1Compiler.c,204 :: 		updateStopWatchDisplay(minutes / 10, 0);
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
;Proj1Compiler.c,205 :: 		updateStopWatchDisplay(minutes % 10, 1);
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
;Proj1Compiler.c,206 :: 		updateStopWatchDisplay(seconds / 10, 2);
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
;Proj1Compiler.c,207 :: 		updateStopWatchDisplay(seconds % 10, 3);
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
;Proj1Compiler.c,208 :: 		} else {
	GOTO       L_stopWatch54
L_stopWatch53:
;Proj1Compiler.c,209 :: 		updateStopWatchDisplay(0, 0);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	CLRF       FARG_updateStopWatchDisplay_segIndex+0
	CLRF       FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,210 :: 		updateStopWatchDisplay(0, 1);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,211 :: 		updateStopWatchDisplay(seconds / 10, 2);
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
;Proj1Compiler.c,212 :: 		updateStopWatchDisplay(seconds % 10, 3);
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
;Proj1Compiler.c,213 :: 		}
L_stopWatch54:
;Proj1Compiler.c,214 :: 		}
L_end_stopWatch:
	RETURN
; end of _stopWatch

_displayStopWatchTime:

;Proj1Compiler.c,216 :: 		void displayStopWatchTime(int minutes, int seconds, int stopWatchMode) {
;Proj1Compiler.c,217 :: 		switch (stopWatchMode) {
	GOTO       L_displayStopWatchTime55
;Proj1Compiler.c,218 :: 		case 0:
L_displayStopWatchTime57:
;Proj1Compiler.c,220 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,221 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,222 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime58:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime58
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime58
;Proj1Compiler.c,223 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,224 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,225 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime59:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime59
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime59
;Proj1Compiler.c,226 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,227 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,228 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime60:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime60
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime60
;Proj1Compiler.c,229 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,230 :: 		PORTC = dispDigit[0];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,231 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_displayStopWatchTime61:
	DECFSZ     R13+0, 1
	GOTO       L_displayStopWatchTime61
	DECFSZ     R12+0, 1
	GOTO       L_displayStopWatchTime61
;Proj1Compiler.c,232 :: 		break;
	GOTO       L_displayStopWatchTime56
;Proj1Compiler.c,233 :: 		case 1:
L_displayStopWatchTime62:
;Proj1Compiler.c,235 :: 		stopWatch(minutes, seconds);
	MOVF       FARG_displayStopWatchTime_minutes+0, 0
	MOVWF      FARG_stopWatch_minutes+0
	MOVF       FARG_displayStopWatchTime_minutes+1, 0
	MOVWF      FARG_stopWatch_minutes+1
	MOVF       FARG_displayStopWatchTime_seconds+0, 0
	MOVWF      FARG_stopWatch_seconds+0
	MOVF       FARG_displayStopWatchTime_seconds+1, 0
	MOVWF      FARG_stopWatch_seconds+1
	CALL       _stopWatch+0
;Proj1Compiler.c,236 :: 		break;
	GOTO       L_displayStopWatchTime56
;Proj1Compiler.c,237 :: 		}
L_displayStopWatchTime55:
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayStopWatchTime154
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+0, 0
L__displayStopWatchTime154:
	BTFSC      STATUS+0, 2
	GOTO       L_displayStopWatchTime57
	MOVLW      0
	XORWF      FARG_displayStopWatchTime_stopWatchMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayStopWatchTime155
	MOVLW      1
	XORWF      FARG_displayStopWatchTime_stopWatchMode+0, 0
L__displayStopWatchTime155:
	BTFSC      STATUS+0, 2
	GOTO       L_displayStopWatchTime62
L_displayStopWatchTime56:
;Proj1Compiler.c,238 :: 		}
L_end_displayStopWatchTime:
	RETURN
; end of _displayStopWatchTime

_selectDigit:

;Proj1Compiler.c,240 :: 		void selectDigit() {
;Proj1Compiler.c,241 :: 		if (selectFlag == 0) {
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__selectDigit157
	MOVLW      0
	XORWF      _selectFlag+0, 0
L__selectDigit157:
	BTFSS      STATUS+0, 2
	GOTO       L_selectDigit63
;Proj1Compiler.c,242 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,243 :: 		PORTC = dispDigit[0/* hours / 10 */];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,244 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_selectDigit64:
	DECFSZ     R13+0, 1
	GOTO       L_selectDigit64
	DECFSZ     R12+0, 1
	GOTO       L_selectDigit64
;Proj1Compiler.c,245 :: 		} else if (selectFlag == 1) {
	GOTO       L_selectDigit65
L_selectDigit63:
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__selectDigit158
	MOVLW      1
	XORWF      _selectFlag+0, 0
L__selectDigit158:
	BTFSS      STATUS+0, 2
	GOTO       L_selectDigit66
;Proj1Compiler.c,246 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,247 :: 		PORTC = dispDigit[0/* hours % 10 */];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,248 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_selectDigit67:
	DECFSZ     R13+0, 1
	GOTO       L_selectDigit67
	DECFSZ     R12+0, 1
	GOTO       L_selectDigit67
;Proj1Compiler.c,249 :: 		} else if (selectFlag == 2) {
	GOTO       L_selectDigit68
L_selectDigit66:
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__selectDigit159
	MOVLW      2
	XORWF      _selectFlag+0, 0
L__selectDigit159:
	BTFSS      STATUS+0, 2
	GOTO       L_selectDigit69
;Proj1Compiler.c,250 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,251 :: 		PORTC = dispDigit[0/* minutes / 10 */];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,252 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_selectDigit70:
	DECFSZ     R13+0, 1
	GOTO       L_selectDigit70
	DECFSZ     R12+0, 1
	GOTO       L_selectDigit70
;Proj1Compiler.c,253 :: 		} else if (selectFlag == 3) {
	GOTO       L_selectDigit71
L_selectDigit69:
	MOVLW      0
	XORWF      _selectFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__selectDigit160
	MOVLW      3
	XORWF      _selectFlag+0, 0
L__selectDigit160:
	BTFSS      STATUS+0, 2
	GOTO       L_selectDigit72
;Proj1Compiler.c,254 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,255 :: 		PORTC = dispDigit[0/* minutes % 10 */];
	MOVF       _dispDigit+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,256 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_selectDigit73:
	DECFSZ     R13+0, 1
	GOTO       L_selectDigit73
	DECFSZ     R12+0, 1
	GOTO       L_selectDigit73
;Proj1Compiler.c,257 :: 		}
L_selectDigit72:
L_selectDigit71:
L_selectDigit68:
L_selectDigit65:
;Proj1Compiler.c,258 :: 		}
L_end_selectDigit:
	RETURN
; end of _selectDigit

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proj1Compiler.c,260 :: 		void interrupt() {
;Proj1Compiler.c,261 :: 		INTCON.f7 = 0;  // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,264 :: 		if (INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt74
;Proj1Compiler.c,265 :: 		if (tmr0Count == 2) {  // Change to 76 after simulation testing
	MOVF       _tmr0Count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt75
;Proj1Compiler.c,266 :: 		tmr0Count = 0;
	CLRF       _tmr0Count+0
;Proj1Compiler.c,268 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Proj1Compiler.c,269 :: 		update();
	CALL       _update+0
;Proj1Compiler.c,270 :: 		} else {
	GOTO       L_interrupt76
L_interrupt75:
;Proj1Compiler.c,271 :: 		tmr0Count++;
	INCF       _tmr0Count+0, 1
;Proj1Compiler.c,272 :: 		}
L_interrupt76:
;Proj1Compiler.c,273 :: 		INTCON.f2 = 0;  // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,274 :: 		}
L_interrupt74:
;Proj1Compiler.c,277 :: 		if (INTCON.f1 == 1) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt77
;Proj1Compiler.c,279 :: 		if (PORTB.f0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt78
;Proj1Compiler.c,280 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt79:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt79
	DECFSZ     R12+0, 1
	GOTO       L_interrupt79
	DECFSZ     R11+0, 1
	GOTO       L_interrupt79
	NOP
	NOP
;Proj1Compiler.c,281 :: 		}
L_interrupt78:
;Proj1Compiler.c,282 :: 		if (clockMode == 0) {
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt163
	MOVLW      0
	XORWF      _clockMode+0, 0
L__interrupt163:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt80
;Proj1Compiler.c,283 :: 		clockMode = 1;
	MOVLW      1
	MOVWF      _clockMode+0
	MOVLW      0
	MOVWF      _clockMode+1
;Proj1Compiler.c,284 :: 		} else {
	GOTO       L_interrupt81
L_interrupt80:
;Proj1Compiler.c,285 :: 		clockMode = 0;
	CLRF       _clockMode+0
	CLRF       _clockMode+1
;Proj1Compiler.c,286 :: 		}
L_interrupt81:
;Proj1Compiler.c,287 :: 		INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
	BCF        INTCON+0, 1
;Proj1Compiler.c,288 :: 		}
L_interrupt77:
;Proj1Compiler.c,291 :: 		if (INTCON.f0 == 1) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt82
;Proj1Compiler.c,293 :: 		if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 1) {
	BTFSC      PORTB+0, 4
	GOTO       L_interrupt85
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt85
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt85
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt85
L__interrupt115:
;Proj1Compiler.c,294 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt86:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt86
	DECFSZ     R12+0, 1
	GOTO       L_interrupt86
	DECFSZ     R11+0, 1
	GOTO       L_interrupt86
	NOP
	NOP
;Proj1Compiler.c,296 :: 		clockState++;
	INCF       _clockState+0, 1
	BTFSC      STATUS+0, 2
	INCF       _clockState+1, 1
;Proj1Compiler.c,297 :: 		if (clockState > 1) {
	MOVF       _clockState+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt164
	MOVF       _clockState+0, 0
	SUBLW      1
L__interrupt164:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt87
;Proj1Compiler.c,298 :: 		clockState = 0;
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,300 :: 		}
L_interrupt87:
;Proj1Compiler.c,301 :: 		}
L_interrupt85:
;Proj1Compiler.c,307 :: 		if (PORTB.f4 == 1 && PORTB.f5 == 0 && PORTB.f6 == 1 && PORTB.f7 == 1) {
	BTFSS      PORTB+0, 4
	GOTO       L_interrupt90
	BTFSC      PORTB+0, 5
	GOTO       L_interrupt90
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt90
	BTFSS      PORTB+0, 7
	GOTO       L_interrupt90
L__interrupt114:
;Proj1Compiler.c,308 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt91:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt91
	DECFSZ     R12+0, 1
	GOTO       L_interrupt91
	DECFSZ     R11+0, 1
	GOTO       L_interrupt91
	NOP
	NOP
;Proj1Compiler.c,309 :: 		selectFlag++;
	INCF       _selectFlag+0, 1
	BTFSC      STATUS+0, 2
	INCF       _selectFlag+1, 1
;Proj1Compiler.c,310 :: 		if (selectFlag > 3) {
	MOVF       _selectFlag+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt165
	MOVF       _selectFlag+0, 0
	SUBLW      3
L__interrupt165:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt92
;Proj1Compiler.c,311 :: 		selectFlag = 0;
	CLRF       _selectFlag+0
	CLRF       _selectFlag+1
;Proj1Compiler.c,312 :: 		}
L_interrupt92:
;Proj1Compiler.c,313 :: 		selectDigit();
	CALL       _selectDigit+0
;Proj1Compiler.c,314 :: 		}
L_interrupt90:
;Proj1Compiler.c,316 :: 		if (PORTB.f4 == 0 && PORTB.f5 == 1 && PORTB.f6 == 1 && PORTB.f7 == 0) {
	BTFSC      PORTB+0, 4
	GOTO       L_interrupt95
	BTFSS      PORTB+0, 5
	GOTO       L_interrupt95
	BTFSS      PORTB+0, 6
	GOTO       L_interrupt95
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt95
L__interrupt113:
;Proj1Compiler.c,317 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt96:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt96
	DECFSZ     R12+0, 1
	GOTO       L_interrupt96
	DECFSZ     R11+0, 1
	GOTO       L_interrupt96
	NOP
	NOP
;Proj1Compiler.c,318 :: 		if (clockMode != 2) {
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt166
	MOVLW      2
	XORWF      _clockMode+0, 0
L__interrupt166:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt97
;Proj1Compiler.c,319 :: 		clockMode = 2;
	MOVLW      2
	MOVWF      _clockMode+0
	MOVLW      0
	MOVWF      _clockMode+1
;Proj1Compiler.c,320 :: 		incrementFlag = 0;
	CLRF       _incrementFlag+0
	CLRF       _incrementFlag+1
;Proj1Compiler.c,321 :: 		decrementFlag = 0;
	CLRF       _decrementFlag+0
	CLRF       _decrementFlag+1
;Proj1Compiler.c,322 :: 		selectFlag = 0;
	CLRF       _selectFlag+0
	CLRF       _selectFlag+1
;Proj1Compiler.c,323 :: 		}
	GOTO       L_interrupt98
L_interrupt97:
;Proj1Compiler.c,326 :: 		clockMode = 0;
	CLRF       _clockMode+0
	CLRF       _clockMode+1
;Proj1Compiler.c,327 :: 		}
L_interrupt98:
;Proj1Compiler.c,328 :: 		}
L_interrupt95:
;Proj1Compiler.c,357 :: 		INTCON.f0 = 0;  // Clear RB Port Change Interrupt Flag
	BCF        INTCON+0, 0
;Proj1Compiler.c,358 :: 		}
L_interrupt82:
;Proj1Compiler.c,359 :: 		INTCON.f7 = 1;  // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,360 :: 		}
L_end_interrupt:
L__interrupt162:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Proj1Compiler.c,362 :: 		void main() {
;Proj1Compiler.c,363 :: 		portInit();
	CALL       _portInit+0
;Proj1Compiler.c,364 :: 		interruptInit();
	CALL       _interruptInit+0
;Proj1Compiler.c,366 :: 		while (1) {
L_main99:
;Proj1Compiler.c,367 :: 		if (sysMode == 0) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main168
	MOVLW      0
	XORWF      _sysMode+0, 0
L__main168:
	BTFSS      STATUS+0, 2
	GOTO       L_main101
;Proj1Compiler.c,368 :: 		displayClockTime(hours, minutes, clockMode);
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
;Proj1Compiler.c,369 :: 		} else if (sysMode == 1) {
	GOTO       L_main102
L_main101:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main169
	MOVLW      1
	XORWF      _sysMode+0, 0
L__main169:
	BTFSS      STATUS+0, 2
	GOTO       L_main103
;Proj1Compiler.c,371 :: 		displayStopWatchTime(minutes, seconds, stopWatchMode);
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
;Proj1Compiler.c,372 :: 		} else if (sysMode == 2) {
	GOTO       L_main104
L_main103:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main170
	MOVLW      2
	XORWF      _sysMode+0, 0
L__main170:
	BTFSS      STATUS+0, 2
	GOTO       L_main105
;Proj1Compiler.c,374 :: 		} else if (sysMode == 3) {
	GOTO       L_main106
L_main105:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main171
	MOVLW      3
	XORWF      _sysMode+0, 0
L__main171:
	BTFSS      STATUS+0, 2
	GOTO       L_main107
;Proj1Compiler.c,376 :: 		}
L_main107:
L_main106:
L_main104:
L_main102:
;Proj1Compiler.c,377 :: 		}
	GOTO       L_main99
;Proj1Compiler.c,378 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
