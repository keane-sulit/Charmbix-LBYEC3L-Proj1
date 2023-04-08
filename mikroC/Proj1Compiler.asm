
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Proj1Compiler.c,38 :: 		void interrupt()
;Proj1Compiler.c,40 :: 		INTCON.f7 = 0; // Disable Global Interrupt
	BCF        INTCON+0, 7
;Proj1Compiler.c,43 :: 		if (INTCON.f2 == 1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;Proj1Compiler.c,45 :: 		if (tmr0Count == 2)
	MOVF       _tmr0Count+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;Proj1Compiler.c,47 :: 		tmr0Count = 0;
	CLRF       _tmr0Count+0
;Proj1Compiler.c,49 :: 		seconds++;
	INCF       _seconds+0, 1
	BTFSC      STATUS+0, 2
	INCF       _seconds+1, 1
;Proj1Compiler.c,50 :: 		if (seconds > 59)
	MOVF       _seconds+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt20
	MOVF       _seconds+0, 0
	SUBLW      59
L__interrupt20:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt2
;Proj1Compiler.c,52 :: 		seconds = 0;
	CLRF       _seconds+0
	CLRF       _seconds+1
;Proj1Compiler.c,53 :: 		minutes++;
	INCF       _minutes+0, 1
	BTFSC      STATUS+0, 2
	INCF       _minutes+1, 1
;Proj1Compiler.c,54 :: 		if (minutes > 59)
	MOVF       _minutes+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt21
	MOVF       _minutes+0, 0
	SUBLW      59
L__interrupt21:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
;Proj1Compiler.c,56 :: 		minutes = 0;
	CLRF       _minutes+0
	CLRF       _minutes+1
;Proj1Compiler.c,57 :: 		hours++;
	INCF       _hours+0, 1
	BTFSC      STATUS+0, 2
	INCF       _hours+1, 1
;Proj1Compiler.c,60 :: 		switch (hoursFlag)
	GOTO       L_interrupt4
;Proj1Compiler.c,62 :: 		case 0:
L_interrupt6:
;Proj1Compiler.c,63 :: 		if (hours == 13)
	MOVLW      0
	XORWF      _hours+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt22
	MOVLW      13
	XORWF      _hours+0, 0
L__interrupt22:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
;Proj1Compiler.c,65 :: 		hours = 1;
	MOVLW      1
	MOVWF      _hours+0
	MOVLW      0
	MOVWF      _hours+1
;Proj1Compiler.c,66 :: 		}
L_interrupt7:
;Proj1Compiler.c,67 :: 		break;
	GOTO       L_interrupt5
;Proj1Compiler.c,68 :: 		case 1:
L_interrupt8:
;Proj1Compiler.c,69 :: 		if (hours == 24)
	MOVLW      0
	XORWF      _hours+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt23
	MOVLW      24
	XORWF      _hours+0, 0
L__interrupt23:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt9
;Proj1Compiler.c,71 :: 		hours = 0;
	CLRF       _hours+0
	CLRF       _hours+1
;Proj1Compiler.c,72 :: 		}
L_interrupt9:
;Proj1Compiler.c,73 :: 		break;
	GOTO       L_interrupt5
;Proj1Compiler.c,74 :: 		}
L_interrupt4:
	MOVLW      0
	XORWF      _hoursFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt24
	MOVLW      0
	XORWF      _hoursFlag+0, 0
L__interrupt24:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt6
	MOVLW      0
	XORWF      _hoursFlag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt25
	MOVLW      1
	XORWF      _hoursFlag+0, 0
L__interrupt25:
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt8
L_interrupt5:
;Proj1Compiler.c,75 :: 		}
L_interrupt3:
;Proj1Compiler.c,76 :: 		}
L_interrupt2:
;Proj1Compiler.c,77 :: 		}
	GOTO       L_interrupt10
L_interrupt1:
;Proj1Compiler.c,80 :: 		tmr0Count++;
	INCF       _tmr0Count+0, 1
