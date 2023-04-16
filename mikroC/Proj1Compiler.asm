
_portInit:

;Proj1Compiler.c,73 :: 		void portInit() {
;Proj1Compiler.c,74 :: 		TRISC = 0x00;  // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,75 :: 		TRISD = 0x00;  // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,76 :: 		}
L_end_portInit:
	RETURN
; end of _portInit

_interruptInit:

;Proj1Compiler.c,80 :: 		void interruptInit() {
;Proj1Compiler.c,81 :: 		INTCON.f7 = 1;      // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,82 :: 		INTCON.f6 = 1;      // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,83 :: 		INTCON.f5 = 1;      // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,84 :: 		INTCON.f4 = 1;      // Enable RB0 External Interrupt Port Change Interrupt
	BSF        INTCON+0, 4
;Proj1Compiler.c,85 :: 		INTCON.f3 = 1;      // Enable RB Port Change Interrupt */
	BSF        INTCON+0, 3
;Proj1Compiler.c,86 :: 		OPTION_REG.f5 = 0;  // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,87 :: 		OPTION_REG.f4 = 0;  // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,88 :: 		OPTION_REG.f3 = 0;  // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,92 :: 		OPTION_REG.f2 = 1;
	BSF        OPTION_REG+0, 2
;Proj1Compiler.c,93 :: 		OPTION_REG.f1 = 0;
	BCF        OPTION_REG+0, 1
;Proj1Compiler.c,94 :: 		OPTION_REG.f0 = 0;
	BCF        OPTION_REG+0, 0
;Proj1Compiler.c,95 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_update:

;Proj1Compiler.c,98 :: 		void update() {
;Proj1Compiler.c,102 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Proj1Compiler.c,103 :: 		if (seconds > 59) {  // CLOCK
	MOVF       _seconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update145
	MOVF       _seconds+0, 0
	SUBLW      59
L__update145:
	BTFSC      STATUS+0, 0
	GOTO       L_update0
;Proj1Compiler.c,104 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,105 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,106 :: 		if (minutes > 59) {
	MOVF       _minutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update146
	MOVF       _minutes+0, 0
	SUBLW      59
L__update146:
	BTFSC      STATUS+0, 0
	GOTO       L_update1
;Proj1Compiler.c,107 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,108 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,109 :: 		}
L_update1:
;Proj1Compiler.c,110 :: 		}
L_update0:
;Proj1Compiler.c,113 :: 		if (sysMode == 2 && swState == 0) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update147
	MOVLW      2
	XORWF      _sysMode+0, 0
L__update147:
	BTFSS      STATUS+0, 2
	GOTO       L_update4
	MOVLW      0
	XORWF      _swState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update148
	MOVLW      0
	XORWF      _swState+0, 0
L__update148:
	BTFSS      STATUS+0, 2
	GOTO       L_update4
L__update133:
;Proj1Compiler.c,114 :: 		swSeconds++;
	INCF       _swSeconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _swSeconds+1, 1
;Proj1Compiler.c,115 :: 		if (swSeconds > 59) {
	MOVF       _swSeconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update149
	MOVF       _swSeconds+0, 0
	SUBLW      59
L__update149:
	BTFSC      STATUS+0, 0
	GOTO       L_update5
;Proj1Compiler.c,116 :: 		swSeconds = 0;
	CLRF       _swSeconds+0
	CLRF       _swSeconds+1
;Proj1Compiler.c,117 :: 		swMinutes++;
	INCF       _swMinutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _swMinutes+1, 1
;Proj1Compiler.c,118 :: 		}
L_update5:
;Proj1Compiler.c,119 :: 		} else if (sysMode == 2 && swState == 1) {
	GOTO       L_update6
L_update4:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update150
	MOVLW      2
	XORWF      _sysMode+0, 0
L__update150:
	BTFSS      STATUS+0, 2
	GOTO       L_update9
	MOVLW      0
	XORWF      _swState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update151
	MOVLW      1
	XORWF      _swState+0, 0
L__update151:
	BTFSS      STATUS+0, 2
	GOTO       L_update9
L__update132:
;Proj1Compiler.c,121 :: 		return;
	GOTO       L_end_update
;Proj1Compiler.c,122 :: 		}
L_update9:
L_update6:
;Proj1Compiler.c,125 :: 		if (sysMode == 3 && tmrState == 0) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update152
	MOVLW      3
	XORWF      _sysMode+0, 0
L__update152:
	BTFSS      STATUS+0, 2
	GOTO       L_update12
	MOVLW      0
	XORWF      _tmrState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update153
	MOVLW      0
	XORWF      _tmrState+0, 0
L__update153:
	BTFSS      STATUS+0, 2
	GOTO       L_update12
L__update131:
;Proj1Compiler.c,126 :: 		if (tmrSeconds > 0) {
	MOVF       _tmrSeconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update154
	MOVF       _tmrSeconds+0, 0
	SUBLW      0
L__update154:
	BTFSC      STATUS+0, 0
	GOTO       L_update13
;Proj1Compiler.c,127 :: 		tmrSeconds--;
	MOVLW      1
	SUBWF      _tmrSeconds+0, 1
	BTFSS      STATUS+0, 0
	DECF       _tmrSeconds+1, 1
;Proj1Compiler.c,128 :: 		} else {
	GOTO       L_update14
L_update13:
;Proj1Compiler.c,129 :: 		if (tmrMinutes > 0) {
	MOVF       _tmrMinutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__update155
	MOVF       _tmrMinutes+0, 0
	SUBLW      0
L__update155:
	BTFSC      STATUS+0, 0
	GOTO       L_update15
;Proj1Compiler.c,130 :: 		tmrMinutes--;
	MOVLW      1
	SUBWF      _tmrMinutes+0, 1
	BTFSS      STATUS+0, 0
	DECF       _tmrMinutes+1, 1
;Proj1Compiler.c,131 :: 		tmrSeconds = 59;
	MOVLW      59
	MOVWF      _tmrSeconds+0
	MOVLW      0
	MOVWF      _tmrSeconds+1
;Proj1Compiler.c,132 :: 		}
L_update15:
;Proj1Compiler.c,133 :: 		}
L_update14:
;Proj1Compiler.c,134 :: 		} else if (sysMode == 3 && tmrState == 1) {
	GOTO       L_update16
L_update12:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update156
	MOVLW      3
	XORWF      _sysMode+0, 0
L__update156:
	BTFSS      STATUS+0, 2
	GOTO       L_update19
	MOVLW      0
	XORWF      _tmrState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__update157
	MOVLW      1
	XORWF      _tmrState+0, 0
L__update157:
	BTFSS      STATUS+0, 2
	GOTO       L_update19
L__update130:
;Proj1Compiler.c,136 :: 		return;
	GOTO       L_end_update
;Proj1Compiler.c,137 :: 		}
L_update19:
L_update16:
;Proj1Compiler.c,146 :: 		}
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

