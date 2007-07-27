;        ###   ##              ###   ##              ###   ##
;     ## ###   ## #         ## ###   ## #         ## ###   ## #
;     ##############        ##############        ##############    
;     ##############        ##############        ############## 
;     ## ###   ## #         ## ###   ## #         ## ###   ## #
;        ###   ##              ###   ##              ###   ##
; Rafael Delalibera Rodrigues
; Rafael Fae Tavares da Silva


;################################################################################
;######################## RESET : Endere�o de Partida ###########################
;################################################################################


	ORG	0000H
	LJMP	BEGIN		; Direciona o in�cio do programa


;################################################################################
;################ Redirecionamento da Interrup��o do Timer 0 ####################
;################################################################################


	ORG	000Bh		; Endere�o da chamada de interrup��o do Timer 0
	LJMP	INTER		; Direciona a rotina da interrup��o


;################################################################################
;####################### Endere�o de In�cio do Programa #########################
;################################################################################


	ORG	0050H		; Endere�o de in�cio do programa


;################################################################################
;##################### Declara��o de Constantes e Vari�veis #####################
;################################################################################


ALUNO1:	DB "Rafael Delalibera Rodrigues", 0		; String Autor 1
ALUNO2:	DB "Rafael Fae Tavares da Silva", 0		; String Autor 2
UNI1:	DB "UNESP - Universidade Estadual Paulista", 0	; String Universidade
UNI2:	DB "Campus de Rio Claro", 0			; String Campus
TIT:	DB "CRAZY RACERS", 0				; String T�tulo
STIT:	DB "Pressione a Tecla C para Continuar...", 0	; String Auxiliar
PONTOS:	DB "Score:", 0					; String Score
H_PONT:	DB "High Score:",0				; String Pontua��o M�xima
CARRO:	DB "Escolha o Seu Veiculo:", 0			; String Escolha
POS1	EQU 08D	; Posi��o da Pedra 1 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS2	EQU 09D	; Posi��o da Pedra 2 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS3	EQU 10D	; Posi��o da Pedra 3 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS4	EQU 11D	; Posi��o da Pedra 4 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS5	EQU 12D	; Posi��o da Pedra 5 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS6	EQU 13D	; Posi��o da Pedra 6 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS7	EQU 14D	; Posi��o da Pedra 7 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS8	EQU 15D	; Posi��o da Pedra 8 no Display (0-27H ; 40-67H) FF = N�o Exibir
POS9	EQU 16D	; Posi��o da Pedra 9 no Display (0-27H ; 40-67H) FF = N�o Exibir
CAR_T	EQU 17D	; Traseira do Carrinho Escolhido
CAR_F	EQU 18D	; Frente do Carrinho Escolhido
CAR_POS	EQU 19D	; Posi��o do Carrinho no Display
SCORE_0	EQU 20D	; Guarda a Parte Baixa do Score Obtido
SCORE_1	EQU 21D	; Guarda a Parte Alta do Score Obtido
H_SCR0	EQU 22D	; Guarda Maior Pontua��o Obtida (Parte Baixa)
H_SCR1	EQU 23D	; Guarda Maior Pontua��o Obtida (Parte Alta)
NIVEL	EQU 24D	; Usadada Para Mudar de N�vel
AUX_R0	EQU 25D	; Auxiliar do Registrador 0

CONTROLE	EQU 0FF01H	; Endere�o para Controle do Display
DISPLAY		EQU 0FF11H	; Endere�o para Transmiss�o de Dados ao Display
STATUS		EQU 0FF09H	; Endere�o para Verifica��o do Status do Display


;################################################################################
;############################## In�cio do Programa ##############################
;################################################################################


BEGIN:

	MOV	IE, #00000000B	; Zera o Vetor de Interrup��es
	MOV	SP, #2FH	; Endere�o da Pilha em Rela��o � Mem�ria Interna
	CLR	RS0		; Seleciona o Banco de Registradores 0
	CLR	RS1		; Outros Bancos S�o Endere�ados como Vari�veis
	MOV	H_SCR0, #00H
	MOV	H_SCR1, #00H


;################################################################################
;########################### Inicializa��o do Display ###########################
;################################################################################


	MOV	A, #38H		; Comunica��o com Display: 2 Linhas (5x8)/8 Bits 
	LCALL	LCD_CMD
	MOV	A, #00000110B	; Modo de Deslocamento do Cursor (Esq->Dir)
	LCALL	LCD_CMD
	MOV	A, #00001100B	; Liga Display com Cursor Desligado
	LCALL	LCD_CMD
	MOV	A, #00000001B	; Limpa Display (Cursor para Posi��o Inicial)
	LCALL	LCD_CMD
	MOV	A, #01000000B	; Ativa o Endere�amento da CGRAM
	LCALL	LCD_CMD		; Para Possibilitar o Envio dos Caracteres

; In�cio do Envio dos Caract�res Especiais

; ###########
; ## Pedra ##
; ###########
; Endere�o = 00H

	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #01110B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #01110B
	LCALL	LCD_CHAR
	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #00000B
	LCALL	LCD_CHAR

; ###########################
; ### Carrinho 1 Traseira ###
; ###########################
; Endere�o = 01H

	MOV	A, #00001B
	LCALL	LCD_CHAR
	MOV	A, #10001B
	LCALL	LCD_CHAR
	MOV	A, #11001B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11001B
	LCALL	LCD_CHAR
	MOV	A, #10001B
	LCALL	LCD_CHAR
	MOV	A, #00001B
	LCALL	LCD_CHAR

; ###########################
; #### Carrinho 1 Frente ####
; ###########################
; Endere�o = 02H

	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #10000B
	LCALL	LCD_CHAR
	MOV	A, #11000B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11000B
	LCALL	LCD_CHAR
	MOV	A, #10000B
	LCALL	LCD_CHAR
	MOV	A, #00000B
	LCALL	LCD_CHAR

; ###########################
; ### Carrinho 2 Traseira ###
; ###########################
; Endere�o = 03H

	MOV	A, #00001B
	LCALL	LCD_CHAR
	MOV	A, #00001B
	LCALL	LCD_CHAR
	MOV	A, #00001B
	LCALL	LCD_CHAR
	MOV	A, #00001B
	LCALL	LCD_CHAR
	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #01111B
	LCALL	LCD_CHAR
	MOV	A, #00111B
	LCALL	LCD_CHAR
	MOV	A, #00011B
	LCALL	LCD_CHAR

; ###########################
; #### Carrinho 2 Frente ####
; ###########################
; Endere�o = 04H

	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #10000B
	LCALL	LCD_CHAR
	MOV	A, #11000B
	LCALL	LCD_CHAR
	MOV	A, #11100B
	LCALL	LCD_CHAR
	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #11110B
	LCALL	LCD_CHAR
	MOV	A, #11100B
	LCALL	LCD_CHAR
	MOV	A, #11000B
	LCALL	LCD_CHAR