;Proj1Compiler.c,81 :: 		}
L_interrupt10:
;Proj1Compiler.c,82 :: 		INTCON.f2 = 0; // Clear TMR0 Interrupt Flag
	BCF        INTCON+0, 2
;Proj1Compiler.c,83 :: 		}
L_interrupt0:
;Proj1Compiler.c,87 :: 		if (INTCON.f1 == 1)
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt11
;Proj1Compiler.c,90 :: 		hoursFlag = ~hoursFlag; // Toggle between 12 and 24 hour mode
	COMF       _hoursFlag+0, 1
	COMF       _hoursFlag+1, 1
;Proj1Compiler.c,91 :: 		INTCON.f1 = 0;          // Clear RB0 External Interrupt Flag
	BCF        INTCON+0, 1
;Proj1Compiler.c,92 :: 		}
L_interrupt11:
;Proj1Compiler.c,94 :: 		INTCON.f7 = 1; // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,95 :: 		}
L_end_interrupt:
L__interrupt19:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_updateHoursTens:

;Proj1Compiler.c,97 :: 		int updateHoursTens()
;Proj1Compiler.c,99 :: 		hoursTens = hours / 10; // Get the tens digit of hours
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
	MOVWF      _hoursTens+0
	MOVF       R0+1, 0
	MOVWF      _hoursTens+1
;Proj1Compiler.c,100 :: 		return hoursTens;
;Proj1Compiler.c,101 :: 		}
L_end_updateHoursTens:
	RETURN
; end of _updateHoursTens

_updateHoursOnes:

;Proj1Compiler.c,103 :: 		int updateHoursOnes()
;Proj1Compiler.c,105 :: 		hoursOnes = hours % 10; // Get the ones digit of hours
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
;Proj1Compiler.c,106 :: 		return hoursOnes;
;Proj1Compiler.c,107 :: 		}
L_end_updateHoursOnes:
	RETURN
; end of _updateHoursOnes

_updateMinutesTens:

;Proj1Compiler.c,109 :: 		int updateMinutesTens()
;Proj1Compiler.c,111 :: 		minutesTens = minutes / 10; // Get the tens digit of minutes
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
	MOVWF      _minutesTens+0
	MOVF       R0+1, 0
	MOVWF      _minutesTens+1
;Proj1Compiler.c,112 :: 		return minutesTens;
;Proj1Compiler.c,113 :: 		}
L_end_updateMinutesTens:
	RETURN
; end of _updateMinutesTens

_updateMinutesOnes:

;Proj1Compiler.c,115 :: 		int updateMinutesOnes()
;Proj1Compiler.c,117 :: 		minutesOnes = minutes % 10; // Get the ones digit of minutes
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
;Proj1Compiler.c,118 :: 		return minutesOnes;
;Proj1Compiler.c,119 :: 		}
L_end_updateMinutesOnes:
	RETURN
; end of _updateMinutesOnes

_portInit:

;Proj1Compiler.c,121 :: 		void portInit()
;Proj1Compiler.c,123 :: 		TRISC = 0x00; // PORTC is the data bus
	CLRF       TRISC+0
;Proj1Compiler.c,124 :: 		TRISD = 0x00; // PORTD is the address bus
	CLRF       TRISD+0
;Proj1Compiler.c,125 :: 		}
L_end_portInit:
	RETURN
; end of _portInit

_interruptInit:

;Proj1Compiler.c,127 :: 		void interruptInit()
;Proj1Compiler.c,129 :: 		INTCON.f7 = 1; // Enable Global Interrupt
	BSF        INTCON+0, 7
;Proj1Compiler.c,130 :: 		INTCON.f6 = 1; // Enable Peripheral Interrupt
	BSF        INTCON+0, 6
;Proj1Compiler.c,131 :: 		INTCON.f5 = 1; // Enable TMR0 Interrupt
	BSF        INTCON+0, 5
;Proj1Compiler.c,132 :: 		INTCON.f4 = 1; // Enable RB0 External Interrupt Port Change Interrupt
	BSF        INTCON+0, 4