;Proj1Compiler.c,149 :: 		void interrupt() {
;Proj1Compiler.c,150 :: 		INTCON.f7 = 0;  // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,153 :: 		if (INTCON.f2 == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt20
;Proj1Compiler.c,154 :: 		if (tmr0Count == 10) {  // Change to 76 after simulation testing
	MOVF       _tmr0Count+0, 0
	XORLW      10
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt21
;Proj1Compiler.c,155 :: 		tmr0Count = 0;
	CLRF       _tmr0Count+0
;Proj1Compiler.c,156 :: 		update();           // Update time variables
	CALL       _update+0
;Proj1Compiler.c,157 :: 		} else {
	GOTO       L_interrupt22
L_interrupt21:
;Proj1Compiler.c,158 :: 		tmr0Count++;
	INCF       _tmr0Count+0, 1
;Proj1Compiler.c,159 :: 		}
L_interrupt22:
;Proj1Compiler.c,160 :: 		INTCON.f2 = 0;          // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,161 :: 		}
L_interrupt20:
;Proj1Compiler.c,164 :: 		if (INTCON.f1 == 1) {
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt23
;Proj1Compiler.c,167 :: 		if (PORTB.f0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt24
;Proj1Compiler.c,168 :: 		delay_ms(50);           // Debounce
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt25:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt25
	DECFSZ     R12+0, 1
	GOTO       L_interrupt25
	DECFSZ     R11+0, 1
	GOTO       L_interrupt25
	NOP
	NOP
;Proj1Compiler.c,169 :: 		}
L_interrupt24:
;Proj1Compiler.c,172 :: 		sysMode++;                  // Increment mode
	INCF       _sysMode+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sysMode+1, 1
;Proj1Compiler.c,173 :: 		if (sysMode == 1) {         // 24H CLOCK
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt160
	MOVLW      1
	XORWF      _sysMode+0, 0
L__interrupt160:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt26
;Proj1Compiler.c,174 :: 		clockMode = 1;          // 24H
	MOVLW      1
	MOVWF      _clockMode+0
	MOVLW      0
	MOVWF      _clockMode+1
;Proj1Compiler.c,175 :: 		clockState = 0;         // GO
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,176 :: 		} else if (sysMode == 2) {  // STOPWATCH
	GOTO       L_interrupt27
L_interrupt26:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt161
	MOVLW      2
	XORWF      _sysMode+0, 0
L__interrupt161:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt28
;Proj1Compiler.c,177 :: 		stopWatchMode = 0;      // Default
	CLRF       _stopWatchMode+0
	CLRF       _stopWatchMode+1
;Proj1Compiler.c,178 :: 		swState = 1;            // Pause
	MOVLW      1
	MOVWF      _swState+0
	MOVLW      0
	MOVWF      _swState+1
;Proj1Compiler.c,179 :: 		} else if (sysMode == 3) {  // TIMER
	GOTO       L_interrupt29
L_interrupt28:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt162
	MOVLW      3
	XORWF      _sysMode+0, 0
L__interrupt162:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt30
;Proj1Compiler.c,180 :: 		timerMode = 0;          // Default
	CLRF       _timerMode+0
	CLRF       _timerMode+1
;Proj1Compiler.c,181 :: 		tmrState = 1;           // Pause
	MOVLW      1
	MOVWF      _tmrState+0
	MOVLW      0
	MOVWF      _tmrState+1
;Proj1Compiler.c,182 :: 		} else if (sysMode == 4) {  // 12H CLOCK
	GOTO       L_interrupt31
L_interrupt30:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt163
	MOVLW      4
	XORWF      _sysMode+0, 0
L__interrupt163:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt32
;Proj1Compiler.c,183 :: 		sysMode = 0;            // Reset to 12H
	CLRF       _sysMode+0
	CLRF       _sysMode+1
;Proj1Compiler.c,184 :: 		clockMode = 0;          // 12H
	CLRF       _clockMode+0
	CLRF       _clockMode+1
;Proj1Compiler.c,185 :: 		clockState = 0;         // GO
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,186 :: 		}
L_interrupt32:
L_interrupt31:
L_interrupt29:
L_interrupt27:
;Proj1Compiler.c,188 :: 		INTCON.f1 = 0;  // Clear RB0 External Interrupt Flag
	BCF        INTCON+0, 1
;Proj1Compiler.c,189 :: 		}
L_interrupt23:
;Proj1Compiler.c,192 :: 		if (INTCON.f0 == 1) {
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt33
;Proj1Compiler.c,195 :: 		if (PORTB.f4 == 0) {
	BTFSC      PORTB+0, 4
	GOTO       L_interrupt34
;Proj1Compiler.c,196 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt35:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt35
	DECFSZ     R12+0, 1
	GOTO       L_interrupt35
	DECFSZ     R11+0, 1
	GOTO       L_interrupt35
	NOP
	NOP
;Proj1Compiler.c,198 :: 		if (sysMode == 0 || sysMode == 1) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt164
	MOVLW      0
	XORWF      _sysMode+0, 0
L__interrupt164:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt139
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt165
	MOVLW      1
	XORWF      _sysMode+0, 0
L__interrupt165:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt139
	GOTO       L_interrupt38
L__interrupt139:
;Proj1Compiler.c,199 :: 		if (clockState == 0) {
	MOVLW      0
	XORWF      _clockState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt166
	MOVLW      0
	XORWF      _clockState+0, 0
L__interrupt166:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt39
;Proj1Compiler.c,200 :: 		clockState = 1;
	MOVLW      1
	MOVWF      _clockState+0
	MOVLW      0
	MOVWF      _clockState+1
;Proj1Compiler.c,201 :: 		} else {
	GOTO       L_interrupt40
L_interrupt39:
;Proj1Compiler.c,202 :: 		clockState = 0;
	CLRF       _clockState+0
	CLRF       _clockState+1
;Proj1Compiler.c,203 :: 		}
L_interrupt40:
;Proj1Compiler.c,204 :: 		}
L_interrupt38:
;Proj1Compiler.c,206 :: 		if (sysMode == 2) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt167
	MOVLW      2
	XORWF      _sysMode+0, 0
L__interrupt167:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt41
;Proj1Compiler.c,207 :: 		if (swState == 0) {
	MOVLW      0
	XORWF      _swState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt168
	MOVLW      0
	XORWF      _swState+0, 0
L__interrupt168:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt42
;Proj1Compiler.c,208 :: 		swState = 1;
	MOVLW      1
	MOVWF      _swState+0
	MOVLW      0
	MOVWF      _swState+1
;Proj1Compiler.c,209 :: 		} else {
	GOTO       L_interrupt43
L_interrupt42:
;Proj1Compiler.c,210 :: 		swState = 0;
	CLRF       _swState+0
	CLRF       _swState+1
;Proj1Compiler.c,211 :: 		}
L_interrupt43:
;Proj1Compiler.c,212 :: 		}
L_interrupt41:
;Proj1Compiler.c,214 :: 		if (sysMode == 3) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt169
	MOVLW      3
	XORWF      _sysMode+0, 0
L__interrupt169:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt44
;Proj1Compiler.c,215 :: 		if (tmrState == 0) {
	MOVLW      0
	XORWF      _tmrState+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt170
	MOVLW      0
	XORWF      _tmrState+0, 0
L__interrupt170:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt45
;Proj1Compiler.c,216 :: 		tmrState = 1;
	MOVLW      1
	MOVWF      _tmrState+0
	MOVLW      0
	MOVWF      _tmrState+1
;Proj1Compiler.c,217 :: 		} else {
	GOTO       L_interrupt46
L_interrupt45:
;Proj1Compiler.c,218 :: 		tmrState = 0;
	CLRF       _tmrState+0
	CLRF       _tmrState+1
;Proj1Compiler.c,219 :: 		}
L_interrupt46:
;Proj1Compiler.c,220 :: 		}
L_interrupt44:
;Proj1Compiler.c,221 :: 		}
L_interrupt34:
;Proj1Compiler.c,224 :: 		if (PORTB.f5 == 0) {
	BTFSC      PORTB+0, 5
	GOTO       L_interrupt47
;Proj1Compiler.c,225 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt48:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt48
	DECFSZ     R12+0, 1
	GOTO       L_interrupt48
	DECFSZ     R11+0, 1
	GOTO       L_interrupt48
	NOP
	NOP
;Proj1Compiler.c,227 :: 		if (sysMode == 0 || sysMode == 1) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt171
	MOVLW      0
	XORWF      _sysMode+0, 0
L__interrupt171:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt138
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt172
	MOVLW      1
	XORWF      _sysMode+0, 0
L__interrupt172:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt138
	GOTO       L_interrupt51
L__interrupt138:
;Proj1Compiler.c,228 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,229 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,230 :: 		hours = 0;
	CLRF       _hours+0
	CLRF       _hours+1
;Proj1Compiler.c,231 :: 		}
L_interrupt51:
;Proj1Compiler.c,233 :: 		if (sysMode == 2) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt173
	MOVLW      2
	XORWF      _sysMode+0, 0
