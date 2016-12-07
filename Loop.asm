.386
.MODEL FLAT,STDCALL

include windows.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

.DATA
TEXT db "Ola mundo",0
TEXT2 db "Concluido!",0
CAPTION db "Atencao",0

.CODE
	START:
		xor ecx,ecx
		inc ecx
		.while ecx <= 5
			invoke MessageBox, NULL, ADDR TEXT, ADDR CAPTION, MB_OK
			inc ecx
		.endw
		;essa funcao nao funciona pq o while gera um condicional JBE que considera o 
		;valor das flgas CF e ZF - um destes deve ser igual a 1
		;porem, o MessageBox lanca um valor estranho em ECX apos a execucao, dai
		;a contagem ultrapassa os 5 e nao eh mais executado o loop
		invoke MessageBox, NULL, ADDR TEXT2, ADDR CAPTION, MB_OK
		invoke ExitProcess,NULL
	END START