;Proj1Compiler.c,134 :: 		OPTION_REG.f5 = 0; // Internal Instruction Cycle Clock (CLKO)
	BCF        OPTION_REG+0, 5
;Proj1Compiler.c,135 :: 		OPTION_REG.f4 = 0; // Increment on Low-to-High Transition on T0CKI Pin
	BCF        OPTION_REG+0, 4
;Proj1Compiler.c,136 :: 		OPTION_REG.f3 = 0; // Prescaler is assigned to the Timer0 module
	BCF        OPTION_REG+0, 3
;Proj1Compiler.c,138 :: 		OPTION_REG.f2 = 0;
	BCF        OPTION_REG+0, 2
;Proj1Compiler.c,139 :: 		OPTION_REG.f1 = 0;
	BCF        OPTION_REG+0, 1
;Proj1Compiler.c,140 :: 		OPTION_REG.f0 = 1;
	BSF        OPTION_REG+0, 0
;Proj1Compiler.c,141 :: 		}
L_end_interruptInit:
	RETURN
; end of _interruptInit

_main:

;Proj1Compiler.c,143 :: 		void main()
;Proj1Compiler.c,145 :: 		portInit();
	CALL       _portInit+0
;Proj1Compiler.c,146 :: 		interruptInit();
	CALL       _interruptInit+0
;Proj1Compiler.c,148 :: 		while (1)
L_main12:
;Proj1Compiler.c,150 :: 		PORTD = 0x01; // Select the first digit
	MOVLW      1
	MOVWF      PORTD+0
;Proj1Compiler.c,151 :: 		PORTC = dispDigit[i];
	MOVF       _i+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,152 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
;Proj1Compiler.c,153 :: 		PORTD = 0x02; // Select the second digit
	MOVLW      2
	MOVWF      PORTD+0
;Proj1Compiler.c,154 :: 		PORTC = dispDigit[j];
	MOVF       _j+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,155 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
;Proj1Compiler.c,156 :: 		PORTD = 0x04; // Select the third digit
	MOVLW      4
	MOVWF      PORTD+0
;Proj1Compiler.c,157 :: 		PORTC = dispDigit[k];
	MOVF       _k+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,158 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
;Proj1Compiler.c,159 :: 		PORTD = 0x08; // Select the fourth digit
	MOVLW      8
	MOVWF      PORTD+0
;Proj1Compiler.c,160 :: 		PORTC = dispDigit[l];
	MOVF       _l+0, 0
	ADDLW      _dispDigit+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;Proj1Compiler.c,161 :: 		delay_ms(1);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
;Proj1Compiler.c,163 :: 		updateHoursTens();
	CALL       _updateHoursTens+0
;Proj1Compiler.c,164 :: 		updateHoursOnes();
	CALL       _updateHoursOnes+0
;Proj1Compiler.c,165 :: 		updateMinutesTens();
	CALL       _updateMinutesTens+0
;Proj1Compiler.c,166 :: 		updateMinutesOnes();
	CALL       _updateMinutesOnes+0
;Proj1Compiler.c,168 :: 		i = hoursTens;
	MOVF       _hoursTens+0, 0
	MOVWF      _i+0
	MOVF       _hoursTens+1, 0
	MOVWF      _i+1
;Proj1Compiler.c,169 :: 		j = hoursOnes;
	MOVF       _hoursOnes+0, 0
	MOVWF      _j+0
	MOVF       _hoursOnes+1, 0
	MOVWF      _j+1
;Proj1Compiler.c,170 :: 		k = minutesTens;
	MOVF       _minutesTens+0, 0
	MOVWF      _k+0
	MOVF       _minutesTens+1, 0
	MOVWF      _k+1
;Proj1Compiler.c,171 :: 		l = minutesOnes;
	MOVF       _minutesOnes+0, 0
	MOVWF      _l+0
	MOVF       _minutesOnes+1, 0
	MOVWF      _l+1
;Proj1Compiler.c,182 :: 		}
	GOTO       L_main12
;Proj1Compiler.c,183 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