; ###########################
; ### Carrinho 3 Traseira ###
; ###########################
; Endere�o = 05H

	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #10001B
	LCALL	LCD_CHAR
	MOV	A, #10001B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #01100B
	LCALL	LCD_CHAR
	MOV	A, #01100B
	LCALL	LCD_CHAR

; ###########################
; #### Carrinho 3 Frente ####
; ###########################
; Endere�o = 06H

	MOV	A, #11100B
	LCALL	LCD_CHAR
	MOV	A, #10100B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #11111B
	LCALL	LCD_CHAR
	MOV	A, #01111B
	LCALL	LCD_CHAR
	MOV	A, #01100B
	LCALL	LCD_CHAR
	MOV	A, #01100B
	LCALL	LCD_CHAR

; ###########################
; ########## Corpo ##########
; ###########################
; Endere�o = 07H

	MOV	A, #00000B
	LCALL	LCD_CHAR
	MOV	A, #10001B
	LCALL	LCD_CHAR
	MOV	A, #01001B
	LCALL	LCD_CHAR
	MOV	A, #00111B
	LCALL	LCD_CHAR
	MOV	A, #00111B
	LCALL	LCD_CHAR
	MOV	A, #01001B
	LCALL	LCD_CHAR
	MOV	A, #10001B
	LCALL	LCD_CHAR
	MOV	A, #00000B
	LCALL	LCD_CHAR

; T�rmino do Envio dos Caracteres Especiais

	MOV	A, #00000001B	; Limpa o Display / Cursor para Posi��o Inicial
	LCALL	LCD_CMD		; Motivo: Cursor Desloca-se com o Envio de
				; Caracteres para CGRAM
	MOV	A, #10000000B	; Ativa o Endere�amento da DDRAM
	LCALL	LCD_CMD


;################################################################################
;#################################### MENUS #####################################
;################################################################################


; Apresenta��o: Universidade e Campus
	MOV	A, #0H			; Posi��o no Display = 00H (Linha 1)
	MOV	DPTR, #UNI1		; String a Ser Enviada
	LCALL	LCD_POS_STRING		; Escreve String Universidade
	MOV	A, #40H			; Posi��o no Display = 40H (Linha 2)
	MOV	DPTR, #UNI2		; String a Ser Enviada
	LCALL	LCD_POS_STRING		; Escreve String Campus
	MOV	A, #20D
	LCALL	ESPERA			; Espera 1 Segundo para Continuar
	MOV	A, #00000001B		; Limpa a Tela
	LCALL	LCD_CMD

; Apresenta��o: Autores
	MOV	A, #00H			; Posi��o no Display = 00H (Linha 1)
	MOV	DPTR, #ALUNO1		; String a Ser Enviada
	LCALL	LCD_POS_STRING		; Escreve String Autor 1
	MOV	A, #40H			; Posi��o no Display = 40H (Linha 2)
	MOV	DPTR, #ALUNO2		; String a Ser Enviada
	LCALL	LCD_POS_STRING		; Escreve String Autor 2
	MOV	A, #20D
	LCALL	ESPERA			; Espera 1 Segundo para Continuar
	MOV	A, #00000001B		; Limpa a Tela
	LCALL	LCD_CMD

; Apresenta��o: T�tulo
	MOV	A, #15D			; Posi��o no Display = 15D (Linha 1)
	MOV	DPTR, #TIT		; String a Ser Enviada
	LCALL	LCD_POS_STRING		; Escreve String T�tulo
	MOV	A, #40H			; Posi��o no Display = 40H (Linha 2)
	MOV	DPTR, #STIT		; String a Ser Enviada
	LCALL	LCD_POS_STRING		; Escreve String Auxiliar

TECLA_INIT1:				; Espera Tecla C Ser Pressionada para
					; Dar Continuidade ao Programa
	MOV	P1, #11111111B		; Prepara o Porto 1
	CLR	P1.7			; Ativa a Linha 4
	MOV	A, P1			; Verifica o Porto 1
	XRL	A, #01110111B		; Verifica Se a Tecla C foi Pressionada
	JNZ	TECLA_INIT1		; Continua Se a Tecla foi Pressionada

MENU_CARRINHOS:				; Menu de Escolha dos Carrinhos
					; Este Label Ser� Chamado Quando 
					; Houver Colis�o
	MOV	SP, #2FH		; A Pilha � Redefinida Para o Caso
					; de Colis�o
	MOV	A, #00000001B		; Limpa a Tela
	LCALL	LCD_CMD

	MOV	A, #0D			; Posi��o no Display = 00H (Linha 1)
	MOV	DPTR, #CARRO		; String a Ser Enviada
	LCALL	LCD_POS_STRING		; Escreve String Escolha

	MOV	A, #64D			; Posi��o no Display = 64D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #31H			; Escreve Caractere '1'
	LCALL	LCD_CHAR
	MOV	A, #66D			; Posi��o no Display = 66D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #01H			; Escreve Caractere Traseira Carrinho 1
	LCALL	LCD_CHAR
	MOV	A, #02H			; Escreve Caractere Frente Carrinho 1
	LCALL	LCD_CHAR

	MOV	A, #74D			; Posi��o no Display = 74D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #32H			; Escreve Caractere '2'
	LCALL	LCD_CHAR
	MOV	A, #76D			; Posi��o no Display = 76D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #03H			; Escreve Caractere Traseira Carrinho 2
	LCALL	LCD_CHAR
	MOV	A, #04H			; Escreve Caractere Frente Carrinho 2
	LCALL	LCD_CHAR


	MOV	A, #84D			; Posi��o no Display = 84D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #33H			; Escreve Caractere '3'
	LCALL	LCD_CHAR
	MOV	A, #86D			; Posi��o no Display = 86D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #05H			; Escreve Caractere Traseira Carrinho 3
	LCALL	LCD_CHAR
	MOV	A, #06H			; Escreve Caractere Frente Carrinho 3
	LCALL	LCD_CHAR


	MOV	A, #94D			; Posi��o no Display = 94D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #46H			; Escreve Caractere 'F'
	LCALL	LCD_CHAR
	MOV	A, #96D			; Posi��o no Display = 96D (Linha 2)
	ORL	A, #10000000B		; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #07H			; Escreve Caractere Corpo
	LCALL	LCD_CHAR
	MOV	A, #00H			; Escreve Caractere Pedra (Cabe�a)
	LCALL	LCD_CHAR

; Recebe do Teclado o Valor Correspondente ao Carrinho Escolhido
CARRINHO1:
	MOV	P1, #11111111B		; Prepara o Porto 1
	CLR	P1.4			; Ativa a Linha 1
	MOV	A, P1			; Verifica o Porto 1
	XRL	A, #11101110B		; Verifica Se a Tecla 1 foi Pressionada
	JNZ	CARRINHO2		; Caso N�o: Verifica a Pr�xima Tecla
	MOV	CAR_T, #01H		; Caso Sim: Seta a Traseira do Carrinho
	MOV	CAR_F, #02H		;           Seta a Frente do Carrinho
	LJMP	OK_CARRINHO		;           Sai
