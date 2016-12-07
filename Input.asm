;Exemplo de programacao em Assembly com WinASM 
;Ivan S. Vargas | www.is5.com.br | contato@is5.com.br
;01/2016

.386
.MODEL FLAT,STDCALL

include masm32.inc
include gdi32.inc
include kernel32.inc
include user32.inc

include windows.inc
include \masm32\macros\macros.asm

includelib masm32.lib
includelib gdi32.lib
includelib kernel32.lib
includelib user32.lib

.DATA

.DATA?
	dados dw ?

.CODE
         LOCAL txtInput:DWORD
	START:
		mov txtInput,input("Digite algo:")
		print chr$(13,10)
		invoke Std
	END START
