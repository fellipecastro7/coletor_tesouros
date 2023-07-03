%Representação do labirinto
% A _ C T P
% P P P _ P
% C _ _ _ P
% _ P P P P
% T _ _ _ _

% Definição do ambiente
posicao_inicial(0, 0).
tamanho_labirinto(5, 5).
parede(0, 4).
parede(1, 0).
parede(1, 1).
parede(1, 2).
parede(1, 4).
parede(2, 4).
parede(3, 1).
parede(3, 2).
parede(3, 3).
parede(3, 4).
total_tesouros(2).

% Fatos dinâmicos
:- dynamic posicao_agente/2.
posicao_agente(0, 0). % Posição atual do agente

:- dynamic tesouro/2.
tesouro(0, 3). % Tesouros espalhados pelo labirinto
tesouro(4, 0).

:- dynamic tesouros_coletados/1.
tesouros_coletados(0). % Tesouros coletados pelo agente

:- dynamic tesouros_restantes/1.
tesouros_restantes(2). % Tesouros restantes no labirinto

:- dynamic caixa/2.
caixa(0, 2). % Caixas como obstáculos espalhadas pelo labirinto
caixa(2, 0).

:- dynamic acoes/1.
acoes(0). % Quantidade de ações realizadas pelo agente

% Ações disponíveis que podem ser realizadas pelo agente
mover_direita :- posicao_agente(X, Y),
                 tamanho_labirinto(_, LimiteY),
                 Ym is Y + 1,
                 Ym < LimiteY,
                 \+parede(X, Ym),
    		 \+caixa(X, Ym),
                 retract(posicao_agente(X, Y)),
                 assertz(posicao_agente(X, Ym)),
		 retract(acoes(Atual)),
		 NovaQuantAcoes is Atual + 1,
		 assertz(acoes(NovaQuantAcoes)),
		 write('--------------------------------------------'), nl,
		 exibir_labirinto,
                 write('Ação realizada pelo agente: mover-se para a direita.'), nl,
                 write('Posição atual do agente: '), 
                 write([X, Ym]), nl.

mover_esquerda :- posicao_agente(X, Y),
                  Ym is Y - 1,
                  Ym >= 0,
                  \+parede(X, Ym),
		  \+caixa(X, Ym),
                  retract(posicao_agente(X, Y)),
                  assertz(posicao_agente(X, Ym)),
		  retract(acoes(Atual)),
		  NovaQuantAcoes is Atual + 1,
		  assertz(acoes(NovaQuantAcoes)),
		  write('--------------------------------------------'), nl,
		  exibir_labirinto,
                  write('Ação realizada pelo agente: mover-se para a esquerda.'), nl,
                  write('Posição atual do agente: '), 
                  write([X, Ym]), nl.

mover_cima :- posicao_agente(X, Y),
              Xm is X - 1,
              Xm >= 0,
              \+parede(Xm, Y),
    	      \+caixa(Xm, Y),
              retract(posicao_agente(X, Y)),
              assertz(posicao_agente(Xm, Y)),
	      retract(acoes(Atual)),
	      NovaQuantAcoes is Atual + 1,
	      assertz(acoes(NovaQuantAcoes)),
	      write('--------------------------------------------'), nl,
	      exibir_labirinto,
              write('Ação realizada pelo agente: mover-se para cima.'), nl,
              write('Posição atual do agente: '), 
              write([Xm, Y]), nl.

mover_baixo :- posicao_agente(X, Y),
               Xm is X + 1,
               tamanho_labirinto(LimiteX, _),
               Xm < LimiteX,
               \+parede(Xm, Y),
   	       \+caixa(Xm, Y),
               retract(posicao_agente(X, Y)),
               assertz(posicao_agente(Xm, Y)),
	       retract(acoes(Atual)),
	       NovaQuantAcoes is Atual + 1,
	       assertz(acoes(NovaQuantAcoes)),
	       write('--------------------------------------------'), nl,
	       exibir_labirinto,
               write('Ação realizada pelo agente: mover-se para baixo.'), nl,
               write('Posição atual do agente: '), 
               write([Xm, Y]), nl.

coletar_tesouro :- posicao_agente(X, Y),
		   \+caixa(-1, -1),
                   tesouro(X, Y),
                   retract(tesouro(X, Y)),
		   retract(tesouros_restantes(Restantes)),
		   NovaQuantRestantes is Restantes - 1,
		   assertz(tesouros_restantes(NovaQuantRestantes)),
                   retract(tesouros_coletados(Coletados)),
                   NovaQuantColetados is Coletados + 1,
                   assertz(tesouros_coletados(NovaQuantColetados)),
		   retract(acoes(Atual)),
		   NovaQuantAcoes is Atual + 1,
		   assertz(acoes(NovaQuantAcoes)),
                   write('Ação realizada pelo agente: coletar tesouro.'), nl,
		   write('O tesouro foi coletado com sucesso.'), nl,
		   write('Ainda restam '),
		   write(NovaQuantRestantes),
		   write(' tesouros a serem coletados.'), nl.

