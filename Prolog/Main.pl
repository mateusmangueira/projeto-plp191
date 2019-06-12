:- initialization main.
:- use_module(library(pio)).
:- include('Auxiliar.pl').
:- include('Pilha.pl').
:- include('MenuAuxiliar.pl').

main :-
    exibeLetreiro,
    menu.

menu :-
    menuInicial,
    inputOpcao(Opcao),
    selecionaOpcao(Opcao).

inputOpcao(Opcao) :-
  read(Option),
  (validaOpcao(Option) -> Opcao = Option ; inputOpcao(Opcao)).

validaOpcao(1).
validaOpcao(2).
validaOpcao(3).
validaOpcao(4).

selecionaOpcao(1) :- 
criaJogo(Pilha1,Pilha2,PlayerIniciaJogo,Acumulador),
iniciaJogo(Pilha1,Pilha2,PlayerIniciaJogo,Acumulador,1).

selecionaOpcao(2) :- visualizaBaralho.

selecionaOpcao(3) :- exibeRegras.
selecionaOpcao(4) :- halt(0).

iniciaJogo(_,[],_,_,Rodada) :- 
    number_string(Rodada,RodadaString),
    string_concat('FIM DE JOGO PLAYER VENCEU. TOTAL DE TURNOS: ',RodadaString,JogadorVenceu),
    write(JogadorVenceu),nl.

iniciaJogo([],_,_,_,Rodada) :- 
      number_string(Rodada,RodadaString),
      string_concat('FIM DE JOGO, MÁQUINA VENCEU! TOTAL DE TURNOS: ',RodadaString,MaquinaVenceu),
      write(MaquinaVenceu),nl.

iniciaJogo(Pilha1,Pilha2,PlayerAtual,Acumulador,Rodada) :-
    length(Pilha1,Size1),
    length(Pilha2,Size2),
    number_string(Size1, Placar1),
    number_string(Rodada,RodadaString),
    number_string(Size2,Placar2),
    number_string(PlayerAtual,PlayerString),
    
    nl,
    write('PLACAR P1 '), write(Placar1), write(' X '), write(Placar2), write(' P2 - TURNO ATUAL: '),write(RodadaString),
    write(' - PLAYER ATUAL: '),write(PlayerString),
    nl,

    sleep(1),
  
    top(Pilha1,Carta1),
    top(Pilha2,Carta2),

    sleep(1),
    
    atualizaAcumulador(Acumulador,Carta2,NovoAcumulador),
    write('Nova Jogada'),nl,write('Carta Player '), write(PlayerString),nl,
    mostraCartaAux(PlayerAtual,Carta1,Carta2),nl,

    sleep(4),

    checaEspecial(PlayerAtual,Carta1,Carta2,Eh_Especial,Comparador),
    (Eh_Especial == 1 -> Comp = Comparador ; escolheAtributo(PlayerAtual,Atributo,Carta2,Acumulador), comparadorAux(PlayerAtual,Carta1,Carta2,Atributo,Comp)),nl,

    sleep(3),

    write('Carta Oponente: '),nl,
    mostraCartaAux(PlayerAtual,Carta2,Carta1),nl,

    sleep(3),

    vencedor(PlayerAtual,Comp,PlayerVencedor),
    trocaCartas(PlayerVencedor,Pilha1,Pilha2,Pilha1Nova,Pilha2Nova),

    sleep(4),
  
    RodadaNova is Rodada + 1,

    iniciaJogo(Pilha1Nova,Pilha2Nova,PlayerVencedor,NovoAcumulador,RodadaNova).

trocaCartas(1,Pilha1,Pilha2,Pilha1Nova,Pilha2Nova) :-
    pop(Top,Pilha1,Pilha1Removida),
    pop(Removida,Pilha2,Pilha2Nova),
    reverse(Pilha1Removida, Pilha1Invertida),
    push(Top,Pilha1Invertida,Pilha1Atualizada),
    push(Removida,Pilha1Atualizada,Pilha1Atualizada2),
    reverse(Pilha1Atualizada2,Pilha1Nova).

trocaCartas(2,Pilha1,Pilha2,Pilha1Nova,Pilha2Nova) :-
     pop(Top,Pilha2,Pilha2Removida),
     pop(Removida,Pilha1,Pilha1Nova),
     reverse(Pilha2Removida, Pilha2Invertida),
     push(Top,Pilha2Invertida,Pilha2Atualizada),
     push(Removida,Pilha2Atualizada,Pilha2Atualizada2),
     reverse(Pilha2Atualizada2,Pilha2Nova).
    

vencedor(1,Comp,Vencedor) :-(Comp > 0 -> write('PLAYER 1 VENCEDOR DO TURNO!'),nl,Vencedor is 1 ; write('PLAYER 2 VENCEDOR DO TURNO!'),nl,Vencedor is 2 ).
vencedor(2,Comp,Vencedor) :-(Comp > 0 -> write('PLAYER 2 VENCEDOR DO TURNO!'),nl,Vencedor is 2 ; write('PLAYER 1 VENCEDOR DO TURNO!'),nl,Vencedor is 1 ).

