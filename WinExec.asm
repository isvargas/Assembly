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

;UINT WinExec(
;
;    LPCSTR  lpszCmdLine,	// address of command line 
;    UINT  fuCmdShow 	         // window style for new application 
;   );

.data
cmd  db 	'calc.exe',0

.code
	start:
		push SW_SHOW
		push offset cmd
		call 	WinExec
				
		push NULL
		call ExitProcess
	end start
	
