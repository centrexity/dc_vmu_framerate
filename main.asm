

;=======================;
;   Define Variables:   ;
;=======================;
p3_pressed              =       $4      ; 1 Byte (For LibKCommon)
p3_last_input           =       $5      ; 1 Byte (For LibKCommon)

frame_num				=		$6		; 2 bytes

;=======================;
;VMU Application Header ;
;=======================;
.include "GameHeader.i"

;=======================;
;  Prepare Application  ;
;=======================;
	.org	$00
	jmpf	start

	.org	$03
	reti	

	.org	$0b
	reti	
	
	.org	$13
	reti	

	.org	$1b
	jmpf	t1int
	
	.org	$23
	reti	

	.org	$2b
	reti	
	
	.org	$33
	reti	

	.org	$3b
	reti	

	.org	$43
	reti	

	.org	$4b
	clr1	p3int,0
	clr1	p3int,1
	reti

;nop_irq:
;	reti

	.org	$130	
t1int:
	push	ie
	clr1	ie,7
	not1	ext,0
	jmpf	t1int
	pop	ie
	reti

	.org	$1f0

goodbye:	
	not1	ext,0
	jmpf	goodbye

;__goodbye:	
;	not1	ext,0
;	jmpf	goodbye

;=======================;
;     Main Program      ;
;=======================;
; Via LibPerspective: Trying To Get It To Work On VMU Hardware.
.org    $54B
    mov     #$a1, ocr
    mov     #%00001001, mcr
    mov     #$80, vccr
    mov     #$20, acc
    push    acc

    mov     #$ff, p3
    mov     #$80, sp
    mov     #%10000000, ie
    clr1    psw, 3
    clr1    psw, 4
    mov     #$05, acc
    push    acc

    mov     #$80, p1fcr
    clr1    p1,7
    mov     #$80, p1ddr

    ; Disable battery check
    ; clr1    psw, 1
    ; mov     #$ff, $006E
    ; set1    psw, 1

    ; ???
    ret

    ; Initialise the p3_last_input
    mov     #%11111111, p3_last_input

start:
	clr1 ie,7
	mov #$a1,ocr
	mov #$09,mcr
	mov #$80,vccr
	clr1 p3int,0
	clr1 p1,7
	mov #$ff,p3
	set1 ie,7




Main_Loop:
    callf   Get_Input ; This Function Is In LibKCommon.ASM Ensure We Can Enter Sleep Mode + Exit App With The Mode Button.
    ;ld	p3
	;P_Draw_Background_Constant Hello_World_Background
	;P_Blit_Screen
	;callf Movie
	Movie
	jmpf Main_Loop



;TurnOffLCD:
;	mov #0,vccr     ; turn off LCD

;TurnOnLCD:
;	mov #$80,vccr	; Reenable LCD


;SleepMS:
;	;set1 pcon,0 	; halt for interrupt ; Setting this bit to 1 will cause the CPU to stop executing instructions. All timers and peripherals will keep operating normally while the CPU is stopped, and any interrupt will wake the CPU up.
;	nop
;	ret

;might not do x and y just address
;%macro  setpixel_black %x, %y
;%end
;%macro  setpixel_white %x, %y
;%end

;Loop:
;    P_Invert_Screen
;    P_Blit_Screen
;    jmpf Loop


;=======================;
;   Include Libraries   ;
;=======================;
.include "./libperspective/libperspective.asm"
.include "./libperspective/libkcommon.asm"
.include "./libperspective/sfr.i"


;=======================;
;    Include  Images    ;
;=======================;
	.include        "./asm_code.asm"
	.include        "./asm_data.asm"

	.cnop	0,$200		; Pad To An Even Number Of Blocks