L__interrupt173:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt52
;Proj1Compiler.c,234 :: 		swSeconds = 0;
	CLRF       _swSeconds+0
	CLRF       _swSeconds+1
;Proj1Compiler.c,235 :: 		swMinutes = 0;
	CLRF       _swMinutes+0
	CLRF       _swMinutes+1
;Proj1Compiler.c,236 :: 		}
L_interrupt52:
;Proj1Compiler.c,238 :: 		if (sysMode == 3) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt174
	MOVLW      3
	XORWF      _sysMode+0, 0
L__interrupt174:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt53
;Proj1Compiler.c,239 :: 		tmrSeconds = 0;
	CLRF       _tmrSeconds+0
	CLRF       _tmrSeconds+1
;Proj1Compiler.c,240 :: 		tmrMinutes = 0;
	CLRF       _tmrMinutes+0
	CLRF       _tmrMinutes+1
;Proj1Compiler.c,241 :: 		}
L_interrupt53:
;Proj1Compiler.c,242 :: 		}
L_interrupt47:
;Proj1Compiler.c,245 :: 		if (PORTB.f6 == 0) {
	BTFSC      PORTB+0, 6
	GOTO       L_interrupt54
;Proj1Compiler.c,246 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt55:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt55
	DECFSZ     R12+0, 1
	GOTO       L_interrupt55
	DECFSZ     R11+0, 1
	GOTO       L_interrupt55
	NOP
	NOP
;Proj1Compiler.c,248 :: 		if (digitFlag == 0) {
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt175
	MOVLW      0
	XORWF      _digitFlag+0, 0
L__interrupt175:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt56
;Proj1Compiler.c,249 :: 		digitFlag = 1;
	MOVLW      1
	MOVWF      _digitFlag+0
	MOVLW      0
	MOVWF      _digitFlag+1
;Proj1Compiler.c,250 :: 		} else if (digitFlag == 1) {
	GOTO       L_interrupt57
L_interrupt56:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt176
	MOVLW      1
	XORWF      _digitFlag+0, 0
L__interrupt176:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt58
;Proj1Compiler.c,251 :: 		digitFlag = 2;
	MOVLW      2
	MOVWF      _digitFlag+0
	MOVLW      0
	MOVWF      _digitFlag+1
;Proj1Compiler.c,252 :: 		} else if (digitFlag == 2) {
	GOTO       L_interrupt59
L_interrupt58:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt177
	MOVLW      2
	XORWF      _digitFlag+0, 0
L__interrupt177:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt60
;Proj1Compiler.c,253 :: 		digitFlag = 0;
	CLRF       _digitFlag+0
	CLRF       _digitFlag+1
;Proj1Compiler.c,254 :: 		}
L_interrupt60:
L_interrupt59:
L_interrupt57:
;Proj1Compiler.c,255 :: 		}
L_interrupt54:
;Proj1Compiler.c,258 :: 		if (PORTB.f7 == 0) {
	BTFSC      PORTB+0, 7
	GOTO       L_interrupt61
;Proj1Compiler.c,259 :: 		delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_interrupt62:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt62
	DECFSZ     R12+0, 1
	GOTO       L_interrupt62
	DECFSZ     R11+0, 1
	GOTO       L_interrupt62
	NOP
	NOP
;Proj1Compiler.c,261 :: 		if (digitFlag == 1 && (clockMode == 0 || clockMode == 1)) {
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt178
	MOVLW      1
	XORWF      _digitFlag+0, 0
L__interrupt178:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt67
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt179
	MOVLW      0
	XORWF      _clockMode+0, 0
L__interrupt179:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt137
	MOVLW      0
	XORWF      _clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt180
	MOVLW      1
	XORWF      _clockMode+0, 0
L__interrupt180:
	BTFSC      STATUS+0, 2
	GOTO       L__interrupt137
	GOTO       L_interrupt67
L__interrupt137:
L__interrupt136:
;Proj1Compiler.c,262 :: 		hours = (hours + 1) % 24;
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
;Proj1Compiler.c,263 :: 		} else if (digitFlag == 2) {
	GOTO       L_interrupt68
L_interrupt67:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt181
	MOVLW      2
	XORWF      _digitFlag+0, 0
L__interrupt181:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt69
;Proj1Compiler.c,264 :: 		minutes = (minutes + 1) % 60;
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
;Proj1Compiler.c,265 :: 		}
L_interrupt69:
L_interrupt68:
;Proj1Compiler.c,268 :: 		if (digitFlag == 1 && timerMode == 0) {
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt182
	MOVLW      1
	XORWF      _digitFlag+0, 0
L__interrupt182:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt72
	MOVLW      0
	XORWF      _timerMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt183
	MOVLW      0
	XORWF      _timerMode+0, 0
L__interrupt183:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt72
L__interrupt135:
;Proj1Compiler.c,269 :: 		tmrMinutes = (tmrMinutes + 1) % 60;
	MOVF       _tmrMinutes+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _tmrMinutes+1, 0
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
	MOVWF      _tmrMinutes+0
	MOVF       R0+1, 0
	MOVWF      _tmrMinutes+1
;Proj1Compiler.c,270 :: 		} else if (digitFlag == 2 && sysMode == 3) {
	GOTO       L_interrupt73
L_interrupt72:
	MOVLW      0
	XORWF      _digitFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt184
	MOVLW      2
	XORWF      _digitFlag+0, 0
L__interrupt184:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt76
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt185
	MOVLW      3
	XORWF      _sysMode+0, 0
L__interrupt185:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt76
L__interrupt134:
;Proj1Compiler.c,271 :: 		tmrSeconds = (tmrSeconds + 1) % 60;
	MOVF       _tmrSeconds+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _tmrSeconds+1, 0
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
	MOVWF      _tmrSeconds+0
	MOVF       R0+1, 0
	MOVWF      _tmrSeconds+1
;Proj1Compiler.c,272 :: 		}
L_interrupt76:
L_interrupt73:
;Proj1Compiler.c,273 :: 		}
L_interrupt61:
;Proj1Compiler.c,275 :: 		INTCON.f0 = 0;  // Clear RB Port Change Interrupt Flag
	BCF        INTCON+0, 0
