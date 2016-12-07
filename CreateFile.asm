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

.DATA
	ARQUIVO 	db	 "TESTE.TXT",0
	CAPTION 	db     "Atencao!",0
	OK 			db	 "Arquivo gravado com sucesso",0
	ERRO 		db 	"Impossivel gravar arquivo",0
	
.DATA?
	hFile HANDLE ?

.CODE
	start: 
    		invoke CreateFile, addr ARQUIVO, GENERIC_READ OR GENERIC_WRITE, FILE_SHARE_READ OR FILE_SHARE_WRITE,  NULL,CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    		mov hFile,eax
    		cmp hFile, INVALID_HANDLE_VALUE
    		jz erro
    		invoke MessageBox, NULL, addr OK, addr CAPTION , MB_OK
		invoke ExitProcess,NULL
	erro:
   		invoke MessageBox, NULL, addr ERRO,addr CAPTION,MB_OK
   		invoke ExitProcess,NULL
	end start 
