;Exemplo de programacao em Assembly com WinASM 
;Ivan S. Vargas | www.is5.com.br | contato@is5.com.br
;01/2016

.386
.MODEL FLAT, STDCALL

include windows.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

.data
caption db "Mensagem",0
texto  db "Ola Mundo!",0

.code
	start:
		invoke MessageBox,NULL,addr texto,addr caption,MB_OK
				
		invoke ExitProcess,NULL
	end start