	.include "./m48def.inc"				
	.def temp = r16
	.def izq = r17
	.def temp2 = r18
	.def cont1 = r19
	.def cont2 = r20
	.def rpinc = r21

	.cseg
	.org 0
	rjmp reset

	;;.org $010
	;;rjmp timer_cero

reset:
	ldi temp,$00 									;Puerto de entrada C
	out ddrc,temp
	ldi temp,$06									;Pull-up para C 0b00000110
	out portc,temp
	ldi temp,$ff									;Puerto de salida D HIGH
	out ddrd,temp
	ldi temp,$ff
	out ddrb,temp									;Puerto de salida B LOW

	;; ldi temp,$04
	;; out tccr0b,temp
	;; ldi temp,$01
	;; sts timsk0,temp
	;; sei

	;;ldi temp2,$01
	
	;;rcall delay_125m
	;;ldi izq,$01

main:
	in rpinc,pinc	;;leo a pinc y se lo asigno a rpinc
	andi rpinc,$06	;;le hago and a rpinc y 6
	cpi rpinc,$06	;;cuando no aprieto nada
	breq dibujoana  ;; ya esta bien inicio
	cpi rpinc,$04
	breq jumpsalto1	  ;;
	cpi rpinc,$02 
	breq dibujitoana	;;
	cpi rpinc,$00 		;;
	breq jumpsalto2   ;;
	ldi temp2,$ff
	out portb,temp2
	rjmp main
	

dibujoana:
	
	ldi temp2,$02
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$04
	out portd,temp2
	ldi temp2,$a5
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$08
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$10
	out portd,temp2
	ldi temp2,$bd
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$20
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$40
	out portd,temp2
	ldi temp2,$db
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$80
	out portd,temp2
	ldi temp2,$99
	out portb,temp2
	rcall delay_62m
	
	rjmp main

jumpsalto1: 
	rjmp dibujoerick
	
jumpsalto2:
	rjmp dibujitoerick

dibujitoana:
	
	ldi temp2,$01
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$02
	out portd,temp2
	ldi temp2,$a5
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$04
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$08
	out portd,temp2
	ldi temp2,$bd
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$10
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$20
	out portd,temp2
	ldi temp2,$db
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$40
	out portd,temp2
	ldi temp2,$99
	out portb,temp2
	rcall delay_62m
	
	rjmp main



dibujoerick:

	ldi temp2,$02
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$04
	out portd,temp2
	ldi temp2,$a5
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$08
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$10
	out portd,temp2
	ldi temp2,$bd
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$20
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$40
	out portd,temp2
	ldi temp2,$bd
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$80
	out portd,temp2
	ldi temp2,$3c
	out portb,temp2
	rcall delay_62m

	rjmp main

dibujitoerick:

	ldi temp2,$01
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$02
	out portd,temp2
	ldi temp2,$a5
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$04
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$08
	out portd,temp2
	ldi temp2,$bd
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$10
	out portd,temp2
	ldi temp2,$81
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$20
	out portd,temp2
	ldi temp2,$bd
	out portb,temp2
	rcall delay_62m
	
	ldi temp2,$40
	out portd,temp2
	ldi temp2,$3c
	out portb,temp2
	rcall delay_62m

	rjmp main

	
delay_125m:
	ldi cont1,200
lazo2:
	ldi cont2,200
lazo1:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	dec cont2
	brne lazo1
	dec cont1
	brne lazo2
	ret

delay_62m:
	ldi cont1,63
lazo4:
	ldi cont2,1
lazo3:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	dec cont2
	brne lazo3
	dec cont1
	brne lazo4
	ret

	;; *** interrupciones
	
timer_cero:
	in temp,pind
	com temp
	andi temp,$01
	or temp,temp2
	out portd,temp
	reti