CARRINHO2:
	MOV	P1, #11111111B		; Prepara o Porto 1
	CLR	P1.4			; Ativa a Linha 1
	MOV	A, P1			; Verifica o Porto 1
	XRL	A, #11101101B		; Verifica Se a Tecla 2 foi Pressionada
	JNZ	CARRINHO3		; Caso N�o: Verifica a Pr�xima Tecla
	MOV	CAR_T, #03H		; Caso Sim: Seta a Traseira do Carrinho
	MOV	CAR_F, #04H		;           Seta a Frente do Carrinho
	LJMP	OK_CARRINHO		;           Sai
CARRINHO3:
	MOV	P1, #11111111B		; Prepara Porto 1
	CLR	P1.4			; Ativa a Linha 1
	MOV	A, P1			; Verifica o Porto 1
	XRL	A, #11101011B		; Verifica Se a Tecla 3 foi Pressionada
	JNZ	CARRINHO4		; Caso N�o: Verifica a Pr�xima Tecla
	MOV	CAR_T, #05H		; Caso Sim: Seta a Traseira do Carrinho
	MOV	CAR_F, #06H		;           Seta a Frente do Carrinho
	LJMP	OK_CARRINHO		;           Sai
CARRINHO4:
	MOV	P1, #11111111B		; Prepara Porto 1
	CLR	P1.4			; Ativa a Linha 1
	MOV	A, P1			; Verifica o Porto 1
	XRL	A, #11100111B		; Verifica Se a Tecla F foi Pressionada
	JNZ	CARRINHO1		; Caso N�o: Reinicia Verifica��o
	MOV	CAR_T, #07H		; Caso Sim: Seta a Traseira do Carrinho
	MOV	CAR_F, #00H		;           Seta a Frente do Carrinho
	LJMP	OK_CARRINHO		;           Sai
OK_CARRINHO:				; O Carrinho J� Foi Escolhido


;################################################################################
;######################### Inicializa��o das Vari�veis ##########################
;################################################################################


	MOV	POS1, #FFH		; Pedra 1 N�o Inicializada (Em Espera)
	MOV	POS2, #FFH		; Pedra 2 N�o Inicializada (Em Espera)
	MOV	POS3, #FFH		; Pedra 3 N�o Inicializada (Em Espera)
	MOV	POS4, #FFH		; Pedra 4 N�o Inicializada (Em Espera)
	MOV	POS5, #FFH		; Pedra 5 N�o Inicializada (Em Espera)
	MOV	POS6, #FFH		; Pedra 6 N�o Inicializada (Em Espera)
	MOV	POS7, #FFH		; Pedra 7 N�o Inicializada (Em Espera)
	MOV	POS8, #FFH		; Pedra 8 N�o Inicializada (Em Espera)
	MOV	POS9, #FFH		; Pedra 9 N�o Inicializada (Em Espera)
	MOV	CAR_POS, #01H		; Posi��o Inicial do Carrinho = Linha 1
	MOV	SCORE_0, #00H		; Score Inicialmente em 0
	MOV	SCORE_1, #00H		; Score Inicialmente em 0
	MOV	NIVEL, #00H		; Contador: Deve Iniciar Zerado
	MOV	AUX_R0, #7D		; Deve Conter o Mesmo Valor de R0


;################################################################################
;####################### Inicializa��o dos Timers / INT #########################
;################################################################################


; Timer 0 � Respons�vel Pelo Tempo de Atualiza��o da Tela
; R0 � Respons�vel pelo Tempo de Mudan�a da Posi��o das Pedras
	MOV	TMOD, #01H	; 0000 : Timer 1 : 0001 Timer 0
				; GATE0 = 0 => Interrup��o por Software
				;  C/T0 = 0 => Temporizador
				;  M1.0 = 0 M0.0 = 1 => Modo 1 (16 bits)
				;  Sem Auto-Recarga
				;  Timer 0 Configurado
	MOV	R0, #7D
	MOV	R5, #0D		; Indicador Iniciado em 00000000 (POS1)
				; R5 Indica a Pedra que Deve Ser Inicializada
				; POS1 = 00000000B  POS2 = 00000001B
				; POS3 = 00000010B  POS4 = 00000011B
				; POS5 = 00000100B  POS6 = 00000101B
				; POS7 = 00000110B  POS8 = 00000111B
				; POS9 = 00001000B
	MOV	R6, #FFH	; Espa�o Ainda N�o Obtido
				; R6 Representa o Espa�o Entre Uma Pedra e Outra


; Timer 1 � Respons�vel por Gerar a Aleatoriedade para Alguns Eventos do Jogo
; Como: A Linha em que a Pr�xima Pedra Aparecer�
;	E a Dist�ncia entre uma Pedra e Outra
	MOV	A, TMOD
	ANL	A, #00001111B	; Mantem Valores do Timer 0 Inalterados
	ORL	A, #00100000B	; GATE1 = 0 => Interrup��o por Software
				;   C/T = 0 => Temporizador
				;  M1.1 = 1 M0.1 = 0 => Modo 2 (8 bits)
				;  Com Auto-Recarga
	MOV	TMOD, A		; Timer 1 Configurado

; Carregando e Inicializando os Timers
	CLR	TR0		; Desativa Timer 0
	CLR	TF0		; Reseta Flag de Overflow
	MOV	TL0, #00H	; Carrega Parte Baixa do Timer 0 
	MOV	TH0, #80H	; Carrega Parte Alta do Timer 0
	SETB	TR0		; Habilita a Contagem
	CLR	TR1		; Desativa Timer 1
	CLR	TF1		; Reseta Flag de Overflow
	MOV	TH1, 0H		; Carrega Timer 1
	SETB	TR1		; Habilita a Contagem


;################################################################################
;######################## In�cio do Programa Principal ##########################
;################################################################################


	MOV	IE, #10000010B	; Habilita a Interrup��o do Timer0

MAIN:				; Este � o N�cleo do Jogo
				; Nesta Se��o de C�digo que Ser�o Chamadas
				; a Interrup��o e Fun��es Referentes ao Jogo 

TECLA9:
	MOV	P1, #11111111B	; Prepara o Porto 1
	CLR	P1.6		; Ativa a Linha 3
	MOV	A, P1		; Verifica o Porto 1
	MOV	B, A		; Salva o Valor Obtido em B
	XRL	A, #10111011B	; Verifica Se a Tecla 9 foi Pressionada
	JNZ	TECLA9_8	; Caso N�o: Verifica Pr�xima Tecla
	MOV	R0, #01D	; Caso Sim: Acelera o Carrinho
				;           Diminuindo o Tempo Entre as Pedras
  TECLA9_8:
	MOV	A, B		; Resgata o Valor Guardado
	XRL	A, #10111001B	; Verifica Se as Teclas 9 e 8 est�o Pressionadas
	JNZ	TECLA8		; Caso N�o: Verifica Pr�xima Tecla
	MOV	R0, #01D	; Caso Sim: Acelera o Carrinho
	MOV	CAR_POS, #01H	;           E Sobe o Carrinho (Linha 1)
