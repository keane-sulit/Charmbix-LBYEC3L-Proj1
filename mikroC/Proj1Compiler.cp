#line 1 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
#line 15 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
char count[10] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};

enum project_modes {
 CLOCK,
 STOPWATCH,
 COUNTDOWN_TIMER
};

enum clock_modes {
 CLOCK_12H,
 CLOCK_24H,
};

int mode = CLOCK_12H;

int hours = 12;
int minutes = 59;

int i;

void interrupt() {
 if (INTCON.RBIF) {
 INTCON.RBIF = 0;
 if (PORTB.f7 == 0) {
 if(mode == CLOCK_12H) {
 mode = CLOCK_24H;
 } else {
 mode = CLOCK_12H;
 }
 }
 }
}
void init() {
 TRISB.f7 = 1;
 TRISC = 0x00;
 TRISD = 0x00;
}

void disp_dig(int dig, int seg) {
 switch(seg){
 case 1:
 PORTD = 0x0E;
 PORTC = count[dig];
 delay_ms(10);
 break;
 case 2:
 PORTD = 0x0D;
 PORTC = count[dig];
 delay_ms(10);
 break;
 case 3:
 PORTD = 0x0B;
 PORTC = count[dig];
 delay_ms(10);
 break;
 case 4:
 PORTD = 0x07;
 PORTC = count[dig];
 delay_ms(10);
 break;
 }
}

void disp_time(int hours, int minutes) {
 for (i = 0; i < 25; i++) {
 disp_dig(hours / 10, 1);
 disp_dig(hours % 10, 2);
 disp_dig(minutes / 10, 3);
 disp_dig(minutes % 10, 4);
 }
}

void inc_time() {
 if (minutes > 59) {
 minutes = 0;
 hours++;
 if (mode == CLOCK_12H) {
 if (hours > 12) {
 hours = 1;
 }
 } else {
 if (hours > 23) {
 hours = 0;
 }
 }
 }
 minutes++;
}

void modes() {
#line 118 "//Mac/Home/Documents/GitHub/Charmbix-LBYEC3L-Proj1/mikroC/Proj1Compiler.c"
}

void main() {
 init();
 disp_time(hours, minutes);
 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 INTCON.RBIE = 1;
 INTCON.RBIF = 0;
 OPTION_REG.f7 = 1;


 while(1) {
 disp_time(hours, minutes);
 inc_time();
 delay_ms(50);
 }
}