pegar_caixa_baixo :- posicao_agente(X, Y),
                     Xm is X + 1,
                     caixa(Xm, Y),
                     \+caixa(-1, -1),
                     retract(caixa(Xm, Y)),
                     assertz(caixa(-1, -1)),
		     retract(acoes(Atual)),
		     NovaQuantAcoes is Atual + 1,
		     assertz(acoes(NovaQuantAcoes)),
                     write('--------------------------------------------'), nl,
                     exibir_labirinto,
                     write('Ação realizada pelo agente: pegar caixa.'), nl,
                     write('O agente está com a caixa em sua posse.'), nl.

pegar_caixa_cima :- posicao_agente(X, Y),
                    Xm is X - 1,
                    caixa(Xm, Y),
                    \+caixa(-1, -1),
                    retract(caixa(Xm, Y)),
                    assertz(caixa(-1, -1)),
		    retract(acoes(Atual)),
		    NovaQuantAcoes is Atual + 1,
		    assertz(acoes(NovaQuantAcoes)),
                    write('--------------------------------------------'), nl,
                    exibir_labirinto,
                    write('Ação realizada pelo agente: pegar caixa.'), nl,
                    write('O agente está com a caixa em sua posse.'), nl.

pegar_caixa_direita :- posicao_agente(X, Y),
                       Ym is Y + 1,
                       caixa(X, Ym),
                       \+caixa(-1, -1),
                       retract(caixa(X, Ym)),
                       assertz(caixa(-1, -1)),
		       retract(acoes(Atual)),
		       NovaQuantAcoes is Atual + 1,
		       assertz(acoes(NovaQuantAcoes)),
                       write('--------------------------------------------'), nl,
                       exibir_labirinto,
                       write('Ação realizada pelo agente: pegar caixa.'), nl,
                       write('O agente está com a caixa em sua posse.'), nl.

pegar_caixa_esquerda :- posicao_agente(X, Y),
                        Ym is Y - 1,
                        caixa(X, Ym),
                        \+caixa(-1, -1),
                        retract(caixa(X, Ym)),
                        assertz(caixa(-1, -1)),
			retract(acoes(Atual)),
                        NovaQuantAcoes is Atual + 1,
                        assertz(acoes(NovaQuantAcoes)),
                        write('--------------------------------------------'), nl,
                        exibir_labirinto,
                        write('Ação realizada pelo agente: pegar caixa.'), nl,
                        write('O agente está com a caixa em sua posse.'), nl.

largar_caixa_esquerda :- posicao_agente(X, Y),
                         Ym is Y - 1,
			 Ym >= 0,
                         \+parede(X, Ym),
                         \+caixa(X, Ym),
                         caixa(-1, -1),
                         retract(caixa(-1, -1)),
                         assertz(caixa(X, Ym)),
			 retract(acoes(Atual)),
                         NovaQuantAcoes is Atual + 1,
                         assertz(acoes(NovaQuantAcoes)),
			 write('--------------------------------------------'), nl,
			 exibir_labirinto,
                         write('Ação realizada pelo agente: largar caixa.'), nl,
			 write('O agente não está mais com a caixa em sua posse.'), nl.

largar_caixa_direita :- posicao_agente(X, Y),
			tamanho_labirinto(_, LimiteY),
                        Ym is Y + 1,
			Ym < LimiteY,
                        \+parede(X, Ym),
                        \+caixa(X, Ym),
                        caixa(-1, -1),
                        retract(caixa(-1, -1)),
                        assertz(caixa(X, Ym)),
			retract(acoes(Atual)),
                        NovaQuantAcoes is Atual + 1,
                        assertz(acoes(NovaQuantAcoes)),
                        write('--------------------------------------------'), nl,
                        exibir_labirinto,
                        write('Ação realizada pelo agente: largar caixa.'), nl,
                        write('O agente não está mais com a caixa em sua posse.'), nl.