;Proj1Compiler.c,276 :: 		}
L_interrupt33:
;Proj1Compiler.c,278 :: 		INTCON.f7 = 1;  // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,279 :: 		}
L_end_interrupt:
L__interrupt159:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_updateClockDisplay:

;Proj1Compiler.c,282 :: 		void updateClockDisplay(int num, int segIndex) {
;Proj1Compiler.c,283 :: 		switch (segIndex) {
	GOTO       L_updateClockDisplay77
;Proj1Compiler.c,284 :: 		case 0:
L_updateClockDisplay79:
;Proj1Compiler.c,285 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,286 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,287 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay80:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay80
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay80
;Proj1Compiler.c,288 :: 		break;
	GOTO       L_updateClockDisplay78
;Proj1Compiler.c,289 :: 		case 1:
L_updateClockDisplay81:
;Proj1Compiler.c,290 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,291 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,292 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay82:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay82
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay82
;Proj1Compiler.c,293 :: 		break;
	GOTO       L_updateClockDisplay78
;Proj1Compiler.c,294 :: 		case 2:
L_updateClockDisplay83:
;Proj1Compiler.c,295 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,296 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,297 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay84:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay84
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay84
;Proj1Compiler.c,298 :: 		break;
	GOTO       L_updateClockDisplay78
;Proj1Compiler.c,299 :: 		case 3:
L_updateClockDisplay85:
;Proj1Compiler.c,300 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,301 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateClockDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,302 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateClockDisplay86:
	DECFSZ     R13+0, 1
	GOTO       L_updateClockDisplay86
	DECFSZ     R12+0, 1
	GOTO       L_updateClockDisplay86
;Proj1Compiler.c,303 :: 		break;
	GOTO       L_updateClockDisplay78
;Proj1Compiler.c,304 :: 		}
L_updateClockDisplay77:
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay187
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay187:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay79
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay188
	MOVLW      1
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay188:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay81
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay189
	MOVLW      2
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay189:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay83
	MOVLW      0
	XORWF      FARG_updateClockDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateClockDisplay190
	MOVLW      3
	XORWF      FARG_updateClockDisplay_segIndex+0, 0
L__updateClockDisplay190:
	BTFSC      STATUS+0, 2
	GOTO       L_updateClockDisplay85
L_updateClockDisplay78:
;Proj1Compiler.c,305 :: 		}
L_end_updateClockDisplay:
	RETURN