comparadorAux(1,Carta1,Carta2,Atributo,Comparador) :- comparaCarta(Carta1,Carta2,Atributo,Comparador).
comparadorAux(2,Carta1,Carta2,Atributo,Comparador) :- comparaCarta(Carta2,Carta1,Atributo,Comparador).

checaEspecial(1,Carta1,Carta2,Is,Comparador) :-
    (ehEspecial(Carta1) -> Is = 1, checaEspecialAux(Carta2,Comparador) ; Is = 0).

checaEspecial(2,Carta1,Carta2,Is,Comparador) :-
        (ehEspecial(Carta2) -> Is = 1, checaEspecialAux(Carta1,Comparador) ; Is = 0).

checaEspecialAux(Carta2,Comparador) :-
    ehEspecial(Carta2,Is), (Is == 1 -> Comparador = -1 ; Comparador = 1).

escolheAtributo(1,Atributo,_,_) :- escolheAtributoJogador(Atributo).

escolheAtributo(2,Atributo,Carta2,Acumulador) :- 
    escolheAtributoMaquina(Carta2,Acumulador,Atributo),
    string_concat('Atributo Escolhido: ',Atributo,String),
    write(String),nl.

escolheAtributoJogador(Atributo) :-
    write('ESCOLHA UM ATRIBUTO: 1) VITALIDADE  2) INTELIGENCIA  3) FORCA  4) VELOCIDADE  5) HABILIDADE'),nl,
    leAtributo(Leitura),
    selecionaAtributo(Leitura,Atributo).

selecionaAtributo(1,Atributo) :- Atributo = 'VITALIDADE'.
selecionaAtributo(2,Atributo) :- Atributo = 'INTELIGENCIA'.
selecionaAtributo(3,Atributo) :- Atributo = 'FORCA'.
selecionaAtributo(4,Atributo) :- Atributo = 'VELOCIDADE'.
selecionaAtributo(5,Atributo) :- Atributo = 'HABILIDADE'.


leAtributo(Atributo) :-
    read(Read),
    (valida_atributo(Read) -> Atributo = Read ; leAtributo(Atributo)).

valida_atributo(1).
valida_atributo(2).
valida_atributo(3).
valida_atributo(4).
valida_atributo(5).

mostraCartaAux(1,Carta1,_) :- descricaoCarta(Carta1).
mostraCartaAux(2,_,Carta2) :- descricaoCarta(Carta2).

criaJogo(Pilha1,Pilha2,PlayerIniciaJogo,Acumulador) :-
    imprimeLinha(2),
    iniciaCarta(Cartas),
    random_permutation(Cartas, CartasEmbaralhadas),
    sleep(2),
    iniciaPilha(CartasEmbaralhadas,Pilha1,Pilha2),
    criaAcumulador(1,0,0,0,0,0,Acumulador),
    sleep(2),
    string_concat('PLAYER ', PlayerIniciaJogo, PlayerInicia1),
    string_concat(PlayerInicia1,' INICIA O JOGO', PlayerInicia),
    write(PlayerInicia), nl,
    sleep(2).


escolheAtributoMaquina(Carta,Acumulador,Atributo) :-
        getVitalidade(Carta,Vitalidade_),
        number_string(Vitalidade,Vitalidade_),
        getInteligencia(Carta,Inteligencia_),
        number_string(Inteligencia,Inteligencia_),
        getForca(Carta,Forca_),
        number_string(Forca,Forca_),
        getVelocidade(Carta,Velocidade_),
        number_string(Velocidade,Velocidade_),
        getHabilidade(Carta,Habilidade_),
        number_string(Habilidade,Habilidade_),
        
       mediaVit(Acumulador,Media_Vit),
       mediaInt(Acumulador,Media_Int),
       mediaFor(Acumulador,Media_For),
       mediaVel(Acumulador,Media_Vel),
       mediaHab(Acumulador,Media_Hab),

       diferencaVit is Vitalidade - Media_Vit,
       diferencaInt is Inteligencia - Media_Int,
       diferencaFor is Forca - Media_For,
       diferencaVel is Velocidade - Media_Vel,
       diferencaHab is Habilidade - Media_Hab,

      escolheAtributoMaquinaAux(diferencaVit,diferencaInt,diferencaFor,diferencaVel,diferencaHab,Atributo).


escolheAtributoMaquinaAux(diferencaVit,diferencaInt,diferencaFor,diferencaVel,diferencaHab,Atributo) :-
    List = [diferencaVit,diferencaInt,diferencaFor,diferencaVel,diferencaHab],
    max_list(List, Max),
    (diferencaVit >= Max -> Atributo = 'VITALIDADE'
    ;diferencaInt >= Max -> Atributo = 'INTELIGENCIA'
    ;diferencaFor >= Max -> Atributo = 'FORCA'
    ;diferencaVel >= Max -> Atributo = 'VELOCIDADE'
    ; Atributo = 'HABILIDADE').

