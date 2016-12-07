;Exemplo de programacao em Assembly com WinASM 
;Ivan S. Vargas | www.is5.com.br | contato@is5.com.br
;01/2016

.386
.MODEL FLAT,STDCALL

include windows.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

include macros.inc

.DATA
Caption db "Atencao",0
Text db "Teste",0
Text1 db "Macro 1",0
Text2 db "Macro 2",0

.CODE
	START:
		invoke MessageBox,NULL,addr Text, addr Caption,MB_OK
	
		msg offset Text1,offset Caption		
	
		msg2 offset Text2
	
		invoke ExitProcess,NULL
		 
	END START
	
