
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proj1Compiler.c,35 :: 		void interrupt() {
;Proj1Compiler.c,36 :: 		if (INTCON.RBIF) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt0
;Proj1Compiler.c,37 :: 		INTCON.RBIF = 0;
	BCF        INTCON+0, 0
;Proj1Compiler.c,38 :: 		if (PORTB.f7 == 0) {
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt1
;Proj1Compiler.c,39 :: 		if(mode == CLOCK_12H) {
	MOVLW      0
	XORWF      _mode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt27
	MOVLW      0
	XORWF      _mode+0, 0
L__interrupt27:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;Proj1Compiler.c,40 :: 		mode = CLOCK_24H;
	MOVLW      1
	MOVWF      _mode+0
	CLRF       _mode+1
;Proj1Compiler.c,41 :: 		} else {
	GOTO       L_interrupt3
L_interrupt2:
;Proj1Compiler.c,42 :: 		mode = CLOCK_12H;
	CLRF       _mode+0
	CLRF       _mode+1
;Proj1Compiler.c,43 :: 		}
L_interrupt3:
;Proj1Compiler.c,44 :: 		}
L_interrupt1:
;Proj1Compiler.c,45 :: 		}
L_interrupt0:
;Proj1Compiler.c,46 :: 		}
L_end_interrupt:
L__interrupt26:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_init:

