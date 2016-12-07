;SOCKET SERVER EM ASSEMBLY
;===========================
;Exemplo de servidor escrito em Assembly.
;Neste exemplo o server escuta na porta 2016 e replica a mensagem enviada pelo client.
;Seria uma especie de servidor de echo :)
;
;Esta versao se utiliza do pseudo codigo da Microsoft. Para ver como ficaria tudo isso
;o mais proximo possivel do Assembly veja o exemplo Socket2 :)
;
;Atencao: nao conecte-se a essa porta por telnet, ele simula enter a cada tecla digitada.
;O melhor eh utilizar o netcat:
;c:\>nc -vv localhost 2016
;
;Ivan S. Vargas | www.is5.com.br | contato@is5.com.br
;01/2016
.386
.MODEL FLAT,STDCALL

include windows.inc
include kernel32.inc
include user32.inc
include wininet.inc
include wsock32.inc

includelib kernel32.lib
includelib user32.lib
includelib wininet.lib
includelib wsock32.lib

.DATA
Caption db "Atencao!",0
SocketOk db "Socket criado com sucesso!",0
SocketErro db "Erro ao criar socket.",0
BindOk db "Porta aberta com sucesso!",0
BindErro db "Erro ao abrir porta",0
ListenOk db "Escutando na porta",0
ListenErro db "Erro em listen",0
AcceptOk db "Aguardando conexao",0
AcceptErro db "Erro em accept",0
HELO db "Ola mundo!",0
Aguardando db "Aguardando conexao",0
Version dw 2
BUFFER byte 1024 dup(?)

.DATA?
hSocket SOCKET ?
hClient SOCKET ?
wStart dw ?
socketaddr sockaddr_in <>

.CODE
	START:
	 	;carrega WSAStartup
		invoke WSAStartup,	addr Version,addr wStart
		
		;inicializa socket
		invoke socket,AF_INET,SOCK_STREAM,IPPROTO_IP
		mov hSocket, eax
		cmp hSocket, INVALID_SOCKET
		jz @erroSocket
		invoke MessageBox,NULL, addr SocketOk, addr Caption,MB_OK
		
		;preenche estrutura sockaddr
		mov socketaddr.sin_family,AF_INET
		invoke htons,2016
		mov socketaddr.sin_port,ax
		mov socketaddr.sin_addr,INADDR_ANY
	
	@bind:
		;binda a porta
		invoke bind,hSocket,addr socketaddr,SIZE socketaddr
		cmp eax,0
		jz @sucessoBind
		jmp @erroBind		
		
	@listen:
	 	;escuta na porta 
		invoke listen,hSocket,5
		cmp eax,SOCKET_ERROR
		jz @erroListen
		invoke MessageBox,NULL,addr ListenOk,addr Caption,MB_OK
		
	@accept:
		;aguarda conexoes
		;invoke accept,hSocket,addr socketaddr, SIZE socketaddr
		invoke accept,hSocket,0,0
		cmp eax,INVALID_SOCKET   ;verifica se deu erro (nao conectou)
		jz @accept                                  ;se nao conectou,retorna e aguarda novamente
		mov hClient,eax                        ;se conectou,copia o endereco do socket cliente
		invoke send,hClient,addr HELO,10,0   ;envia mensagem de saudacao
		.REPEAT		
		         ;enquanto nao der erro (desconexao) recebe mensagem e a retorno (echo)
			invoke recv,hClient,addr BUFFER,1024,0
			invoke send,hClient,addr BUFFER, SIZE BUFFER,0
		.UNTIL eax == SOCKET_ERROR
		jmp @accept ;se der erro, aguarda nova conexao
		
	@erroSocket:
		invoke MessageBox,NULL,addr SocketErro,addr Caption,MB_OK
		jmp @sair
	 
	@erroBind:
	 	invoke MessageBox,NULL,addr BindErro,addr Caption,MB_OK
	 	jmp @sair
		
	@erroListen:
		invoke MessageBox,NULL,addr ListenErro,addr Caption,MB_OK
		jmp @sair
		
	@erroAccept:
		invoke MessageBox,NULL,addr AcceptErro,addr Caption,MB_OK
		jmp @sair
	
	@sucessoBind:
		invoke MessageBox,NULL,addr BindOk,addr Caption,MB_OK
		jmp @listen
	
	@sair:
		invoke ExitProcess,NULL
		
	@sucessoAccept:
	 	invoke MessageBox,NULL,addr AcceptOk,addr Caption,MB_OK
	
	END START