TECLA8:
	MOV	P1, #11111111B	; Prepara o Porto 1
	CLR	P1.6		; Ativa a Linha 3
	MOV	A, P1		; Verifica o Porto 1
	XRL	A, #10111101B	; Verifica Se a Tecla 8 foi Pressionada
	JNZ	TECLA0		; Caso N�o: Verifica Pr�xima Tecla
	MOV	CAR_POS, #01H	; Caso Sim: Sobe o Carrinho (Linha 1)
TECLA0:
	MOV	P1, #11111111B	; Prepara o Porto 1
	CLR	P1.7		; Ativa a Linha 4
	MOV	A, P1		; Verifica o Porto 1
	XRL	A, #01111101B	; Verifica Se a Tecla 0 foi Pressionada
	JNZ	TECLAX		; Caso N�o: N�o Altera Posi��o do Carrinho
	MOV	CAR_POS, #41H	; Caso Sim: Desce o Carrinho (Linha 2)
  TECLAX:

	LCALL	COLISAO		; Verifica Se Houve Colis�o

	LJMP	MAIN		; Mantem o Jogo em Funcionamento


;################################################################################
;########################### ROTINAS E SUBROTINAS ###############################
;################################################################################


; $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
; $$$$$$$$$$$$ DISPLAY $$$$$$$$$$$
; $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


; Envia Comando de Controle para o Display
; O Comando de Controle Fica em 'A' 
LCD_CMD:                 
	PUSH	DPL
	PUSH	DPH
	MOV	DPTR, #CONTROLE		; Endere�a Posi��o de Controle
	MOVX	@DPTR, A		; Envia Dado de Controle
	MOV	DPTR, #STATUS		; Endere�a Posi��o de Status
  _LCD_CMD_WAIT:			; Inicia Ciclo de Verifica��o
	MOVX	A, @DPTR		; Envia Flags do Display p/ Acumulador
	JB	ACC.7, _LCD_CMD_WAIT	; Verifica Flag Busy : Segue = 0 Not Busy
	POP	DPH			
	POP	DPL
	RET

; Envia um Caractere para o Display
; O Valor do Caractere Fica em 'A' (ASCII)
LCD_CHAR:
	PUSH	DPL
	PUSH	DPH
	MOV	DPTR, #DISPLAY		; Endere�a Posi��o de Dados
	MOVX	@DPTR, A		; Envia Dado (Char em ASCII)
	MOV	DPTR, #STATUS
  _LCD_CHAR_WAIT:			; Verifica Status do Display
	MOVX	A, @DPTR
	JB	ACC.7, _LCD_CHAR_WAIT
	POP	DPH
	POP	DPL
	RET

; Envia String ao Display
; Em "A" Deve Estar a Posi��o de In�cio
; Em DPTR Deve Estar Endere�ado Vetor da String
LCD_POS_STRING:
	SETB	ACC.7			; Seta o Bit 7 / Para Endere�ar a DDRAM
	LCALL	LCD_CMD
LCD_STRING:
	CLR	A			; Limpa 'A'
	MOVC	A, @A+DPTR		; Endere�a a String / 'A' � o Ponteiro
	JZ	_LCD_STRING_1
	LCALL	LCD_CHAR
	INC	DPTR
	SJMP	LCD_STRING
  _LCD_STRING_1:
	RET


; $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
; $$$$$$$ ENGINE DO JOGO $$$$$$$$$
; $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


; Rotina Chamada Pela Interrup��o do Timer 0
INTER:  
	PUSH	A		; Devido ao Telado / Colis�o
	PUSH	PSW		; Devido ao Teclado / Colis�o
	PUSH	B		; Devido ao Teclado / Colis�o
	CLR	TR0		; Desliga o Timer 0
	CLR	TF0		; Zera Flag de Overflow
	MOV	TL0, #00H	; Carrega Parte Baixa do Timer 
	MOV	TH0, #80H	; Carrega Parte Alta do Timer
	MOV	A, #00000001B	; Limpa Tela
	LCALL	LCD_CMD

	LCALL	CAR_PLOT	; Desenha o Carrinho

	DJNZ	R0, PART1	; Decrementa e Sai da Interrup��o se R0<>0
	SJMP	PART2		; PART 1 e PART 2 Necess�rios Devido
  PART1:			; Ao Estouro do La�o de DJNZ para PLOT
	LJMP	PLOT
  PART2:
	MOV	R0, AUX_R0	; Restabelece o Valor de R0

	LCALL	INI_POS		; Rotina de Inicializa��o das Pedras
	LCALL	DEC_POS		; Rotina de C�lculo de Posi��o das Pedras

  PLOT:
  ; Este trecho de c�digo � respons�vel por
  ; desenhar as pedras j� inicializadas na tela
	MOV	A, POS1		; Obt�m Posi��o da Pedra 1
	XRL	A, #FFH		; Verifica Se a Pedra 1 J� Foi Inicializada
	JZ	PLOTP2		; Se N�o: Pula Para Pedra 2
	MOV	A, POS1		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP2:
	MOV	A, POS2		; Obt�m Posi��o da Pedra 2
	XRL	A, #FFH		; Verifica Se a Pedra 2 J� Foi Inicializada
	JZ	PLOTP3		; Se N�o: Pula Para Pedra 3
	MOV	A, POS2		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP3:
	MOV	A, POS3		; Obt�m Posi��o da Pedra 3
	XRL	A, #FFH		; Verifica Se a Pedra 3 J� Foi Inicializada
	JZ	PLOTP4		; Se N�o: Pula Para Pedra 4
	MOV	A, POS3		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP4:
	MOV	A, POS4		; Obt�m Posi��o da Pedra 4
	XRL	A, #FFH		; Verifica Se a Pedra 4 J� Foi Inicializada
	JZ	PLOTP5		; Se N�o: Pula Para Pedra 5
	MOV	A, POS4		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP5:
	MOV	A, POS5		; Obt�m Posi��o da Pedra 5
	XRL	A, #FFH		; Verifica Se a Pedra 5 J� Foi Inicializada
	JZ	PLOTP6		; Se N�o: Pula Para Pedra 6
	MOV	A, POS5		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP6:
	MOV	A, POS6		; Obt�m Posi��o da Pedra 6
	XRL	A, #FFH		; Verifica Se a Pedra 6 J� Foi Inicializada
	JZ	PLOTP7		; Se N�o: Pula Para Pedra 7
	MOV	A, POS6		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP7:
	MOV	A, POS7		; Obt�m Posi��o da Pedra 7
	XRL	A, #FFH		; Verifica Se a Pedra 7 J� Foi Inicializada
	JZ	PLOTP8		; Se N�o: Pula Para Pedra 8
	MOV	A, POS7		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP8:
	MOV	A, POS8		; Obt�m Posi��o da Pedra 8
	XRL	A, #FFH		; Verifica Se a Pedra 8 J� Foi Inicializada
	JZ	PLOTP9		; Se N�o: Pula Para Pedra 9
	MOV	A, POS8		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTP9:
	MOV	A, POS9		; Obt�m Posi��o da Pedra 9
	XRL	A, #FFH		; Verifica Se a Pedra 9 J� Foi Inicializada
	JZ	PLOTX		; Se N�o: Pula Para Fora da Interrup��o
	MOV	A, POS9		; Se Sim: Desenha
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, #00H		; Escreve Caractere Pedra
	LCALL	LCD_CHAR
    PLOTX:

	MOV	A, NIVEL
	XRL	A, #10D		; Verifica Se Deve Mudar de N�vel
	JNZ	OUT_NIVEL	; Se N�o: Sai da Interrup��o
	MOV	NIVEL, #0H	; Se Sim: Zera o Contador
	MOV	A, R0
	XRL	A, #1D		;         Verifica Se R0 Atingiu o M�nimo
	JZ	OUT_NIVEL	;         Caso Sim: Sai da Interrup��o
	DEC	R0		;         Caso N�o: Decrementa R0
	MOV	A, #5D
	LCALL	ESPERA		;                   Atraso
	MOV	AUX_R0, R0	;                   Guarda R0 em AUX_R0
  OUT_NIVEL:
	POP	B
	POP	PSW
	POP	A
	SETB	TR0		; Reinicia a Contagem
	RETI