;Proj1Compiler.c,47 :: 		void init() {
;Proj1Compiler.c,48 :: 		TRISB.f7 = 1; // PORTB is the control bus
	BSF        TRISB+0, 7
;Proj1Compiler.c,49 :: 		TRISC = 0x00; // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,50 :: 		TRISD = 0x00; // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,51 :: 		}
L_end_init:
	RETURN
; end of _init

_disp_dig:

;Proj1Compiler.c,53 :: 		void disp_dig(int dig, int seg) {
;Proj1Compiler.c,54 :: 		switch(seg){
	GOTO       L_disp_dig4
;Proj1Compiler.c,55 :: 		case 1:
L_disp_dig6:
;Proj1Compiler.c,56 :: 		PORTD = 0x0E;
	MOVLW      14
	MOVWF      PORTD+0
;Proj1Compiler.c,57 :: 		PORTC = count[dig];
	MOVF       FARG_disp_dig_dig+0, 0
	ADDLW      _count+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,58 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_disp_dig7:
	DECFSZ     R13+0, 1
	GOTO       L_disp_dig7
	DECFSZ     R12+0, 1
	GOTO       L_disp_dig7
	NOP
;Proj1Compiler.c,59 :: 		break;
	GOTO       L_disp_dig5
;Proj1Compiler.c,60 :: 		case 2:
L_disp_dig8:
;Proj1Compiler.c,61 :: 		PORTD = 0x0D;
	MOVLW      13
	MOVWF      PORTD+0
;Proj1Compiler.c,62 :: 		PORTC = count[dig];
	MOVF       FARG_disp_dig_dig+0, 0
	ADDLW      _count+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,63 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_disp_dig9:
	DECFSZ     R13+0, 1
	GOTO       L_disp_dig9
	DECFSZ     R12+0, 1
	GOTO       L_disp_dig9
	NOP
;Proj1Compiler.c,64 :: 		break;
	GOTO       L_disp_dig5
;Proj1Compiler.c,65 :: 		case 3:
L_disp_dig10:
;Proj1Compiler.c,66 :: 		PORTD = 0x0B;
	MOVLW      11
	MOVWF      PORTD+0
;Proj1Compiler.c,67 :: 		PORTC = count[dig];
	MOVF       FARG_disp_dig_dig+0, 0
	ADDLW      _count+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,68 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_disp_dig11:
	DECFSZ     R13+0, 1
	GOTO       L_disp_dig11
	DECFSZ     R12+0, 1
	GOTO       L_disp_dig11
	NOP
;Proj1Compiler.c,69 :: 		break;
	GOTO       L_disp_dig5
;Proj1Compiler.c,70 :: 		case 4:
L_disp_dig12:
;Proj1Compiler.c,71 :: 		PORTD = 0x07;
	MOVLW      7
	MOVWF      PORTD+0
;Proj1Compiler.c,72 :: 		PORTC = count[dig];
	MOVF       FARG_disp_dig_dig+0, 0
	ADDLW      _count+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,73 :: 		delay_ms(10);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_disp_dig13:
	DECFSZ     R13+0, 1
	GOTO       L_disp_dig13
	DECFSZ     R12+0, 1
	GOTO       L_disp_dig13
	NOP
;Proj1Compiler.c,74 :: 		break;
	GOTO       L_disp_dig5
;Proj1Compiler.c,75 :: 		}
L_disp_dig4:
	MOVLW      0
	XORWF      FARG_disp_dig_seg+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__disp_dig30
	MOVLW      1
	XORWF      FARG_disp_dig_seg+0, 0
L__disp_dig30:
	BTFSC      STATUS+0, 2
	GOTO       L_disp_dig6
	MOVLW      0
	XORWF      FARG_disp_dig_seg+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__disp_dig31
	MOVLW      2
	XORWF      FARG_disp_dig_seg+0, 0
L__disp_dig31:
	BTFSC      STATUS+0, 2
	GOTO       L_disp_dig8
	MOVLW      0
	XORWF      FARG_disp_dig_seg+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__disp_dig32
	MOVLW      3
	XORWF      FARG_disp_dig_seg+0, 0
L__disp_dig32:
	BTFSC      STATUS+0, 2
	GOTO       L_disp_dig10
	MOVLW      0
	XORWF      FARG_disp_dig_seg+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__disp_dig33
	MOVLW      4
	XORWF      FARG_disp_dig_seg+0, 0
L__disp_dig33:
	BTFSC      STATUS+0, 2
	GOTO       L_disp_dig12
L_disp_dig5:
;Proj1Compiler.c,76 :: 		}
L_end_disp_dig:
	RETURN
; end of _disp_dig

_disp_time:

;Proj1Compiler.c,78 :: 		void disp_time(int hours, int minutes) {
;Proj1Compiler.c,79 :: 		for (i = 0; i < 25; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_disp_time14:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__disp_time35
	MOVLW      25
	SUBWF      _i+0, 0
L__disp_time35:
	BTFSC      STATUS+0, 0
	GOTO       L_disp_time15
;Proj1Compiler.c,80 :: 		disp_dig(hours / 10, 1);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_disp_time_hours+0, 0
	MOVWF      R0+0
	MOVF       FARG_disp_time_hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_disp_dig_dig+0
	MOVF       R0+1, 0
	MOVWF      FARG_disp_dig_dig+1
	MOVLW      1
	MOVWF      FARG_disp_dig_seg+0
	MOVLW      0
	MOVWF      FARG_disp_dig_seg+1
	CALL       _disp_dig+0
;Proj1Compiler.c,81 :: 		disp_dig(hours % 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_disp_time_hours+0, 0
	MOVWF      R0+0
	MOVF       FARG_disp_time_hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_disp_dig_dig+0
	MOVF       R0+1, 0
	MOVWF      FARG_disp_dig_dig+1
	MOVLW      2
	MOVWF      FARG_disp_dig_seg+0
	MOVLW      0
	MOVWF      FARG_disp_dig_seg+1
	CALL       _disp_dig+0
;Proj1Compiler.c,82 :: 		disp_dig(minutes / 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_disp_time_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_disp_time_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_disp_dig_dig+0
	MOVF       R0+1, 0
	MOVWF      FARG_disp_dig_dig+1
	MOVLW      3
	MOVWF      FARG_disp_dig_seg+0
	MOVLW      0
	MOVWF      FARG_disp_dig_seg+1
	CALL       _disp_dig+0
;Proj1Compiler.c,83 :: 		disp_dig(minutes % 10, 4);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_disp_time_minutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_disp_time_minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_disp_dig_dig+0
	MOVF       R0+1, 0
	MOVWF      FARG_disp_dig_dig+1
	MOVLW      4
	MOVWF      FARG_disp_dig_seg+0
	MOVLW      0
	MOVWF      FARG_disp_dig_seg+1
	CALL       _disp_dig+0
;Proj1Compiler.c,79 :: 		for (i = 0; i < 25; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Proj1Compiler.c,84 :: 		}
	GOTO       L_disp_time14
L_disp_time15:
;Proj1Compiler.c,85 :: 		}
L_end_disp_time:
	RETURN
; end of _disp_time

_inc_time:

;Proj1Compiler.c,87 :: 		void inc_time() {
;Proj1Compiler.c,88 :: 		if (minutes > 59) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _minutes+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__inc_time37
	MOVF       _minutes+0, 0
	SUBLW      59
L__inc_time37:
	BTFSC      STATUS+0, 0
	GOTO       L_inc_time17
;Proj1Compiler.c,89 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,90 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,91 :: 		if (mode == CLOCK_12H) {
	MOVLW      0
	XORWF      _mode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__inc_time38
	MOVLW      0
	XORWF      _mode+0, 0
L__inc_time38:
	BTFSS      STATUS+0, 2
	GOTO       L_inc_time18
;Proj1Compiler.c,92 :: 		if (hours > 12) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _hours+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__inc_time39
	MOVF       _hours+0, 0
	SUBLW      12
L__inc_time39:
	BTFSC      STATUS+0, 0
	GOTO       L_inc_time19
;Proj1Compiler.c,93 :: 		hours = 1;
	MOVLW      1
	MOVWF      _hours+0
	MOVLW      0
	MOVWF      _hours+1
;Proj1Compiler.c,94 :: 		}
L_inc_time19:
;Proj1Compiler.c,95 :: 		} else {                // mode == CLOCK_24H
	GOTO       L_inc_time20
L_inc_time18:
;Proj1Compiler.c,96 :: 		if (hours > 23) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _hours+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__inc_time40
	MOVF       _hours+0, 0
	SUBLW      23
L__inc_time40:
	BTFSC      STATUS+0, 0
	GOTO       L_inc_time21
;Proj1Compiler.c,97 :: 		hours = 0;
	CLRF       _hours+0
	CLRF       _hours+1
;Proj1Compiler.c,98 :: 		}
L_inc_time21:
;Proj1Compiler.c,99 :: 		}
L_inc_time20:
;Proj1Compiler.c,100 :: 		}
L_inc_time17:
;Proj1Compiler.c,101 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,102 :: 		}
L_end_inc_time:
	RETURN
; end of _inc_time

_modes:

;Proj1Compiler.c,104 :: 		void modes() {
;Proj1Compiler.c,118 :: 		}
L_end_modes:
	RETURN
; end of _modes

_main:

;Proj1Compiler.c,120 :: 		void main() {
;Proj1Compiler.c,121 :: 		init();
	CALL       _init+0
;Proj1Compiler.c,122 :: 		disp_time(hours, minutes);
	MOVF       _hours+0, 0
	MOVWF      FARG_disp_time_hours+0
	MOVF       _hours+1, 0
	MOVWF      FARG_disp_time_hours+1
	MOVF       _minutes+0, 0
	MOVWF      FARG_disp_time_minutes+0
	MOVF       _minutes+1, 0
	MOVWF      FARG_disp_time_minutes+1
	CALL       _disp_time+0
;Proj1Compiler.c,123 :: 		INTCON.GIE = 1;             // Enable global interrupts
	BSF        INTCON+0, 7
;Proj1Compiler.c,124 :: 		INTCON.PEIE = 1;            // Enable peripheral interrupts
	BSF        INTCON+0, 6
;Proj1Compiler.c,125 :: 		INTCON.RBIE = 1;            // Enable RB port change interrupts
	BSF        INTCON+0, 3
;Proj1Compiler.c,126 :: 		INTCON.RBIF = 0;            // Clear RB port change interrupt flag
	BCF        INTCON+0, 0
;Proj1Compiler.c,127 :: 		OPTION_REG.f7 = 1;          // Enable pull-up resistor for RB7
	BSF        OPTION_REG+0, 7
;Proj1Compiler.c,130 :: 		while(1) {
L_main22:
;Proj1Compiler.c,131 :: 		disp_time(hours, minutes);
	MOVF       _hours+0, 0
	MOVWF      FARG_disp_time_hours+0
	MOVF       _hours+1, 0
	MOVWF      FARG_disp_time_hours+1
	MOVF       _minutes+0, 0
	MOVWF      FARG_disp_time_minutes+0
	MOVF       _minutes+1, 0
	MOVWF      FARG_disp_time_minutes+1
	CALL       _disp_time+0
;Proj1Compiler.c,132 :: 		inc_time();
	CALL       _inc_time+0
;Proj1Compiler.c,133 :: 		delay_ms(50);          // Add a delay to prevent the loop from executing too quickly
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
	NOP
	NOP
;Proj1Compiler.c,134 :: 		}
	GOTO       L_main22
;Proj1Compiler.c,135 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
