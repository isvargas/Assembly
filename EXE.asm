.386
.model	flat, stdcall
option	casemap:none

include		EXE.inc

.code
start:
	xor ecx,ecx	;zero ecx
	;enquanto ecx for menor que 5...
	.while ecx < 5
		push ecx	;salvo o ecx na pilha, pq a funcao MessageBox sobreescreve ax,ecx e outros valores
		invoke MessageBox, NULL,addr MsgBoxText, addr MsgCaption, MB_OK
		pop ecx	;busco o valor de ecx da pilha
		inc ecx	;decremento o valor de ecx
	.endw
	invoke ExitProcess,NULL	;saio do sistema
end start