; T�rmino da Rotina de Tratamento da Interrup��o do Timer 0


; Plota o Carrinho Escolhido na Tela
CAR_PLOT:
	MOV	A, CAR_POS	; Posi��o do Carrinho no Display
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, CAR_F	; Escreve Caractere Frente do Carrinho
	LCALL	LCD_CHAR
	MOV	A, CAR_POS	; Recupera Posi��o do Carrinho
	DEC	A		; Decrementa em 1 Unidade
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, CAR_T	; Escreve Caractere Traseira do Carrinho
	LCALL	LCD_CHAR
	RET


; Fun��o Que Obt�m Aleat�riamente a Linha da Nova Pedra
; EM R1 Deve Estar Qual A Pedra (POS1, ... , POS9)
GET_POS:
	CLR	TR1		; Pausa o Timer 1
	MOV	A, TL1		; Obt�m o Valor da Contagem
	ANL	A, #00000001B	; Despreza os Bits 7 ao 1
	JNZ	SET_POS1	; Se o Bit0 = 0
	MOV	A, #28H		; 'A' Recebe o Valor 28H (Linha 1)
	SJMP	OUT_POS		; E Sai da Fun��o
  SET_POS1:
	MOV	A, #68H		; Se Bit0 = 1 
				; 'A' Recebe o Valor 68H (Linha 2)
  OUT_POS:
	MOV	@R1, A		; Passa o Valor de 'A' para POSX
	SETB	TR1		; Reabilita a Contagem
	RET

; Fun��o Que Obt�m Aleat�riamente o Tamanho do Espa�o Entre Uma Pedra e Outra
; O Resultado � Passado em R6
GET_ESP:
	CLR	TR1		; Pausa o Timer 1
	MOV	A, TL1		; Obt�m o Valor da Contagem
	ANL	A, #00000011B	; Despreza os Bits 7 ao 2
	JZ	CASE0		; Se 'A' = 00 Pula Para Case0
	MOV	B, A		; Salva o Valor Obtido em B
	XRL	A, #00000001B
	JZ	CASE1		; Se 'A' = 01 Pula Para Case1
	MOV	A, B		; Recupera Valor
	XRL	A, #00000010B
	JZ	CASE2		; Se 'A' = 10 Pula Para Case3
  CASE3:			; Caso Contr�rio: 'A' = 11
	MOV	R6, #8D	;8	; Ent�o R6 Recebe 8
	LJMP	OUT_ESP		; E Sai da Fun��o
  CASE0:
	MOV	R6, #5D	;5	; R6 Recebe 5
	LJMP	OUT_ESP		; Sai da Fun��o
  CASE1:
	MOV	R6, #6D	;6	; R6 Recebe 6
	LJMP	OUT_ESP		; Sai da Fun��o
  CASE2:
	MOV	R6, #7D	;7	; R6 Recebe 7
  OUT_ESP:
	SETB	TR1		; Reabilita a Contagem
	RET

; Rotina Que Calcula Se Houve Colis�o Entre o Carrinho e Alguma das Pedra
; Que J� Foram Inicializadas; Em Caso Positivo o Jogo � Interrompido
COLISAO:
	MOV	B, CAR_POS	; B Armazena a Posi��o do Carrinho

	MOV	A, B		; Verifica Se A Frente do Carrinho
	XRL	A, POS1		; Colidiu Com a Pedra 1
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS1		; Colidiu Com a Pedra 1
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS2		; Colidiu Com a Pedra 2
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se a Traseira do Carrinho
	XRL	A, POS2		; Colidiu Com a Pedra 2
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS3		; Colidiu Com a Pedra 3
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS3		; Colidiu Com a Pedra 3
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS4		; Colidiu Com a Pedra 4
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS4		; Colidiu Com a Pedra 4
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS5		; Colidiu Com a Pedra 5
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS5		; Colidiu Com a Pedra 5
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS6		; Colidiu Com a Pedra 6
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS6		; Colidiu Com a Pedra 6
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS7		; Colidiu Com a Pedra 7
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS7		; Colidiu Com a Pedra 7
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS8		; Colidiu Com a Pedra 8
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS8		; Colidiu Com a Pedra 8
	JZ	IGUAL		; Se Sim: Pula Para Igual

	MOV	A, B		; Verifica Se a Frente do Carrinho
	XRL	A, POS9		; Colidiu Com a Pedra 9
	JZ	IGUAL		; Se Sim: Pula Para Igual
	MOV	A, B
	DEC	A		; Verifica Se A Traseira do Carrinho
	XRL	A, POS9		; Colidiu Com a Pedra 9
	JZ	IGUAL		; Se Sim: Pula Para Igual

	SJMP	OUT_COL		; N�o Colidiu => Retorna ao Programa

  IGUAL:
	LJMP	CRASH		; Chama Rotina Que Desenha a Colis�o

  OUT_COL:			; Retorna ao Programa
	RET