; end of _updateClockDisplay

_toggleClockTwelve:

;Proj1Compiler.c,308 :: 		void toggleClockTwelve(int hours, int minutes) {
;Proj1Compiler.c,309 :: 		if (0 < hours && hours < 13) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve192
	MOVF       FARG_toggleClockTwelve_hours+0, 0
	SUBLW      0
L__toggleClockTwelve192:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve89
	MOVLW      128
	XORWF      FARG_toggleClockTwelve_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwelve193
	MOVLW      13
	SUBWF      FARG_toggleClockTwelve_hours+0, 0
L__toggleClockTwelve193:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwelve89
L__toggleClockTwelve140:
;Proj1Compiler.c,310 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,311 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,312 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,313 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,314 :: 		} else {
	GOTO       L_toggleClockTwelve90
L_toggleClockTwelve89:
;Proj1Compiler.c,315 :: 		updateClockDisplay(abs(hours - 12) / 10, 0);
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
;Proj1Compiler.c,316 :: 		updateClockDisplay(abs(hours - 12) % 10, 1);
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
;Proj1Compiler.c,317 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,318 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,319 :: 		}
L_toggleClockTwelve90:
;Proj1Compiler.c,320 :: 		}
L_end_toggleClockTwelve:
	RETURN
; end of _toggleClockTwelve

_toggleClockTwentyFour:

;Proj1Compiler.c,323 :: 		void toggleClockTwentyFour(int hours, int minutes) {
;Proj1Compiler.c,324 :: 		if (hours < 24) {
	MOVLW      128
	XORWF      FARG_toggleClockTwentyFour_hours+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__toggleClockTwentyFour195
	MOVLW      24
	SUBWF      FARG_toggleClockTwentyFour_hours+0, 0
L__toggleClockTwentyFour195:
	BTFSC      STATUS+0, 0
	GOTO       L_toggleClockTwentyFour91
;Proj1Compiler.c,325 :: 		updateClockDisplay(hours / 10, 0);
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
;Proj1Compiler.c,326 :: 		updateClockDisplay(hours % 10, 1);
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
;Proj1Compiler.c,327 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,328 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,329 :: 		} else {
	GOTO       L_toggleClockTwentyFour92
L_toggleClockTwentyFour91:
;Proj1Compiler.c,330 :: 		updateClockDisplay(0, 0);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	CLRF       FARG_updateClockDisplay_segIndex+0
	CLRF       FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,331 :: 		updateClockDisplay(0, 1);
	CLRF       FARG_updateClockDisplay_num+0
	CLRF       FARG_updateClockDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateClockDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateClockDisplay_segIndex+1
	CALL       _updateClockDisplay+0
;Proj1Compiler.c,332 :: 		updateClockDisplay(minutes / 10, 2);
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
;Proj1Compiler.c,333 :: 		updateClockDisplay(minutes % 10, 3);
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
;Proj1Compiler.c,334 :: 		}
L_toggleClockTwentyFour92:
;Proj1Compiler.c,335 :: 		}
L_end_toggleClockTwentyFour:
	RETURN
; end of _toggleClockTwentyFour

_clock:

;Proj1Compiler.c,338 :: 		void clock(int hours, int minutes, int clockMode) {
;Proj1Compiler.c,339 :: 		switch (clockMode) {
	GOTO       L_clock93
;Proj1Compiler.c,340 :: 		case 0:
L_clock95:
;Proj1Compiler.c,341 :: 		toggleClockTwelve(hours, minutes);
	MOVF       FARG_clock_hours+0, 0
	MOVWF      FARG_toggleClockTwelve_hours+0
	MOVF       FARG_clock_hours+1, 0
	MOVWF      FARG_toggleClockTwelve_hours+1
	MOVF       FARG_clock_minutes+0, 0
	MOVWF      FARG_toggleClockTwelve_minutes+0
	MOVF       FARG_clock_minutes+1, 0
	MOVWF      FARG_toggleClockTwelve_minutes+1
	CALL       _toggleClockTwelve+0
;Proj1Compiler.c,342 :: 		break;
	GOTO       L_clock94
;Proj1Compiler.c,343 :: 		case 1:
L_clock96:
;Proj1Compiler.c,344 :: 		toggleClockTwentyFour(hours, minutes);
	MOVF       FARG_clock_hours+0, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+0
	MOVF       FARG_clock_hours+1, 0
	MOVWF      FARG_toggleClockTwentyFour_hours+1
	MOVF       FARG_clock_minutes+0, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+0
	MOVF       FARG_clock_minutes+1, 0
	MOVWF      FARG_toggleClockTwentyFour_minutes+1
	CALL       _toggleClockTwentyFour+0
;Proj1Compiler.c,345 :: 		break;
	GOTO       L_clock94
;Proj1Compiler.c,346 :: 		}
L_clock93:
	MOVLW      0
	XORWF      FARG_clock_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__clock197
	MOVLW      0
	XORWF      FARG_clock_clockMode+0, 0
L__clock197:
	BTFSC      STATUS+0, 2
	GOTO       L_clock95
	MOVLW      0
	XORWF      FARG_clock_clockMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__clock198
	MOVLW      1
	XORWF      FARG_clock_clockMode+0, 0
L__clock198:
	BTFSC      STATUS+0, 2
	GOTO       L_clock96
L_clock94:
;Proj1Compiler.c,347 :: 		}
L_end_clock:
	RETURN
; end of _clock

_updateStopWatchDisplay:

;Proj1Compiler.c,350 :: 		void updateStopWatchDisplay(int num, int segIndex) {
;Proj1Compiler.c,351 :: 		switch (segIndex) {
	GOTO       L_updateStopWatchDisplay97
;Proj1Compiler.c,352 :: 		case 0:
L_updateStopWatchDisplay99:
;Proj1Compiler.c,353 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,354 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,355 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay100:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay100
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay100
;Proj1Compiler.c,356 :: 		break;
	GOTO       L_updateStopWatchDisplay98
;Proj1Compiler.c,357 :: 		case 1:
L_updateStopWatchDisplay101:
;Proj1Compiler.c,358 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,359 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,360 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay102:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay102
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay102
;Proj1Compiler.c,361 :: 		break;
	GOTO       L_updateStopWatchDisplay98
;Proj1Compiler.c,362 :: 		case 2:
L_updateStopWatchDisplay103:
;Proj1Compiler.c,363 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,364 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,365 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay104:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay104
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay104
;Proj1Compiler.c,366 :: 		break;
	GOTO       L_updateStopWatchDisplay98
;Proj1Compiler.c,367 :: 		case 3:
L_updateStopWatchDisplay105:
;Proj1Compiler.c,368 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,369 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateStopWatchDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,370 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateStopWatchDisplay106:
	DECFSZ     R13+0, 1
	GOTO       L_updateStopWatchDisplay106
	DECFSZ     R12+0, 1
	GOTO       L_updateStopWatchDisplay106
;Proj1Compiler.c,371 :: 		break;
	GOTO       L_updateStopWatchDisplay98
;Proj1Compiler.c,372 :: 		}
L_updateStopWatchDisplay97:
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay200
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay200:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay99
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay201
	MOVLW      1
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay201:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay101
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay202
	MOVLW      2
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay202:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay103
	MOVLW      0
	XORWF      FARG_updateStopWatchDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateStopWatchDisplay203
	MOVLW      3
	XORWF      FARG_updateStopWatchDisplay_segIndex+0, 0
L__updateStopWatchDisplay203:
	BTFSC      STATUS+0, 2
	GOTO       L_updateStopWatchDisplay105
L_updateStopWatchDisplay98:
;Proj1Compiler.c,373 :: 		}
L_end_updateStopWatchDisplay:
	RETURN
