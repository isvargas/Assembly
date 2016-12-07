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
	ARQUIVO		db	 "TESTE.TXT",0
	CAPTION		db	 "Atencao!",0
	OK	        db	 "Arquivo GRAVADO com sucesso",0
	ERRO		db	 "Impossivel gravar arquivo",0
	TEXTO		db	 "ARQUIVO GRAVADO VIA ASSEMBLY",0
	SUCESSO	        db	 "Arquivo ESCRITO com sucesso!",0
	
	WRITED		dd	0
	
.DATA?
	hFile		HANDLE	 ?

.CODE
	start: 
		; assinatura da funcao da API do WIndows
	        ; HANDLE CreateFile(
		;    LPCTSTR  lpFileName,                                            // address of name of the file 
		;    DWORD  dwDesiredAccess,                                         // access (read-write) mode 
		;    DWORD  dwShareMode,	                                     // share mode 
		;    LPSECURITY_ATTRIBUTES  lpSecurityAttributes,    // address of security descriptor 
		;    DWORD  dwCreationDistribution,                                  // how to create 
		;    DWORD  dwFlagsAndAttributes,                                    // file attributes 
		;    HANDLE  hTemplateFile 	                                           // handle of file with attributes to copy  
		;);
    		invoke CreateFile, addr ARQUIVO, GENERIC_READ OR GENERIC_WRITE, FILE_SHARE_READ OR FILE_SHARE_WRITE,  NULL,CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
 
 		mov hFile,eax
    		cmp hFile, INVALID_HANDLE_VALUE
    		jz erro
    		invoke MessageBox, NULL, addr OK, addr CAPTION , MB_OK
    		
    		;BOOL WriteFile(
		;    HANDLE  hFile,                                          // handle of file to write to 
		;    LPCVOID  lpBuffer,                                    // address of data to write to file 
		;    DWORD  nNumberOfBytesToWrite,       // number of bytes to write 
		;    LPDWORD  lpNumberOfBytesWritten,	 // address of number of bytes written 
		;    LPOVERLAPPED  lpOverlapped            // addr. of structure needed for overlapped I/O  
		;   );
    		invoke WriteFile, hFile, addr TEXTO, SIZEOF TEXTO, addr WRITED, NULL
    		
    		.IF WRITED > 0
    			invoke CloseHandle,hFile
       			invoke MessageBox, NULL, addr SUCESSO, addr CAPTION, MB_OK
    		.ELSE
    			jmp erro
       		.ENDIF
		invoke ExitProcess,NULL
	erro:
   		invoke MessageBox, NULL, addr ERRO,addr CAPTION,MB_OK
   		invoke ExitProcess,NULL 
	end start