largar_caixa_baixo :- posicao_agente(X, Y),
                      tamanho_labirinto(LimiteX, _),
                      Xm is X + 1,
                      Xm < LimiteX,
                      \+parede(Xm, Y),
                      \+caixa(Xm, Y),
                      caixa(-1, -1),
                      retract(caixa(-1, -1)),
                      assertz(caixa(Xm, Y)),
		      retract(acoes(Atual)),
                      NovaQuantAcoes is Atual + 1,
                      assertz(acoes(NovaQuantAcoes)),
                      write('--------------------------------------------'), nl,
                      exibir_labirinto,
                      write('Ação realizada pelo agente: largar caixa.'), nl,
                      write('O agente não está mais com a caixa em sua posse.'), nl.

largar_caixa_cima :- posicao_agente(X, Y),
                     Xm is X - 1,
                     Xm >= 0,
                     \+parede(Xm, Y),
                     \+caixa(Xm, Y),
                     caixa(-1, -1),
                     retract(caixa(-1, -1)),
                     assertz(caixa(Xm, Y)),
		     retract(acoes(Atual)),
                     NovaQuantAcoes is Atual + 1,
                     assertz(acoes(NovaQuantAcoes)),
                     write('--------------------------------------------'), nl,
                     exibir_labirinto,
                     write('Ação realizada pelo agente: largar caixa.'), nl,
                     write('O agente não está mais com a caixa em sua posse.'), nl.

medida_desempenho :- total_tesouros(TotalTesouros),
		     acoes(TotalAcoes),
		     tesouros_coletados(TotalColetados),
		     Medida is (TotalColetados / TotalTesouros) * (TotalColetados / TotalAcoes),
		     write('A medida de desempenho do agente é definida pela divisão do número total de tesouros coletados pela quantidade total de tesouros vezes o total de tesouros coletados divido pelo total de ações.'), nl,
		     write('Total de tesouros coletados: '),
		     write(TotalColetados), nl,
		     write('Total de tesouros escondidos pelo labirinto: '),
		     write(TotalTesouros), nl,
		     write('Total de ações realizadas pelo agente: '),
		     write(TotalAcoes), nl,
		     write('Medida de desempenho do agente: '),
		     write(Medida).

exibir_labirinto :- write('Estado atual do labirinto'), nl,
                    tamanho_labirinto(LimiteX, LimiteY),
                    LimiteX_2 is LimiteX - 1,
                    LimiteY_2 is LimiteY - 1,
		    write('+---+---+---+---+'), nl,
                    between(0, LimiteX_2, X),
		    write('|'),
                    between(0, LimiteY_2, Y),
                    (posicao_agente(X, Y) -> write(' A '); true),
                    (parede(X, Y) -> write(' # '); true),
		    (tesouro(X, Y), \+posicao_agente(X, Y) -> write(' $ '); true),
                    %(caixa(X, Y), \+posicao_agente(X, Y) -> write(' C '); true),
		    (caixa(X, Y) -> write(' C '); true),
                    (\+posicao_agente(X, Y), \+parede(X, Y), \+tesouro(X, Y), \+caixa(X, Y) -> write(' _ '); true),
                    Y =:= LimiteY_2, % verifica se é a última coluna
                    write('|'), nl,
                    X =:= LimiteX_2, % verifica se é a última linha
                    write('+---+---+---+---+'), nl, !.

exibir_instrucoes :- write('Instruções para entender a representação do labirinto:'), nl,
		     write('- O labirinto é representado como uma matriz 5x5;'), nl,
		     write('- Posições livres são representadas como "_";'), nl,
		     write('- O agente inteligente, ou, o caçador de tesouros é representado como "A";'), nl,
		     write('- Paredes do labirinto são representadas como "#";'), nl,
		     write('- Caixas são obstáculos para o agente no labirinto, porém que podem ser retiradas para a liberação do caminho, são representadas como "C";'), nl,
		     write('- Tesouros escondidos no labirinto são representados como "$".'), nl, nl.

exibir_posicao_inicial :- posicao_inicial(X, Y),
		          write('Posição inicial do agente: '),
		  	  write([X, Y]), nl.

main :- exibir_instrucoes,
    	exibir_labirinto,
    	exibir_posicao_inicial,
    	mover_direita,
    	pegar_caixa_direita,
    	largar_caixa_esquerda,
    	mover_direita,
    	mover_direita,
        coletar_tesouro,
    	mover_baixo,
        mover_baixo,
    	mover_esquerda,
        mover_esquerda,
    	pegar_caixa_esquerda,
    	largar_caixa_direita,
    	mover_esquerda,
    	mover_baixo,
    	mover_baixo,
    	coletar_tesouro,
    	medida_desempenho.

%Representação do labirinto
% A _ C T P
% P P P _ P
% C _ _ _ P
% _ P P P P
% T _ _ _ _
