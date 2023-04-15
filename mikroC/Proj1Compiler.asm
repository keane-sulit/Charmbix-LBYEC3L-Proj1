
_portInit:

;Proj1Compiler.c,67 :: 		void portInit() {
;Proj1Compiler.c,68 :: 		TRISC = 0x00;  // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,69 :: 		TRISD = 0x00;  // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,70 :: 		}
L_end_portInit:
	RETURN
; end of _portInit

_interruptInit:

;Proj1Compiler.c,72 :: 		void interruptInit() {
;Proj1Compiler.c,73 :: 		INTCON.f7 = 1;      // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,74 :: 		INTCON.f6 = 1;      // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,75 :: 		INTCON.f5 = 1;      // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,76 :: 		INTCON.f4 = 1;      // Enable RB0 External Interrupt Port Change Interrupt
	BSF        INTCON+0, 4
;Proj1Compiler.c,77 :: 		INTCON.f3 = 1;      // Enable RB Port Change Interrupt */
	BSF        INTCON+0, 3
;Proj1Compiler.c,78 :: 		OPTION_REG.f5 = 0;  // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,79 :: 		OPTION_REG.f4 = 0;  // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,80 :: 		OPTION_REG.f3 = 0;  // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,82 :: 		OPTION_REG.f2 = 1;
	BSF        OPTION_REG+0, 2
;Proj1Compiler.c,83 :: 		OPTION_REG.f1 = 0;
	BCF        OPTION_REG+0, 1
;Proj1Compiler.c,84 :: 		OPTION_REG.f0 = 0;
	BCF        OPTION_REG+0, 0
;Proj1Compiler.c,85 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_update:

;Proj1Compiler.c,87 :: 		void update() {
;Proj1Compiler.c,88 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Proj1Compiler.c,89 :: 		if (seconds > 59) {  // CLOCK
	MOVF       _seconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update153
	MOVF       _seconds+0, 0
	SUBLW      59
L__update153:
	BTFSC      STATUS+0, 0
	GOTO       L_update0
;Proj1Compiler.c,90 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,91 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,92 :: 		if (minutes > 59) {
	MOVF       _minutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update154
	MOVF       _minutes+0, 0
	SUBLW      59
L__update154:
	BTFSC      STATUS+0, 0
	GOTO       L_update1
;Proj1Compiler.c,93 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,94 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,95 :: 		}
L_update1:
;Proj1Compiler.c,96 :: 		}
L_update0:
;Proj1Compiler.c,98 :: 		if (sysMode == 2 && swState == 0) {  // STOPWATCH
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update155
	MOVLW      2
	XORWF      _sysMode+0, 0
L__update155:
	BTFSS      STATUS+0, 2
	GOTO       L_update4
	MOVLW      0
	XORWF      _swState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update156
	MOVLW      0
	XORWF      _swState+0, 0
L__update156:
	BTFSS      STATUS+0, 2
	GOTO       L_update4
L__update140:
;Proj1Compiler.c,99 :: 		swSeconds++;
	INCF       _swSeconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _swSeconds+1, 1
;Proj1Compiler.c,100 :: 		if (swSeconds > 59) {
	MOVF       _swSeconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update157
	MOVF       _swSeconds+0, 0
	SUBLW      59
L__update157:
	BTFSC      STATUS+0, 0
	GOTO       L_update5
;Proj1Compiler.c,101 :: 		swSeconds = 0;
	CLRF       _swSeconds+0
	CLRF       _swSeconds+1
;Proj1Compiler.c,102 :: 		swMinutes++;
	INCF       _swMinutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _swMinutes+1, 1
;Proj1Compiler.c,103 :: 		}
L_update5:
;Proj1Compiler.c,104 :: 		} else if (sysMode == 2 && swState == 1) {
	GOTO       L_update6
L_update4:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update158
	MOVLW      2
	XORWF      _sysMode+0, 0
L__update158:
	BTFSS      STATUS+0, 2
	GOTO       L_update9
	MOVLW      0
	XORWF      _swState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update159
	MOVLW      1
	XORWF      _swState+0, 0
L__update159:
	BTFSS      STATUS+0, 2
	GOTO       L_update9
L__update139:
;Proj1Compiler.c,106 :: 		return;
	GOTO       L_end_update
;Proj1Compiler.c,107 :: 		}
L_update9:
L_update6:
;Proj1Compiler.c,109 :: 		if (sysMode == 3 && tmrState == 0) {  // TIMER
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update160
	MOVLW      3
	XORWF      _sysMode+0, 0
L__update160:
	BTFSS      STATUS+0, 2
	GOTO       L_update12
	MOVLW      0
	XORWF      _tmrState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update161
	MOVLW      0
	XORWF      _tmrState+0, 0
L__update161:
	BTFSS      STATUS+0, 2
	GOTO       L_update12
L__update138:
;Proj1Compiler.c,110 :: 		if (tmrSeconds > 0) {
	MOVF       _tmrSeconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update162
	MOVF       _tmrSeconds+0, 0
	SUBLW      0
L__update162:
	BTFSC      STATUS+0, 0
	GOTO       L_update13
;Proj1Compiler.c,111 :: 		tmrSeconds--;
	MOVLW      1
	SUBWF      _tmrSeconds+0, 1
	BTFSS      STATUS+0, 0
	DECF       _tmrSeconds+1, 1
;Proj1Compiler.c,112 :: 		} else {
	GOTO       L_update14
L_update13:
;Proj1Compiler.c,113 :: 		if (tmrMinutes > 0) {
	MOVF       _tmrMinutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update163
	MOVF       _tmrMinutes+0, 0
	SUBLW      0
L__update163:
	BTFSC      STATUS+0, 0
	GOTO       L_update15
;Proj1Compiler.c,114 :: 		tmrMinutes--;
	MOVLW      1
	SUBWF      _tmrMinutes+0, 1
	BTFSS      STATUS+0, 0
	DECF       _tmrMinutes+1, 1
;Proj1Compiler.c,115 :: 		tmrSeconds = 59;
	MOVLW      59
	MOVWF      _tmrSeconds+0
	MOVLW      0
	MOVWF      _tmrSeconds+1
;Proj1Compiler.c,116 :: 		}
L_update15:
;Proj1Compiler.c,117 :: 		}
L_update14:
;Proj1Compiler.c,118 :: 		} else if (sysMode == 3 && tmrState == 1) {
	GOTO       L_update16
L_update12:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update164
	MOVLW      3
	XORWF      _sysMode+0, 0
L__update164:
	BTFSS      STATUS+0, 2
	GOTO       L_update19
	MOVLW      0
	XORWF      _tmrState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update165
	MOVLW      1
	XORWF      _tmrState+0, 0
L__update165:
	BTFSS      STATUS+0, 2
	GOTO       L_update19
L__update137:
;Proj1Compiler.c,120 :: 		return;
	GOTO       L_end_update
;Proj1Compiler.c,121 :: 		}
L_update19:
L_update16:
;Proj1Compiler.c,123 :: 		if (sysMode == 4) {  // ALARM
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update166
	MOVLW      4
	XORWF      _sysMode+0, 0
L__update166:
	BTFSS      STATUS+0, 2
	GOTO       L_update20
;Proj1Compiler.c,125 :: 		} else {
	GOTO       L_update21
L_update20:
;Proj1Compiler.c,127 :: 		return;
	GOTO       L_end_update
;Proj1Compiler.c,128 :: 		}
L_update21:
;Proj1Compiler.c,131 :: 		}
L_end_update:
	RETURN
; end of _update

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proj1Compiler.c,133 :: 		void interrupt() {
;Proj1Compiler.c,134 :: 		INTCON.f7 = 0;  // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,137 :: 		if (INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt22
;Proj1Compiler.c,138 :: 		if (tmr0Count == 10) {  // Change to 76 after simulation testing
	MOVF       _tmr0Count+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt23
;Proj1Compiler.c,139 :: 		tmr0Count = 0;
	CLRF       _tmr0Count+0
;Proj1Compiler.c,141 :: 		update();
	CALL       _update+0
;Proj1Compiler.c,142 :: 		} else {
	GOTO       L_interrupt24
L_interrupt23:
;Proj1Compiler.c,143 :: 		tmr0Count++;
	INCF       _tmr0Count+0, 1
;Proj1Compiler.c,144 :: 		}
L_interrupt24:
;Proj1Compiler.c,145 :: 		INTCON.f2 = 0;  // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,146 :: 		}
L_interrupt22:
;Proj1Compiler.c,149 :: 		if (INTCON.f1 == 1) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt25
;Proj1Compiler.c,151 :: 		if (PORTB.f0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt26
;Proj1Compiler.c,152 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt27:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt27
	DECFSZ     R12+0, 1
	GOTO       L_interrupt27
	DECFSZ     R11+0, 1
	GOTO       L_interrupt27
	NOP
	NOP
;Proj1Compiler.c,153 :: 		}
L_interrupt26:
;Proj1Compiler.c,155 :: 		sysMode++;
	INCF       _sysMode+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sysMode+1, 1
;Proj1Compiler.c,156 :: 		if (sysMode == 1) {  // 24H clock
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt169
	MOVLW      1
	XORWF      _sysMode+0, 0
L__interrupt169:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt28
;Proj1Compiler.c,157 :: 		clockMode = 1;
	MOVLW      1
	MOVWF      _clockMode+0
	MOVLW      0
	MOVWF      _clockMode+1
;Proj1Compiler.c,158 :: 		clockState = 0;
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,159 :: 		} else if (sysMode == 2) {  // Stopwatch
	GOTO       L_interrupt29
L_interrupt28:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt170
	MOVLW      2
	XORWF      _sysMode+0, 0
L__interrupt170:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt30
;Proj1Compiler.c,160 :: 		stopWatchMode = 0;
	CLRF       _stopWatchMode+0
	CLRF       _stopWatchMode+1
;Proj1Compiler.c,161 :: 		swState = 1;  // Pause
	MOVLW      1
	MOVWF      _swState+0
	MOVLW      0
	MOVWF      _swState+1
;Proj1Compiler.c,162 :: 		} else if (sysMode == 3) {
	GOTO       L_interrupt31
L_interrupt30:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt171
	MOVLW      3
	XORWF      _sysMode+0, 0
L__interrupt171:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt32
;Proj1Compiler.c,163 :: 		timerMode = 0;
	CLRF       _timerMode+0
	CLRF       _timerMode+1
;Proj1Compiler.c,164 :: 		tmrState = 1;           // Pause
	MOVLW      1
	MOVWF      _tmrState+0
	MOVLW      0
	MOVWF      _tmrState+1
;Proj1Compiler.c,165 :: 		} else if (sysMode == 4) {  // TEMPORARY
	GOTO       L_interrupt33
L_interrupt32:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt172
	MOVLW      4
	XORWF      _sysMode+0, 0
L__interrupt172:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt34
;Proj1Compiler.c,166 :: 		sysMode = 0;            // Reset to 12H clock
	CLRF       _sysMode+0
	CLRF       _sysMode+1
;Proj1Compiler.c,167 :: 		clockMode = 0;
	CLRF       _clockMode+0
	CLRF       _clockMode+1
;Proj1Compiler.c,168 :: 		clockState = 0;
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,169 :: 		}
L_interrupt34:
L_interrupt33:
L_interrupt31:
L_interrupt29:
;Proj1Compiler.c,171 :: 		INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
	BCF        INTCON+0, 1
;Proj1Compiler.c,172 :: 		}
L_interrupt25:
;Proj1Compiler.c,175 :: 		if (INTCON.f0 == 1) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt35
;Proj1Compiler.c,177 :: 		if (PORTB.f4 == 0) {
	BTFSC      PORTB+0, 4
	GOTO       L_interrupt36
;Proj1Compiler.c,178 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt37:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt37
	DECFSZ     R12+0, 1
	GOTO       L_interrupt37
	DECFSZ     R11+0, 1
	GOTO       L_interrupt37
	NOP
	NOP
;Proj1Compiler.c,180 :: 		if (sysMode == 0 || sysMode == 1) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt173
	MOVLW      0
	XORWF      _sysMode+0, 0
L__interrupt173:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt146
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt174
	MOVLW      1
	XORWF      _sysMode+0, 0
L__interrupt174:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt146
	GOTO       L_interrupt40
L__interrupt146:
;Proj1Compiler.c,181 :: 		if (clockState == 0) {
	MOVLW      0
	XORWF      _clockState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt175
	MOVLW      0
	XORWF      _clockState+0, 0
L__interrupt175:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt41
;Proj1Compiler.c,182 :: 		clockState = 1;
	MOVLW      1
	MOVWF      _clockState+0
	MOVLW      0
	MOVWF      _clockState+1
;Proj1Compiler.c,183 :: 		} else {
	GOTO       L_interrupt42
L_interrupt41:
;Proj1Compiler.c,184 :: 		clockState = 0;
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,185 :: 		}
L_interrupt42:
;Proj1Compiler.c,186 :: 		}
L_interrupt40:
;Proj1Compiler.c,188 :: 		if (sysMode == 2) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt176
	MOVLW      2
	XORWF      _sysMode+0, 0
L__interrupt176:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt43
;Proj1Compiler.c,189 :: 		if (swState == 0) {
	MOVLW      0
	XORWF      _swState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt177
	MOVLW      0
	XORWF      _swState+0, 0
L__interrupt177:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt44
;Proj1Compiler.c,190 :: 		swState = 1;
	MOVLW      1
	MOVWF      _swState+0
	MOVLW      0
	MOVWF      _swState+1
;Proj1Compiler.c,191 :: 		} else {
	GOTO       L_interrupt45
L_interrupt44:
;Proj1Compiler.c,192 :: 		swState = 0;
	CLRF       _swState+0
	CLRF       _swState+1
;Proj1Compiler.c,193 :: 		}
L_interrupt45:
;Proj1Compiler.c,194 :: 		}
L_interrupt43:
;Proj1Compiler.c,196 :: 		if (sysMode == 3) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt178
	MOVLW      3
	XORWF      _sysMode+0, 0
L__interrupt178:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt46
;Proj1Compiler.c,197 :: 		if (tmrState == 0) {
	MOVLW      0
	XORWF      _tmrState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt179
	MOVLW      0
	XORWF      _tmrState+0, 0
L__interrupt179:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt47
;Proj1Compiler.c,198 :: 		tmrState = 1;
	MOVLW      1
	MOVWF      _tmrState+0
	MOVLW      0
	MOVWF      _tmrState+1
;Proj1Compiler.c,199 :: 		} else {
	GOTO       L_interrupt48
L_interrupt47:
;Proj1Compiler.c,200 :: 		tmrState = 0;
	CLRF       _tmrState+0
	CLRF       _tmrState+1
;Proj1Compiler.c,201 :: 		}
L_interrupt48:
;Proj1Compiler.c,202 :: 		}
L_interrupt46:
;Proj1Compiler.c,203 :: 		}
L_interrupt36:
;Proj1Compiler.c,206 :: 		if (PORTB.f5 == 0) {
	BTFSC      PORTB+0, 5
	GOTO       L_interrupt49
;Proj1Compiler.c,207 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt50:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt50
	DECFSZ     R12+0, 1
	GOTO       L_interrupt50
	DECFSZ     R11+0, 1
	GOTO       L_interrupt50
	NOP
	NOP
;Proj1Compiler.c,209 :: 		if (digitFlag == 0) {
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt180
	MOVLW      0
	XORWF      _digitFlag+0, 0
L__interrupt180:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt51
;Proj1Compiler.c,210 :: 		digitFlag = 1;
	MOVLW      1
	MOVWF      _digitFlag+0
	MOVLW      0
	MOVWF      _digitFlag+1
;Proj1Compiler.c,211 :: 		} else if (digitFlag == 1) {
	GOTO       L_interrupt52
L_interrupt51:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt181
	MOVLW      1
	XORWF      _digitFlag+0, 0
L__interrupt181:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt53
;Proj1Compiler.c,212 :: 		digitFlag = 2;
	MOVLW      2
	MOVWF      _digitFlag+0
	MOVLW      0
	MOVWF      _digitFlag+1
;Proj1Compiler.c,213 :: 		} else if (digitFlag == 2) {
	GOTO       L_interrupt54
L_interrupt53:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt182
	MOVLW      2
	XORWF      _digitFlag+0, 0
L__interrupt182:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt55
;Proj1Compiler.c,214 :: 		digitFlag = 0;
	CLRF       _digitFlag+0
	CLRF       _digitFlag+1
;Proj1Compiler.c,215 :: 		}
L_interrupt55:
L_interrupt54:
L_interrupt52:
;Proj1Compiler.c,216 :: 		}
L_interrupt49:
;Proj1Compiler.c,219 :: 		if (PORTB.f6 == 0) {
	BTFSC      PORTB+0, 6
	GOTO       L_interrupt56
;Proj1Compiler.c,220 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt57:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt57
	DECFSZ     R12+0, 1
	GOTO       L_interrupt57
	DECFSZ     R11+0, 1
	GOTO       L_interrupt57
	NOP
	NOP
;Proj1Compiler.c,222 :: 		if (sysMode == 0 || sysMode == 1) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt183
	MOVLW      0
	XORWF      _sysMode+0, 0
L__interrupt183:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt145
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt184
	MOVLW      1
	XORWF      _sysMode+0, 0
L__interrupt184:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt145
	GOTO       L_interrupt60
L__interrupt145:
;Proj1Compiler.c,223 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,224 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,225 :: 		hours = 0;
	CLRF       _hours+0
	CLRF       _hours+1
;Proj1Compiler.c,226 :: 		}
L_interrupt60:
;Proj1Compiler.c,228 :: 		if (sysMode == 2) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt185
	MOVLW      2
	XORWF      _sysMode+0, 0