; end of _updateStopWatchDisplay

_stopWatch:

;Proj1Compiler.c,376 :: 		void stopWatch(int swMinutes, int swSeconds) {
;Proj1Compiler.c,378 :: 		if (swMinutes < 100) {
	MOVLW      128
	XORWF      FARG_stopWatch_swMinutes+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__stopWatch205
	MOVLW      100
	SUBWF      FARG_stopWatch_swMinutes+0, 0
L__stopWatch205:
	BTFSC      STATUS+0, 0
	GOTO       L_stopWatch107
;Proj1Compiler.c,379 :: 		updateStopWatchDisplay(swMinutes / 10, 0);
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
;Proj1Compiler.c,380 :: 		updateStopWatchDisplay(swMinutes % 10, 1);
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
;Proj1Compiler.c,381 :: 		updateStopWatchDisplay(swSeconds / 10, 2);
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
;Proj1Compiler.c,382 :: 		updateStopWatchDisplay(swSeconds % 10, 3);
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
;Proj1Compiler.c,383 :: 		} else {
	GOTO       L_stopWatch108
L_stopWatch107:
;Proj1Compiler.c,384 :: 		updateStopWatchDisplay(0, 0);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	CLRF       FARG_updateStopWatchDisplay_segIndex+0
	CLRF       FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,385 :: 		updateStopWatchDisplay(0, 1);
	CLRF       FARG_updateStopWatchDisplay_num+0
	CLRF       FARG_updateStopWatchDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateStopWatchDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateStopWatchDisplay_segIndex+1
	CALL       _updateStopWatchDisplay+0
;Proj1Compiler.c,386 :: 		updateStopWatchDisplay(swSeconds / 10, 2);
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
;Proj1Compiler.c,387 :: 		updateStopWatchDisplay(swSeconds % 10, 3);
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
;Proj1Compiler.c,388 :: 		}
L_stopWatch108:
;Proj1Compiler.c,389 :: 		}
L_end_stopWatch:
	RETURN
; end of _stopWatch

_updateTimerDisplay:

;Proj1Compiler.c,392 :: 		void updateTimerDisplay(int num, int segIndex) {
;Proj1Compiler.c,393 :: 		switch (segIndex) {
	GOTO       L_updateTimerDisplay109
;Proj1Compiler.c,394 :: 		case 0:
L_updateTimerDisplay111:
;Proj1Compiler.c,395 :: 		PORTD = 0x01;  // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,396 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,397 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay112:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay112
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay112
;Proj1Compiler.c,398 :: 		break;
	GOTO       L_updateTimerDisplay110
;Proj1Compiler.c,399 :: 		case 1:
L_updateTimerDisplay113:
;Proj1Compiler.c,400 :: 		PORTD = 0x02;  // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,401 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,402 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay114:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay114
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay114
;Proj1Compiler.c,403 :: 		break;
	GOTO       L_updateTimerDisplay110
;Proj1Compiler.c,404 :: 		case 2:
L_updateTimerDisplay115:
;Proj1Compiler.c,405 :: 		PORTD = 0x04;  // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,406 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,407 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay116:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay116
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay116
;Proj1Compiler.c,408 :: 		break;
	GOTO       L_updateTimerDisplay110
;Proj1Compiler.c,409 :: 		case 3:
L_updateTimerDisplay117:
;Proj1Compiler.c,410 :: 		PORTD = 0x08;  // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,411 :: 		PORTC = dispDigit[num];
	MOVF       FARG_updateTimerDisplay_num+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,412 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_updateTimerDisplay118:
	DECFSZ     R13+0, 1
	GOTO       L_updateTimerDisplay118
	DECFSZ     R12+0, 1
	GOTO       L_updateTimerDisplay118
;Proj1Compiler.c,413 :: 		break;
	GOTO       L_updateTimerDisplay110
;Proj1Compiler.c,414 :: 		}
L_updateTimerDisplay109:
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay207
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay207:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay111
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay208
	MOVLW      1
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay208:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay113
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay209
	MOVLW      2
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay209:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay115
	MOVLW      0
	XORWF      FARG_updateTimerDisplay_segIndex+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__updateTimerDisplay210
	MOVLW      3
	XORWF      FARG_updateTimerDisplay_segIndex+0, 0
L__updateTimerDisplay210:
	BTFSC      STATUS+0, 2
	GOTO       L_updateTimerDisplay117
L_updateTimerDisplay110:
;Proj1Compiler.c,415 :: 		}
L_end_updateTimerDisplay:
	RETURN
; end of _updateTimerDisplay

_timer:

;Proj1Compiler.c,418 :: 		void timer(int tmrMinutes, int tmrSeconds) {
;Proj1Compiler.c,420 :: 		if (tmrMinutes < 100) {
	MOVLW      128
	XORWF      FARG_timer_tmrMinutes+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__timer212
	MOVLW      100
	SUBWF      FARG_timer_tmrMinutes+0, 0
L__timer212:
	BTFSC      STATUS+0, 0
	GOTO       L_timer119
;Proj1Compiler.c,421 :: 		updateTimerDisplay(tmrMinutes / 10, 0);
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
;Proj1Compiler.c,422 :: 		updateTimerDisplay(tmrMinutes % 10, 1);
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
;Proj1Compiler.c,423 :: 		updateTimerDisplay(tmrSeconds / 10, 2);
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
;Proj1Compiler.c,424 :: 		updateTimerDisplay(tmrSeconds % 10, 3);
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
;Proj1Compiler.c,425 :: 		} else {
	GOTO       L_timer120
L_timer119:
;Proj1Compiler.c,426 :: 		updateTimerDisplay(0, 0);
	CLRF       FARG_updateTimerDisplay_num+0
	CLRF       FARG_updateTimerDisplay_num+1
	CLRF       FARG_updateTimerDisplay_segIndex+0
	CLRF       FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,427 :: 		updateTimerDisplay(0, 1);
	CLRF       FARG_updateTimerDisplay_num+0
	CLRF       FARG_updateTimerDisplay_num+1
	MOVLW      1
	MOVWF      FARG_updateTimerDisplay_segIndex+0
	MOVLW      0
	MOVWF      FARG_updateTimerDisplay_segIndex+1
	CALL       _updateTimerDisplay+0
;Proj1Compiler.c,428 :: 		updateTimerDisplay(tmrSeconds / 10, 2);
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
;Proj1Compiler.c,429 :: 		updateTimerDisplay(tmrSeconds % 10, 3);
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
;Proj1Compiler.c,430 :: 		}
L_timer120:
;Proj1Compiler.c,431 :: 		}
L_end_timer:
	RETURN
; end of _timer

_main:

;Proj1Compiler.c,449 :: 		void main() {
;Proj1Compiler.c,450 :: 		portInit();                 // Initialize the ports
	CALL       _portInit+0
;Proj1Compiler.c,451 :: 		interruptInit();            // Initialize the interrupts
	CALL       _interruptInit+0
;Proj1Compiler.c,453 :: 		while (1) {
L_main121:
;Proj1Compiler.c,454 :: 		if (sysMode == 0 || sysMode == 1) {
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main214
	MOVLW      0
	XORWF      _sysMode+0, 0
L__main214:
	BTFSC      STATUS+0, 2
	GOTO       L__main141
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main215
	MOVLW      1
	XORWF      _sysMode+0, 0
L__main215:
	BTFSC      STATUS+0, 2
	GOTO       L__main141
	GOTO       L_main125
L__main141:
;Proj1Compiler.c,455 :: 		clock(hours, minutes, clockMode);
	MOVF       _hours+0, 0
	MOVWF      FARG_clock_hours+0
	MOVF       _hours+1, 0
	MOVWF      FARG_clock_hours+1
	MOVF       _minutes+0, 0
	MOVWF      FARG_clock_minutes+0
	MOVF       _minutes+1, 0
	MOVWF      FARG_clock_minutes+1
	MOVF       _clockMode+0, 0
	MOVWF      FARG_clock_clockMode+0
	MOVF       _clockMode+1, 0
	MOVWF      FARG_clock_clockMode+1
	CALL       _clock+0
;Proj1Compiler.c,456 :: 		} else if (sysMode == 2) {
	GOTO       L_main126
L_main125:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main216
	MOVLW      2
	XORWF      _sysMode+0, 0
L__main216:
	BTFSS      STATUS+0, 2
	GOTO       L_main127
;Proj1Compiler.c,457 :: 		stopWatch(swMinutes, swSeconds);
	MOVF       _swMinutes+0, 0
	MOVWF      FARG_stopWatch_swMinutes+0
	MOVF       _swMinutes+1, 0
	MOVWF      FARG_stopWatch_swMinutes+1
	MOVF       _swSeconds+0, 0
	MOVWF      FARG_stopWatch_swSeconds+0
	MOVF       _swSeconds+1, 0
	MOVWF      FARG_stopWatch_swSeconds+1
	CALL       _stopWatch+0
;Proj1Compiler.c,458 :: 		} else if (sysMode == 3) {
	GOTO       L_main128
L_main127:
	MOVLW      0
	XORWF      _sysMode+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main217
	MOVLW      3
	XORWF      _sysMode+0, 0
L__main217:
	BTFSS      STATUS+0, 2
	GOTO       L_main129
;Proj1Compiler.c,459 :: 		timer(tmrMinutes, tmrSeconds);
	MOVF       _tmrMinutes+0, 0
	MOVWF      FARG_timer_tmrMinutes+0
	MOVF       _tmrMinutes+1, 0
	MOVWF      FARG_timer_tmrMinutes+1
	MOVF       _tmrSeconds+0, 0
	MOVWF      FARG_timer_tmrSeconds+0
	MOVF       _tmrSeconds+1, 0
	MOVWF      FARG_timer_tmrSeconds+1
	CALL       _timer+0
;Proj1Compiler.c,461 :: 		}  // TODO: Add a case for the alarm
L_main129:
L_main128:
L_main126:
;Proj1Compiler.c,462 :: 		}
	GOTO       L_main121
;Proj1Compiler.c,463 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