; Fun��o Que Calcula as Posi��es das Pedras Que J� Foram Inicializadas
; Decrementando Suas Posi��es
DEC_POS:
	MOV	B, POS1		; B Armazena a Pedra 1
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 1 Foi Inicializada
	JZ	PEDRA2		; Se N�o: Pula Para Pedra 2
	MOV	A, B
				; Verifica Se Pedra 1 Chegou Ao Fim do Display
	JZ	RELOAD_P1	; Se POS1 = 00H => Reinicializa Pedra 1
	XRL	A, #40H		; Se POS1 = 40H => Reinicializa Pedra 1
	JNZ	DEC_P1		; Se N�o: Decrementa Posi��o
  RELOAD_P1:
	MOV	POS1, #FFH	; POS1 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_1		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA2		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA2
  SC_1:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA2		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA2		; Pula Para Pedra 2
  DEC_P1:
	DEC	POS1		; Decrementa POS1

  PEDRA2:
	MOV	B, POS2		; B Armazena a Pedra 2
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 2 Foi Inicializada
	JZ	PEDRA3		; Se N�o: Pula Para Pedra 3
	MOV	A, B
				; Verifica Se Pedra 2 Chegou Ao Fim do Display
	JZ	RELOAD_P2	; Se POS2 = 00H => Reinicializa Pedra 2
	XRL	A, #40H		; Se POS2 = 40H => Reinicializa Pedra 2
	JNZ	DEC_P2		; Se N�o: Decrementa Posi��o
  RELOAD_P2:
	MOV	POS2, #FFH	; POS2 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_2		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA3		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA3
  SC_2:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA3		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA3		; Pula Para Pedra 3
  DEC_P2:
	DEC	POS2		; Decrementa POS2

  PEDRA3:
	MOV	B, POS3		; B Armazena a Pedra 3
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 3 Foi Inicializada
	JZ	PEDRA4		; Se N�o: Pula Para Pedra 4
	MOV	A, B
				; Verifica Se Pedra 3 Chegou Ao Fim do Display
	JZ	RELOAD_P3	; POS3 = 00H => Reinicializa Pedra 3
	XRL	A, #40H		; POS3 = 40H => Reinicializa Pedra 3
	JNZ	DEC_P3		; Se N�o: Decrementa Posi��o
  RELOAD_P3:
	MOV	POS3, #FFH	; POS3 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_3		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA4		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA4
  SC_3:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA4		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA4		; Pula Para Pedra 4
  DEC_P3:
	DEC	POS3		; Decrementa POS3

  PEDRA4:
	MOV	B, POS4		; B Armazena a Pedra 4
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 4 Foi Inicializada
	JZ	PEDRA5		; Se N�o: Pula Para Pedra 5
	MOV	A, B
				; Verifica Se Pedra 4 Chegou Ao Fim do Display
	JZ	RELOAD_P4	; POS4 = 00H => Reinicializa Pedra 4
	XRL	A, #40H		; POS4 = 40H => Reinicializa Pedra 4
	JNZ	DEC_P4		; Se N�o: Decrementa Posi��o
  RELOAD_P4:
	MOV	POS4, #FFH	; POS4 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_4		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA5		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA5
  SC_4:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA5		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA5		; Pula Para Pedra 5
  DEC_P4:
	DEC	POS4		; Decrementa POS4

  PEDRA5:
	MOV	B, POS5		; B Armazena a Pedra 5
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 5 Foi Inicializada
	JZ	PEDRA6		; Se N�o: Pula Para Pedra 6
	MOV	A, B
				; Verifica Se Pedra 5 Chegou Ao Fim do Display
	JZ	RELOAD_P5	; POS5 = 00H => Reinicializa Pedra 5
	XRL	A, #40H		; POS5 = 40H => Reinicializa Pedra 5
	JNZ	DEC_P5		; Se N�o: Decrementa Posi��o
  RELOAD_P5:
	MOV	POS5, #FFH	; POS5 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_5		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA6		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA6
  SC_5:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA6		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA6		; Pula Para Pedra 6
  DEC_P5:
	DEC	POS5		; Decrementa POS5

  PEDRA6:
	MOV	B, POS6		; B Armazena a Pedra 6
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 6 Foi Inicializada
	JZ	PEDRA7		; Se N�o: Pula Para Pedra 7
	MOV	A, B
				; Verifica Se Pedra 6 Chegou Ao Fim do Display
	JZ	RELOAD_P6	; POS6 = 00H => Reinicializa Pedra 6
	XRL	A, #40H		; POS6 = 40H => Reinicializa Pedra 6
	JNZ	DEC_P6		; Se N�o: Decrementa Posi��o
  RELOAD_P6:
	MOV	POS6, #FFH	; POS6 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_6		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA7		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA7
  SC_6:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA7		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA7		; Pula Para Pedra 7
  DEC_P6:
	DEC	POS6		; Decrementa POS6

  PEDRA7:
	MOV	B, POS7		; B Armazena a Pedra 7
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 7 Foi Inicializada
	JZ	PEDRA8		; Se N�o: Pula Para Pedra 8
	MOV	A, B
				; Verifica Se Pedra 7 Chegou Ao Fim do Display
	JZ	RELOAD_P7	; POS7 = 00H => Reinicializa Pedra 7
	XRL	A, #40H		; POS7 = 40H => Reinicializa Pedra 7
	JNZ	DEC_P7		; Se N�o: Decrementa Posi��o
  RELOAD_P7:
	MOV	POS7, #FFH	; POS7 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_7		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA8		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA8
  SC_7:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA8		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA8		; Pula Para Pedra 8
  DEC_P7:
	DEC	POS7		; Decrementa POS7

  PEDRA8:
	MOV	B, POS8		; B Armazena a Pedra 8
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 8 Foi Inicializada
	JZ	PEDRA9		; Se N�o: Pula Para Pedra 9
	MOV	A, B
				; Verifica Se Pedra 8 Chegou Ao Fim do Display
	JZ	RELOAD_P8	; POS8 = 00H => Reinicializa Pedra 8
	XRL	A, #40H		; POS8 = 40H => Reinicializa Pedra 8
	JNZ	DEC_P8		; Se N�o: Decrementa Posi��o
  RELOAD_P8:
	MOV	POS8, #FFH	; POS8 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_8		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA9		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	PEDRA9
  SC_8:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	PEDRA9		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	PEDRA9		; Pula Para Pedra 9
  DEC_P8:
	DEC	POS8		; Decrementa POS8

  PEDRA9:
	MOV	B, POS9		; B Armazena a Pedra 9
	MOV	A, B
	XRL	A, #FFH		; Verifica Se a Pedra 9 Foi Inicializada
	JZ	OUT_DEC		; Se N�o: Sai da Rotina
	MOV	A, B
				; Verifica Se Pedra 9 Chegou Ao Fim do Display
	JZ	RELOAD_P9	; POS9 = 00H => Reinicializa Pedra 9
	XRL	A, #40H		; POS9 = 40H => Reinicializa Pedra 9
	JNZ	DEC_P9
  RELOAD_P9:
	MOV	POS9, #FFH	; POS9 Recebe Valor de Espera
	INC	NIVEL		; Incrementa Contador Para Mudan�a de N�vel
	INC	SCORE_0		; Incrementa o Score Usando BCD 4bits
	MOV	A, SCORE_0
	XRL	A, #10101010B	; Verifica Estouro de Ambas Partes
	JZ	SC_9		; Se Sim: Pula Para SC_1
	MOV	A, SCORE_0	; Recupera o Valor (Alterado por XRL)
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	OUT_DEC		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_0	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_0, A
	SJMP	OUT_DEC
  SC_9:				; Caso SCORE_0 Tenha Estourado
	MOV	SCORE_0, #00H	; Zera SCORE_0
	INC	SCORE_1		; Incrementa Score 1
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Descarta Parte Mais Alta
	XRL	A, #00001010B	; Verifica Estouro da Parte Baixa
	JNZ	OUT_DEC		; Se N�o: Pula Para Pr�xima Pedra
	MOV	A, SCORE_1	; Se Sim: Recupera Score (Alterado por ANL)
	ADD	A, #00010000B	;         Incrementa Parte Alta
	ANL	A, #11110000B	;         Zera Parte Baixa
	MOV	SCORE_1, A
	LJMP	OUT_DEC		; Sai da Rotina
  DEC_P9:
	DEC	POS9		; Decrementa POS9

  OUT_DEC:
	RET