L__interrupt185:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt61
;Proj1Compiler.c,229 :: 		swSeconds = 0;
	CLRF       _swSeconds+0
	CLRF       _swSeconds+1
;Proj1Compiler.c,230 :: 		swMinutes = 0;
	CLRF       _swMinutes+0
	CLRF       _swMinutes+1
;Proj1Compiler.c,231 :: 		}
L_interrupt61:
;Proj1Compiler.c,233 :: 		if (sysMode == 3) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt186
	MOVLW      3
	XORWF      _sysMode+0, 0
L__interrupt186:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt62
;Proj1Compiler.c,234 :: 		tmrSeconds = 0;
	CLRF       _tmrSeconds+0
	CLRF       _tmrSeconds+1
;Proj1Compiler.c,235 :: 		tmrMinutes = 0;
	CLRF       _tmrMinutes+0
	CLRF       _tmrMinutes+1
;Proj1Compiler.c,236 :: 		}
L_interrupt62:
;Proj1Compiler.c,238 :: 		}
L_interrupt56:
;Proj1Compiler.c,241 :: 		if (PORTB.f7 == 0) {
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt63
;Proj1Compiler.c,242 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt64:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt64
	DECFSZ     R12+0, 1
	GOTO       L_interrupt64
	DECFSZ     R11+0, 1
	GOTO       L_interrupt64
	NOP
	NOP
;Proj1Compiler.c,244 :: 		if (digitFlag == 1 && (clockMode == 0 || clockMode == 1)) {
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt187
	MOVLW      1
	XORWF      _digitFlag+0, 0
L__interrupt187:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt69
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt188
	MOVLW      0
	XORWF      _clockMode+0, 0
L__interrupt188:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt144
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt189
	MOVLW      1
	XORWF      _clockMode+0, 0
L__interrupt189:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt144
	GOTO       L_interrupt69
L__interrupt144:
L__interrupt143:
;Proj1Compiler.c,245 :: 		hours = (hours + 1) % 24;
	MOVF       _hours+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _hours+1, 0
	MOVWF      R0+1
	MOVLW      24
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _hours+0
	MOVF       R0+1, 0
	MOVWF      _hours+1
;Proj1Compiler.c,246 :: 		} else if (digitFlag == 2) {
	GOTO       L_interrupt70
L_interrupt69:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt190
	MOVLW      2
	XORWF      _digitFlag+0, 0
L__interrupt190:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt71
;Proj1Compiler.c,247 :: 		minutes = (minutes + 1) % 60;
	MOVF       _minutes+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _minutes+1, 0
	MOVWF      R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _minutes+0
	MOVF       R0+1, 0
	MOVWF      _minutes+1
;Proj1Compiler.c,248 :: 		}
L_interrupt71:
L_interrupt70:
;Proj1Compiler.c,250 :: 		if (digitFlag == 1 && stopWatchMode == 0) {
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt191
	MOVLW      1
	XORWF      _digitFlag+0, 0
L__interrupt191:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt74
	MOVLW      0
	XORWF      _stopWatchMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt192
	MOVLW      0
	XORWF      _stopWatchMode+0, 0
L__interrupt192:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt74
L__interrupt142:
;Proj1Compiler.c,251 :: 		swMinutes = (swMinutes + 1) % 60;
	MOVF       _swMinutes+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _swMinutes+1, 0
	MOVWF      R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _swMinutes+0
	MOVF       R0+1, 0
	MOVWF      _swMinutes+1
;Proj1Compiler.c,252 :: 		} else if (digitFlag == 2 && sysMode == 2) {
	GOTO       L_interrupt75
L_interrupt74:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt193
	MOVLW      2
	XORWF      _digitFlag+0, 0
L__interrupt193:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt78
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt194
	MOVLW      2
	XORWF      _sysMode+0, 0
L__interrupt194:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt78
L__interrupt141:
;Proj1Compiler.c,253 :: 		swSeconds = (swSeconds + 1) % 60;
	MOVF       _swSeconds+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _swSeconds+1, 0
	MOVWF      R0+1
	MOVLW      60
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _swSeconds+0
	MOVF       R0+1, 0
	MOVWF      _swSeconds+1
;Proj1Compiler.c,254 :: 		}
L_interrupt78:
L_interrupt75:
;Proj1Compiler.c,261 :: 		}
L_interrupt63:
;Proj1Compiler.c,263 :: 		INTCON.f0 = 0;  // Clear RB Port Change Interrupt Flag
	BCF        INTCON+0, 0
