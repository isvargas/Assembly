msg MACRO text
	LOCAL Caption
	.data
		Caption db "Atencao",0
	.code
		;invoke MessageBox,NULL,text, caption,MB_OK
		push 0
		push  offset Caption
		push  text
		push NULL
		call MessageBox	
EndM