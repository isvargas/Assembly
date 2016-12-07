;===========================
;SOCKET SERVER EM ASSEMBLY
;===========================
;Exemplo de servidor escrito em Assembly.
;Neste exemplo o server escuta na porta 2016 e replica a mensagem enviada pelo client.
;Seria uma especie de servidor de echo :)
;
;Para fins de comparacao, esta versao utiliza a linguagem basica do Assembly, sem
; valer-se dos pseudo codigos da Microsoft.
;
;Outro recurso aqui utilizado eh a macro, especificada em macros.inc, que chama
;a MessageBox
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

include macros.inc

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
		;invoke WSAStartup,	addr Version,addr wStart
		push offset wStart
		push offset Version
		call WSAStartup
		
		;inicializa socket
		;invoke socket,AF_INET,SOCK_STREAM,IPPROTO_IP
		push 0
		push 1
		push 2
		call socket
		mov hSocket, EAX
		cmp hSocket, -1
		je @erroSocket
		msg offset SocketOk		
		
		;preenche estrutura sockaddr
		;mov socketaddr.sin_family,AF_INET
		;invoke htons,2016
		;mov socketaddr.sin_port,ax
		;mov socketaddr.sin_addr,INADDR_ANY
		mov socketaddr.sin_family,2
		push 7E0h
		call htons
		mov socketaddr.sin_port,ax
		mov socketaddr.sin_addr,0			
		
	@bind:
		;binda a porta
		;invoke bind,hSocket,addr socketaddr,SIZE socketaddr
		push 10h
		push offset socketaddr
		push hSocket
		call bind
		cmp eax,0
		je @sucessoBind
		jmp @erroBind		
		
	@listen:
		;escuta na porta 
		;invoke listen,hSocket,5
		push 5
		push hSocket
		call listen
		cmp eax,-1
		jz @erroListen
		msg offset ListenOk
		
	@accept:
		;aguarda conexoes
		;invoke accept,hSocket,addr socketaddr, SIZE socketaddr
		;invoke accept,hSocket,0,0
		push 0
		push 0
		push hSocket
		call accept
		cmp eax,-1                                 ;verifica se deu erro (nao conectou)
		jz @accept                                  ;se nao conectou,retorna e aguarda novamente
		mov hClient,eax                        ;se conectou,copia o endereco do socket cliente
		;invoke send,hClient,addr HELO,10,0   ;envia mensagem de saudacao
		push 0
		push 0Ah
		push offset HELO
		push hClient
		call send
		@repeat:
		;.REPEAT	
			;enquanto nao der erro (desconexao) recebe mensagem e a retorna (echo)
			;invoke recv,hClient,addr BUFFER,1024,0
			push 0
			push 400
			push offset BUFFER
			push hClient
			call recv
			;invoke send,hClient,addr BUFFER, SIZE BUFFER,0
			push 0
			push 400
			push offset BUFFER
			push hClient
			call send
		;.UNTIL eax == SOCKET_ERROR
		cmp eax,-1
		jnz @repeat
		jmp @accept ;se der erro, aguarda nova conexao
		
	@erroSocket:
		msg offset SocketErro
		jmp @sair
		 
	@erroBind:
		msg offset BindErro
		jmp @sair
		
	@erroListen:
		msg offset ListenErro
		jmp @sair
		
	@erroAccept:
		msg offset AcceptErro
		jmp @sair
		
	@sucessoBind:
		msg offset BindOk
		jmp @listen
		
	@sucessoAccept:
		msg offset AcceptOk
		
	@sair:
		PUSH NULL
		call ExitProcess
		
	END START