;Proj1Compiler.c,264 :: 		}
L_interrupt35:
;Proj1Compiler.c,266 :: 		INTCON.f7 = 1;  // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,267 :: 		}
L_end_interrupt:
L__interrupt168:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_updateClockDisplay:

;Proj1Compiler.c,269 :: 		void updateClockDisplay(int num, int segIndex) {
;Proj1Compiler.c,270 :: 		switch (segIndex) {
	GOTO       L_updateClockDisplay79
;Proj1Compiler.c,271 :: 		case 0:
L_updateClockDisplay81:
;Proj1Compiler.c,272 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,273 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,274 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay82:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay82
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay82
;Proj1Compiler.c,275 :: 		break;
	GOTO       L_updateClockDisplay80
;Proj1Compiler.c,276 :: 		case 1:
L_updateClockDisplay83:
;Proj1Compiler.c,277 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,278 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,279 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay84:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay84
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay84
;Proj1Compiler.c,280 :: 		break;
	GOTO       L_updateClockDisplay80
;Proj1Compiler.c,281 :: 		case 2:
L_updateClockDisplay85:
;Proj1Compiler.c,282 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,283 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,284 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay86:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay86
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay86
;Proj1Compiler.c,285 :: 		break;
	GOTO       L_updateClockDisplay80
;Proj1Compiler.c,286 :: 		case 3:
L_updateClockDisplay87:
;Proj1Compiler.c,287 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,288 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,289 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay88:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay88
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay88
;Proj1Compiler.c,290 :: 		break;
	GOTO       L_updateClockDisplay80
;Proj1Compiler.c,291 :: 		}
L_updateClockDisplay79:
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay196
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay196:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay81
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay197
	MOVLW      1
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay197:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay83
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay198
	MOVLW      2
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay198:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay85
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay199
	MOVLW      3
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay199:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay87
L_updateClockDisplay80:
;Proj1Compiler.c,292 :: 		}
L_end_updateClockDisplay:
	RETURN
