.386
.MODEL FLAT,STDCALL

.data 
	msg		db "This is a 16-bit DOS .EXE executable",13,10,"Hello, World!",13,10,"$"	; The string must end with a $

.code
	start:
		mov		ax,@data		; Get the address of the data segment
		mov		ds,ax		; Set the DS segment

	     	xor		cx,cx
	     	mov		cx, 5
	 mensagem:
		mov		dx,offset msg	; Get the address of our message in the DX
		mov		ah,9			; Function 09h in AH means "WRITE STRING TO STANDARD OUTPUT"
		int		21h			; Call the DOS interrupt (DOS function call)
		loop          mensagem
		
		mov		ax,0C07h		; Function 0Ch = "FLUSH BUFFER AND READ STANDARD INPUT"
		int		21h			; Waits for a key to be pressed.
		
		mov		ax, 4C00h	; the exit fuction  [4C+no error (00)]
		int		21h			; call DOS interrupt 21h
	end start