; Fun��o Respons�vel Por Inicializar as Pedras (GET_POS)
; Mantendo o Tempo de Espera Aleat�rio (GET_ESP) Entre Uma e Outra
; Controla Atrav�s de R5 Qual Pedra Deve Ser Inicializada
INI_POS:
	MOV	B, R5		; B Armazena R5
	MOV	A, B
	XRL	A, #00000000B	; Verifica Se Deve Tratar a Pedra 1
	JNZ	INI_P2		; Se J� Foi Inicializada Pula Para Pedra 2
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P1		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P1:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
;	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	JNZ	LOCAL_1		; LOCAL_1 e LOCAL_11 Necess�rios Devido
	SJMP	LOCAL_11	; Ao Estouro do La�o de JNZ para OUT_INI
  LOCAL_1:
	LJMP	OUT_INI
  LOCAL_11:
	MOV	R1, #POS1	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 1
	MOV	R5, #00000001B	;    Indica Pedra 2 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS


  INI_P2:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00000001B	; Verifica Se Deve Tratar a Pedra 2
	JNZ	INI_P3		; Se J� Foi Inicializada Pula Para Pedra 3
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P2		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P2:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
;	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	JNZ	LOCAL_2		; LOCAL_2 e LOCAL_22 Necess�rios Devido
	SJMP	LOCAL_22	; Ao Estouro do La�o de JNZ para OUT_INI
  LOCAL_2:
	LJMP	OUT_INI
  LOCAL_22:
	MOV	R1, #POS2	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 2
	MOV	R5, #00000010B	;    Indica Pedra 3 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS


  INI_P3:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00000010B	; Verifica Se Deve Tratar Pedra 3
	JNZ	INI_P4		; Se J� Foi Inicializada Pula Para Pedra 4
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P3		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P3:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
;	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	JNZ	LOCAL_3		; LOCAL_3 e LOCAL_33 Necess�rios Devido
	SJMP	LOCAL_33	; Ao Estouro do La�o de JNZ para OUT_INI
  LOCAL_3:
	LJMP	OUT_INI
  LOCAL_33:
	MOV	R1, #POS3	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 3
	MOV	R5, #00000011B	;    Indica Pedra 4 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS


  INI_P4:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00000011B	; Verifica Se Deve Tratar Pedra 4
	JNZ	INI_P5		; Se J� Foi Inicializada Pula Para Pedra 5
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P4		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P4:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
;	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	JNZ	LOCAL_4		; LOCAL_4 e LOCAL_44 Necess�rios Devido
	SJMP	LOCAL_44	; Ao Estouro do La�o de JNZ para OUT_INI
  LOCAL_4:
	LJMP	OUT_INI
  LOCAL_44:
	MOV	R1, #POS4	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 4
	MOV	R5, #00000100B	;    Indica Pedra 5 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS

  INI_P5:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00000100B	; Verifica Se Deve Tratar Pedra 5
	JNZ	INI_P6		; Se J� Foi Inicializada Pula Para Pedra 6
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P5		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P5:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
;	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	JNZ	LOCAL_5		; LOCAL_5 e LOCAL_55 Necess�rios Devido
	SJMP	LOCAL_55	; Ao Estouro do La�o de JNZ para OUT_INI
  LOCAL_5:
	LJMP	OUT_INI
  LOCAL_55:
	MOV	R1, #POS5	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 5
	MOV	R5, #00000101B	;    Indica Pedra 6 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS

  INI_P6:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00000101B	; Verifica Se Deve Tratar Pedra 6
	JNZ	INI_P7		; Se J� Foi Inicializada Pula Para Pedra 7
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P6		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P6:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	MOV	R1, #POS6	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 6
	MOV	R5, #00000110B	;    Indica Pedra 7 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS

  INI_P7:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00000110B	; Verifica Se Deve Tratar Pedra 7
	JNZ	INI_P8		; Se J� Foi Inicializada Pula Para Pedra 8
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P7		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P7:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	MOV	R1, #POS7	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 7
	MOV	R5, #00000111B	;    Indica Pedra 8 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS

  INI_P8:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00000111B	; Verifica Se Deve Tratar Pedra 8
	JNZ	INI_P9		; Se J� Foi Inicializada Pula Para Pedra 9
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P8		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P8:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	MOV	R1, #POS8	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 8
	MOV	R5, #00001000B	;    Indica Pedra 9 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido
	LJMP	OUT_INI		;    Sai de INI_POS

  INI_P9:
	MOV	A, B		; Recupera Valor em B (R5)
	XRL	A, #00001000B	; Verifica Se Deve Tratar Pedra 9
	JNZ	OUT_INI		; Se J� Foi Inicializada Sai de INI_POS
	MOV	A, R6		; Verifica Se o Espa�o J� Foi Obtido
	XRL	A, #FFH
	JNZ	W_P9		; Caso Sim: Trata o Espa�o de Espera
	LCALL	GET_ESP		; Caso N�o: Obt�m Espa�o de Espera
  W_P9:
	DEC	R6		; Decrementa o Espa�o de Espera
	MOV	A, R6		; Verifica Se Acabou a Espera
	JNZ	OUT_INI		; Se N�o: Sai de INI_POS
	MOV	R1, #POS9	; Se Sim:
	LCALL	GET_POS		;    Obt�m Posi��o Aleat�ria da Pedra 9
	MOV	R5, #00000000B	;    Indica Pedra 1 em R5
	MOV	R6, #FFH	;    Seta Espa�o Como N�o Obtido

  OUT_INI:			; Sai de INI_POS
	RET