; end of _updateClockDisplay

_toggleClockTwelve:

;Proj1Compiler.c,294 :: 		void toggleClockTwelve(int hours, int minutes) {
;Proj1Compiler.c,295 :: 		if (0 < hours && hours < 13) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve201
	MOVF       FARG_toggleClockTwelve_hours+0, 0
	SUBLW      0
L__toggleClockTwelve201:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve91
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve202
	MOVLW      13
	SUBWF      FARG_toggleClockTwelve_hours+0, 0
L__toggleClockTwelve202:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve91
L__toggleClockTwelve147:
;Proj1Compiler.c,296 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,297 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,298 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,299 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,300 :: 		} else {
	GOTO       L_toggleClockTwelve92
L_toggleClockTwelve91:
;Proj1Compiler.c,301 :: 		updateClockDisplay(abs(hours - 12) / 10, 0);
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
;Proj1Compiler.c,302 :: 		updateClockDisplay(abs(hours - 12) % 10, 1);
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
;Proj1Compiler.c,303 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,304 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,305 :: 		}
L_toggleClockTwelve92:
;Proj1Compiler.c,306 :: 		}
L_end_toggleClockTwelve:
	RETURN
; end of _toggleClockTwelve

_toggleClockTwentyFour:

;Proj1Compiler.c,308 :: 		void toggleClockTwentyFour(int hours, int minutes) {
;Proj1Compiler.c,309 :: 		if (hours < 24) {
	MOVLW      128
	XORWF      FARG_toggleClockTwentyFour_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwentyFour204
	MOVLW      24
	SUBWF      FARG_toggleClockTwentyFour_hours+0, 0
L__toggleClockTwentyFour204:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwentyFour93
;Proj1Compiler.c,310 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,311 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,312 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,313 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,314 :: 		} else {
	GOTO       L_toggleClockTwentyFour94
L_toggleClockTwentyFour93:
;Proj1Compiler.c,315 :: 		updateClockDisplay(0, 0);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,316 :: 		updateClockDisplay(0, 1);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,317 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,318 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,319 :: 		}
L_toggleClockTwentyFour94:
;Proj1Compiler.c,320 :: 		}
L_end_toggleClockTwentyFour:
	RETURN
