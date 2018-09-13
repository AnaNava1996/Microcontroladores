;;;programa para fast pwm

	.include "./m48def.inc"	
	.def cte = r15
	.def temp = r16
	.def cont1 = r17
	.def cont2 = r18
	.cseg
	.org 0
	
	ldi temp, $40
	out ddrd,temp
	ldi temp,$01
	out portc,temp
	
	ldi temp,$83
	out tccr0a,temp
	ldi temp,$02 			;;ante era $01
	out tccr0b,temp
	ldi temp,125
	out ocr0a,temp
	ldi temp,$05
	mov cte,temp
	
main: in temp,pinc			;;leo a pinc y se lo asigno a temp
	andi temp,$06			;;le hago and a temp y 2 
	cpi	temp,$02
	breq aumentar
	cpi temp,$04
	breq disminuir
	
	rjmp main	
	
aumentar:rcall delay_050ms
	in temp,ocr0a			;;leo a ocr0a y se lo asigno a temp
	add temp,cte			;;
	out ocr0a,temp
	rjmp main

disminuir:rcall delay_050ms
	in temp,ocr0a			;;leo a ocr0a y se lo asigno a temp
	sub temp,cte			;;
	out ocr0a,temp
	rjmp main

	
delay_050ms: ldi cont1,20
lazo2: ldi	cont2,250
lazo1: nop
		nop
		nop
		nop
		nop
		nop
		nop
		dec cont2
		brne lazo1  ;; si z not equal 1 
		dec cont1
		brne lazo2
		ret
	
	
	
