.386
.MODEL FLAT, STDCALL

include windows.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

.DATA
	ARQUIVO 	db	 "TESTE.TXT",0
	CAPTION 	db     "Atencao!",0
	OK 			db	 "Arquivo gravado com sucesso",0
	ERRO 		db 	"Impossivel gravar arquivo",0
	
.DATA?
	hFile HANDLE ?

.CODE
	start: 
    		;invoke CreateFile, addr ARQUIVO, GENERIC_READ OR GENERIC_WRITE, FILE_SHARE_READ OR FILE_SHARE_WRITE,  NULL,CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    		push NULL
    		push FILE_ATTRIBUTE_NORMAL
    		push CREATE_ALWAYS
    		push NULL
    		push FILE_SHARE_READ OR FILE_SHARE_WRITE
    		push GENERIC_READ OR GENERIC_WRITE
    		push offset ARQUIVO
    		mov hFile,eax
    		cmp hFile, INVALID_HANDLE_VALUE
    		jz erro
    		;invoke MessageBox, NULL, addr OK, addr CAPTION , MB_OK
    		push MB_OK
    		push offset CAPTION
    		push offset OK
    		push offset NULL
    		call MessageBox    	
    		jmp exit
	erro:
   		;invoke MessageBox, NULL, addr ERRO,addr CAPTION,MB_OK
   		push MB_OK
   		push offset CAPTION
   		push offset ERRO
   		push NULL
   		call MessageBox
    		jmp exit
    	exit:
    		;invoke ExitProcess,0
    		push NULL
    		call ExitProcess
	end start