; end of _toggleClockTwentyFour

_displayClockTime:

;Proj1Compiler.c,322 :: 		void displayClockTime(int hours, int minutes, int clockMode) {
;Proj1Compiler.c,323 :: 		switch (clockMode) {
	GOTO       L_displayClockTime95
;Proj1Compiler.c,324 :: 		case 0:
L_displayClockTime97:
;Proj1Compiler.c,325 :: 		toggleClockTwelve(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwelve_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwelve_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwelve_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwelve_minutes+1
	CALL       _toggleClockTwelve+0
;Proj1Compiler.c,326 :: 		break;
	GOTO       L_displayClockTime96
;Proj1Compiler.c,327 :: 		case 1:
L_displayClockTime98:
;Proj1Compiler.c,328 :: 		toggleClockTwentyFour(hours, minutes);
	MOVF       FARG_displayClockTime_hours+0, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+0
	MOVF       FARG_displayClockTime_hours+1, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+1
	MOVF       FARG_displayClockTime_minutes+0, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+0
	MOVF       FARG_displayClockTime_minutes+1, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+1
	CALL       _toggleClockTwentyFour+0
;Proj1Compiler.c,329 :: 		break;
	GOTO       L_displayClockTime96
;Proj1Compiler.c,330 :: 		}
L_displayClockTime95:
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime206
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime206:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime97
	MOVLW      0
	XORWF      FARG_displayClockTime_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__displayClockTime207
	MOVLW      1
	XORWF      FARG_displayClockTime_clockMode+0, 0
L__displayClockTime207:
	BTFSC      STATUS+0, 2
	GOTO       L_displayClockTime98
L_displayClockTime96:
;Proj1Compiler.c,331 :: 		}
L_end_displayClockTime:
	RETURN
; end of _displayClockTime

_updateStopWatchDisplay:

;Proj1Compiler.c,333 :: 		void updateStopWatchDisplay(int num, int segIndex) {
;Proj1Compiler.c,334 :: 		switch (segIndex) {
	GOTO       L_updateStopWatchDisplay99
;Proj1Compiler.c,335 :: 		case 0:
L_updateStopWatchDisplay101:
;Proj1Compiler.c,336 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,337 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,338 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay102:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay102
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay102
;Proj1Compiler.c,339 :: 		break;
	GOTO       L_updateStopWatchDisplay100
;Proj1Compiler.c,340 :: 		case 1:
L_updateStopWatchDisplay103:
;Proj1Compiler.c,341 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,342 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,343 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay104:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay104
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay104
;Proj1Compiler.c,344 :: 		break;
	GOTO       L_updateStopWatchDisplay100
;Proj1Compiler.c,345 :: 		case 2:
L_updateStopWatchDisplay105:
;Proj1Compiler.c,346 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,347 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,348 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay106:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay106
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay106
;Proj1Compiler.c,349 :: 		break;
	GOTO       L_updateStopWatchDisplay100
;Proj1Compiler.c,350 :: 		case 3:
L_updateStopWatchDisplay107:
;Proj1Compiler.c,351 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,352 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,353 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay108:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay108
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay108
;Proj1Compiler.c,354 :: 		break;
	GOTO       L_updateStopWatchDisplay100
;Proj1Compiler.c,355 :: 		}
L_updateStopWatchDisplay99:
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay209
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay209:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay101
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay210
	MOVLW      1
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay210:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay103
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay211
	MOVLW      2
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay211:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay105
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay212
	MOVLW      3
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay212:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay107
L_updateStopWatchDisplay100:
;Proj1Compiler.c,356 :: 		}
L_end_updateStopWatchDisplay:
	RETURN
; end of _updateStopWatchDisplay

_stopWatch:

;Proj1Compiler.c,358 :: 		void stopWatch(int swMinutes, int swSeconds) {
;Proj1Compiler.c,360 :: 		if (swMinutes < 100) {
	MOVLW      128
	XORWF      FARG_stopWatch_swMinutes+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stopWatch214
	MOVLW      100
	SUBWF      FARG_stopWatch_swMinutes+0, 0
L__stopWatch214:
	BTFSC      STATUS+0, 0
	GOTO       L_stopWatch109
;Proj1Compiler.c,361 :: 		updateStopWatchDisplay(swMinutes / 10, 0);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_swMinutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_swMinutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateStopWatchDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateStopWatchDisplay_num+1
	CLRF       FARG_updateStopWatchDisplay_segIndex+0
	CLRF       FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,362 :: 		updateStopWatchDisplay(swMinutes % 10, 1);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_swMinutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_swMinutes+1, 0
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
;Proj1Compiler.c,363 :: 		updateStopWatchDisplay(swSeconds / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_swSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_swSeconds+1, 0
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
;Proj1Compiler.c,364 :: 		updateStopWatchDisplay(swSeconds % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_swSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_swSeconds+1, 0
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
;Proj1Compiler.c,365 :: 		} else {
	GOTO       L_stopWatch110
L_stopWatch109:
;Proj1Compiler.c,366 :: 		updateStopWatchDisplay(0, 0);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	CLRF       FARG_updateStopWatchDisplay_segIndex+0
	CLRF       FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,367 :: 		updateStopWatchDisplay(0, 1);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,368 :: 		updateStopWatchDisplay(swSeconds / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_swSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_swSeconds+1, 0
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
;Proj1Compiler.c,369 :: 		updateStopWatchDisplay(swSeconds % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_stopWatch_swSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_stopWatch_swSeconds+1, 0
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
;Proj1Compiler.c,370 :: 		}
L_stopWatch110:
;Proj1Compiler.c,371 :: 		}
L_end_stopWatch:
	RETURN
; end of _stopWatch

_updateTimerDisplay:

;Proj1Compiler.c,373 :: 		void updateTimerDisplay(int num, int segIndex) {
;Proj1Compiler.c,374 :: 		switch (segIndex) {
	GOTO       L_updateTimerDisplay111
;Proj1Compiler.c,375 :: 		case 0:
L_updateTimerDisplay113:
;Proj1Compiler.c,376 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,377 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,378 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay114:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay114
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay114
;Proj1Compiler.c,379 :: 		break;
	GOTO       L_updateTimerDisplay112
;Proj1Compiler.c,380 :: 		case 1:
L_updateTimerDisplay115:
;Proj1Compiler.c,381 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,382 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,383 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay116:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay116
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay116
;Proj1Compiler.c,384 :: 		break;
	GOTO       L_updateTimerDisplay112
;Proj1Compiler.c,385 :: 		case 2:
L_updateTimerDisplay117:
;Proj1Compiler.c,386 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,387 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,388 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay118:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay118
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay118
;Proj1Compiler.c,389 :: 		break;
	GOTO       L_updateTimerDisplay112
;Proj1Compiler.c,390 :: 		case 3:
L_updateTimerDisplay119:
;Proj1Compiler.c,391 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,392 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,393 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay120:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay120
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay120
;Proj1Compiler.c,394 :: 		break;
	GOTO       L_updateTimerDisplay112
;Proj1Compiler.c,395 :: 		}
L_updateTimerDisplay111:
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay216
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay216:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay113
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay217
	MOVLW      1
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay217:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay115
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay218
	MOVLW      2
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay218:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay117
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay219
	MOVLW      3
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay219:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay119
L_updateTimerDisplay112:
;Proj1Compiler.c,396 :: 		}
L_end_updateTimerDisplay:
	RETURN
; end of _updateTimerDisplay

_timer:

;Proj1Compiler.c,398 :: 		void timer(int tmrMinutes, int tmrSeconds) {
;Proj1Compiler.c,400 :: 		if (tmrMinutes < 100) {
	MOVLW      128
	XORWF      FARG_timer_tmrMinutes+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__timer221
	MOVLW      100
	SUBWF      FARG_timer_tmrMinutes+0, 0
L__timer221:
	BTFSC      STATUS+0, 0
	GOTO       L_timer121
;Proj1Compiler.c,401 :: 		updateTimerDisplay(tmrMinutes / 10, 0);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_timer_tmrMinutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_timer_tmrMinutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateTimerDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateTimerDisplay_num+1
	CLRF       FARG_updateTimerDisplay_segIndex+0
	CLRF       FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,402 :: 		updateTimerDisplay(tmrMinutes % 10, 1);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_timer_tmrMinutes+0, 0
	MOVWF      R0+0
	MOVF       FARG_timer_tmrMinutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateTimerDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateTimerDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateTimerDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,403 :: 		updateTimerDisplay(tmrSeconds / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_timer_tmrSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_timer_tmrSeconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateTimerDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateTimerDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateTimerDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,404 :: 		updateTimerDisplay(tmrSeconds % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_timer_tmrSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_timer_tmrSeconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateTimerDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateTimerDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateTimerDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,405 :: 		} else {
	GOTO       L_timer122
L_timer121:
;Proj1Compiler.c,406 :: 		updateTimerDisplay(0, 0);
	CLRF       FARG_updateTimerDisplay_num+0
	CLRF       FARG_updateTimerDisplay_num+1
	CLRF       FARG_updateTimerDisplay_segIndex+0
	CLRF       FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,407 :: 		updateTimerDisplay(0, 1);
	CLRF       FARG_updateTimerDisplay_num+0
	CLRF       FARG_updateTimerDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateTimerDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,408 :: 		updateTimerDisplay(tmrSeconds / 10, 2);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_timer_tmrSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_timer_tmrSeconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_updateTimerDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateTimerDisplay_num+1
	MOVLW      2
	MOVWF      FARG_updateTimerDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,409 :: 		updateTimerDisplay(tmrSeconds % 10, 3);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_timer_tmrSeconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_timer_tmrSeconds+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_updateTimerDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_updateTimerDisplay_num+1
	MOVLW      3
	MOVWF      FARG_updateTimerDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,410 :: 		}
L_timer122:
;Proj1Compiler.c,411 :: 		}
L_end_timer:
	RETURN
; end of _timer

_set:

;Proj1Compiler.c,413 :: 		void set() {
;Proj1Compiler.c,415 :: 		hoursTens = hours / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hours+0, 0
	MOVWF      R0+0
	MOVF       _hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _hoursTens+0
	MOVF       R0+1, 0
	MOVWF      _hoursTens+1
;Proj1Compiler.c,416 :: 		hoursOnes = hours % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _hours+0, 0
	MOVWF      R0+0
	MOVF       _hours+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _hoursOnes+0
	MOVF       R0+1, 0
	MOVWF      _hoursOnes+1
;Proj1Compiler.c,417 :: 		minutesTens = minutes / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minutes+0, 0
	MOVWF      R0+0
	MOVF       _minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _minutesTens+0
	MOVF       R0+1, 0
	MOVWF      _minutesTens+1
;Proj1Compiler.c,418 :: 		minutesOnes = minutes % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _minutes+0, 0
	MOVWF      R0+0
	MOVF       _minutes+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _minutesOnes+0
	MOVF       R0+1, 0
	MOVWF      _minutesOnes+1
;Proj1Compiler.c,419 :: 		}
L_end_set:
	RETURN
; end of _set

_blink:

;Proj1Compiler.c,422 :: 		void blink() {
;Proj1Compiler.c,423 :: 		if (tmrSeconds == 0 && tmrMinutes == 0) {
	MOVLW      0
	XORWF      _tmrSeconds+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__blink224
	MOVLW      0
	XORWF      _tmrSeconds+0, 0
L__blink224:
	BTFSS      STATUS+0, 2
	GOTO       L_blink125
	MOVLW      0
	XORWF      _tmrMinutes+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__blink225
	MOVLW      0
	XORWF      _tmrMinutes+0, 0
L__blink225:
	BTFSS      STATUS+0, 2
	GOTO       L_blink125
L__blink148:
;Proj1Compiler.c,424 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;Proj1Compiler.c,425 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;Proj1Compiler.c,426 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_blink126:
	DECFSZ     R13+0, 1
	GOTO       L_blink126
	DECFSZ     R12+0, 1
	GOTO       L_blink126
	DECFSZ     R11+0, 1
	GOTO       L_blink126
	NOP
;Proj1Compiler.c,427 :: 		PORTD = 0x0F;
	MOVLW      15
	MOVWF      PORTD+0
;Proj1Compiler.c,428 :: 		PORTC = 0xFF;
	MOVLW      255
	MOVWF      PORTC+0
;Proj1Compiler.c,429 :: 		delay_ms(500);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_blink127:
	DECFSZ     R13+0, 1
	GOTO       L_blink127
	DECFSZ     R12+0, 1
	GOTO       L_blink127
	DECFSZ     R11+0, 1
	GOTO       L_blink127
	NOP
;Proj1Compiler.c,430 :: 		}
L_blink125:
;Proj1Compiler.c,431 :: 		}
L_end_blink:
	RETURN
; end of _blink

_main:

;Proj1Compiler.c,433 :: 		void main() {
;Proj1Compiler.c,434 :: 		portInit();
	CALL       _portInit+0
;Proj1Compiler.c,435 :: 		interruptInit();
	CALL       _interruptInit+0
;Proj1Compiler.c,437 :: 		while (1) {
L_main128:
;Proj1Compiler.c,438 :: 		if (sysMode == 0 || sysMode == 1) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main227
	MOVLW      0
	XORWF      _sysMode+0, 0
L__main227:
	BTFSC      STATUS+0, 2
	GOTO       L__main149
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main228
	MOVLW      1
	XORWF      _sysMode+0, 0
L__main228:
	BTFSC      STATUS+0, 2
	GOTO       L__main149
	GOTO       L_main132
L__main149:
;Proj1Compiler.c,439 :: 		displayClockTime(hours, minutes, clockMode);
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
;Proj1Compiler.c,440 :: 		} else if (sysMode == 2) {
	GOTO       L_main133
L_main132:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main229
	MOVLW      2
	XORWF      _sysMode+0, 0
L__main229:
	BTFSS      STATUS+0, 2
	GOTO       L_main134
;Proj1Compiler.c,442 :: 		stopWatch(swMinutes, swSeconds);
	MOVF       _swMinutes+0, 0
	MOVWF      FARG_stopWatch_swMinutes+0
	MOVF       _swMinutes+1, 0
	MOVWF      FARG_stopWatch_swMinutes+1
	MOVF       _swSeconds+0, 0
	MOVWF      FARG_stopWatch_swSeconds+0
	MOVF       _swSeconds+1, 0
	MOVWF      FARG_stopWatch_swSeconds+1
	CALL       _stopWatch+0
;Proj1Compiler.c,443 :: 		} else if (sysMode == 3) {
	GOTO       L_main135
L_main134:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main230
	MOVLW      3
	XORWF      _sysMode+0, 0
L__main230:
	BTFSS      STATUS+0, 2
	GOTO       L_main136
;Proj1Compiler.c,445 :: 		timer(tmrMinutes, tmrSeconds);
	MOVF       _tmrMinutes+0, 0
	MOVWF      FARG_timer_tmrMinutes+0
	MOVF       _tmrMinutes+1, 0
	MOVWF      FARG_timer_tmrMinutes+1
	MOVF       _tmrSeconds+0, 0
	MOVWF      FARG_timer_tmrSeconds+0
	MOVF       _tmrSeconds+1, 0
	MOVWF      FARG_timer_tmrSeconds+1
	CALL       _timer+0
;Proj1Compiler.c,446 :: 		blink();
	CALL       _blink+0
;Proj1Compiler.c,447 :: 		}
L_main136:
L_main135:
L_main133:
;Proj1Compiler.c,448 :: 		}
	GOTO       L_main128
;Proj1Compiler.c,449 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
