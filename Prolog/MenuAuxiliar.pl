exibeLetreiro :-
    open('letreiro.txt', read, Str),
    read_file(Str,String),
    close(Str),
    nl,nl,
    exibeNaTela(String),
    shell(clear).


menuInicial :-
    write('1) Jogar'),nl,
    write('2) Visualizar Baralhos'),nl,
    write('3) Regras'),nl,
    write('4) Sair'),nl,
    write('Escolha uma Opcão: '),nl.


visualizaBaralho :-
    write("Metodo para visualizar baralhos....!")

exibeRegras :-
    shell(clear),
    write('As regras do jogo são as seguintes:\n
        ->O jogador e a máquina irão alternar turnos\n
        ->O jogador puxa aleatoriamente 3 cartas das 15 do seu baralho\n
        ->Escolhe 1 para colocar em combate\n
        ->O mesmo serve para a máquina\n
        ->As outras 2 nao escolhidas retornam ao deck\n
        ->Em cada turno escolhe um atributo para a batalha\n
        ->Marca 1 ponto quem tiver maior atributo\n
        ->Cartas especiais concederá o dobro de pontos para o vencedor do turno.\n
        ->As duas cartas que batalharam são removidas do jogo\n
        ->Quando acabarem as cartas quem tiver mais ponto vence o jogo.'),nl,
menu.

exibeNaTela([]).
exibeNaTela([H|T]):- write(H),nl, exibeNaTela(T).