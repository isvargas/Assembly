.386
.MODEL FLAT,STDCALL

include windows.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

.data
	cmd db "calc.exe",0
	
.code
	start:
		invoke WinExec,addr cmd,SW_SHOW	;chama a funcao WinExec
		
		invoke ExitProcess,NULL				;sai do programa
	end start