; Rotina Respons�vel Por Tratar/Desenhar a Colis�o
CRASH:
	MOV	IE, #00H	; Desabilita as Interrup��es
	MOV	A, #00H		; Posi��o no Display = 00H (Linha 1)
	MOV	B, A		; B Armazena A
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
  DESLOC1:			; Desloca Caractere Pela Linha 1 (Esq-Dir)
	MOV	A, #FFH		; Escreve Caractere Escuro
	LCALL	LCD_CHAR
	MOV	A, #1D
	LCALL	ESPERA		; Atraso de 1/20 s	
	MOV	A, B		; Recupera B
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	INC	B		; Incrementa B
	MOV	A, B
	XRL	A, #41D		; Verifica Se Acabou a Linha
	JZ	DESLOC2		; Se Sim: Vai Para DESLOC2
	LJMP	DESLOC1		; Se N�o: Continua em DESLOC1
  DESLOC2:			; Desloca Caractere Pela Linha 2 (Dir-Esq)
	MOV	A, #67H		; Posi��o no Display = 67H (Linha 2)
	MOV	B, A		; B Armazena A
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
  LOOP_D2:
	MOV	A, #FFH		; Escreve Caractere Escuro
	LCALL	LCD_CHAR
	MOV	A, #1D
	LCALL	ESPERA		; Atraso de 1/20 s
	MOV	A, B		; Recupera B
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	DEC	B		; Decrementa B
	MOV	A, B
	XRL	A, #3EH		; Verifica Se Acabou a Linha
	JZ	OUT_DES		; Se Sim: Sai de CRASH
	LJMP	LOOP_D2		; Se N�o: Continua em LOOP_D2
  OUT_DES:
	MOV	A, #10D
	LCALL	ESPERA		; Atraso de 1/2 s

	MOV	A, #00000001B	; Limpa a Tela
	LCALL	LCD_CMD
	MOV	A, #0H		; Posi��o no Display = 00H (Linha 1)
	MOV	DPTR, #PONTOS	; String a Ser Enviada
	LCALL	LCD_POS_STRING	; Escreve a String Pontua��o
	MOV	A, #22D		; Posi��o no Display = 22D (Linha 1)
	MOV	DPTR, #H_PONT	; String a Ser Enviada
	LCALL	LCD_POS_STRING	; Escreve a String Pontua��o M�xima
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
	MOV	A, #08D		; Posi��o no Display = 08D (Linha 1)
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, SCORE_1
; Faz a Decodifica��o do Caractere da Casa do Milhar (Score)
	ANL	A, #11110000B	; Despreza Parte Menos Significativa
	RR	A
	RR	A		; Traz Parte Mais Significativa Para Menos
	RR	A
	RR	A
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
; Faz a Decodifica��o do Caractere da Casa da Centena (Score)
	MOV	A, SCORE_1
	ANL	A, #00001111B	; Despreza Parte Mais Significativa
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
; Faz a Decodifica��o do Caractere da Casa da Dezena (Score)
	MOV	A, SCORE_0
	ANL	A, #11110000B	; Despreza Parte Menos Significativa
	RR	A
	RR	A		; Traz Parte Mais Significativa Para Menos
	RR	A
	RR	A
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
; Faz a Decodifica��o do Caractere da Casa da Unidade (Score)
	MOV	A, SCORE_0
	ANL	A, #00001111B	; Despreza Parte Mais Significativa
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso

	MOV	A, H_SCR1
	CLR	C		; Limpa o Flag Carry
	SUBB	A, SCORE_1	; Verifica Se Score � Maior Que o High
	JC	NEW_SCORE	; Se Sim: Pula Para New_Score
	MOV	A, H_SCR0	; Se N�o:
	CLR	C		;         Limpa o Flag Carry
	SUBB	A, SCORE_0	;         Compara Com Parte Baixa do Score
	JC	NEW_SCORE	; Se Maior: Pula Para New_Score
	JMP	OUT_HIGH	; Se N�o: Sai
  NEW_SCORE:			; Define o Novo High Score
	MOV	A, SCORE_0
	MOV	H_SCR0, A	; Passa o Score Para o High Score
	MOV	A, SCORE_1
	MOV	H_SCR1, A
  OUT_HIGH:

; Faz a Decodifica��o do Caractere da Casa do Milhar (High Score)
	MOV	A, #35D		; Posi��o no Display = 35D (Linha 1)
	ORL	A, #10000000B	; Endere�a a Posi��o na DDRAM
	LCALL	LCD_CMD
	MOV	A, H_SCR1
	ANL	A, #11110000B	; Despreza Parte Menos Significativa
	RR	A
	RR	A		; Traz Parte Mais Significativa Para Menos
	RR	A
	RR	A
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
; Faz a Decodifica��o do Caractere da Casa da Centena (High Score)
	MOV	A, H_SCR1
	ANL	A, #00001111B	; Despreza Parte Mais Significativa
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
; Faz a Decodifica��o do Caractere da Casa da Dezena (High Score)
	MOV	A, H_SCR0
	ANL	A, #11110000B	; Despreza Parte Menos Significativa
	RR	A
	RR	A		; Traz Parte Mais Significativa Para Menos
	RR	A
	RR	A
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
; Faz a Decodifica��o do Caractere da Casa da Unidade (High Score)
	MOV	A, H_SCR0
	ANL	A, #00001111B	; Despreza Parte Mais Significativa
	ADD	A, #30H		; Adiciona 30H Devido ao ASCII ('0' = 30H)
	LCALL	LCD_CHAR	; Escreve na Tela o N�mero Obtido
	MOV	A, #5D
	LCALL	ESPERA		; Atraso
	MOV	A, #40H		; Posi��o no Display = 40H (Linha 2)
	MOV	DPTR, #STIT	; String a Ser Enviada
	LCALL	LCD_POS_STRING	; Escreve String Auxiliar

  TECLA_INIT2:			; Espera Tecla C Ser Pressionada para
				; Dar Continuidade ao Programa
	MOV	P1, #11111111B	; Prepara o Porto 1
	CLR	P1.7		; Ativa a Linha 4
	MOV	A, P1		; Verifica o Porto 1
	XRL	A, #01110111B	; Verifica Se a Tecla C foi Pressionada
	JNZ	TECLA_INIT2	; Continua Se a Tecla foi Pressionada

	LJMP	MENU_CARRINHOS	; Pula Para o Menu de Escolha
				; Onde a Pilha � Tratada Novamente
				; Evitando um Poss�vel 'Stack Overflow'


; Espera um Determinado Tempo
; A: Tempo em 1/20 segundos
; Esta Rotina Usa o Timer T1
; Esta Rotina N�o � e Nem Deve Ser Chamada Ap�s 
; a Inicializa��o dos Timer da Engine do Jogo
ESPERA:
	ANL	TMOD, #0FH	; Configura Timer para 16-bit
	ORL	TMOD, #10H
	MOV	TH1, #4CH
	MOV	TL1, #01H
	CLR	TF1		; Limpa o Bit de Overflow
	SETB	TR1		; Ativa o Timer
  _ESP_1:
	JNB	TF1, $		; Espera Ocorrer o Overflow
	CLR	TF1		; Limpa o Bit de Overflow
	DJNZ	A, _ESP_1	; Repete Caso N�o Tiver Atingido o Tempo
	CLR	TR1		; Desliga o timer
	RET