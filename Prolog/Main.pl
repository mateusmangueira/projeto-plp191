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
criaJogo(Pilha1,Pilha2,Player_Inicia_Jogo,Acumulador),
iniciaJogo(Pilha1,Pilha2,Player_Inicia_Jogo,Acumulador,1).

selecionaOpcao(2) :- visualizaBaralho.

selecionaOpcao(3) :- exibeRegras.
selecionaOpcao(4) :- halt(0).

iniciaJogo(_,[],_,Rodada) :- 
    number_string(Rodada,Rodada_String),
    string_concat('FIM DE JOGO PLAYER 1 VENCEU. TOTAL DE TURNOS: ',Rodada_String, jogadorVenceu),
    write(jogadorVenceu),nl.

iniciaJogo([],_,_,Rodada) :- 
      number_string(Rodada,Rodada_String),
      string_concat('FIM DE JOGO, MÁQUINA VENCEU! TOTAL DE TURNOS: ',Rodada_String, maquinaVenceu),
      write(maquinaVenceu),nl.

iniciaJogo(Pilha1,Pilha2,Player_Atual,Acumulador,Rodada) :-
    length(Pilha1,Size1),
    length(Pilha2,Size2),
    number_string(Size1, Placar1),
    number_string(Rodada,Rodada_String),
    number_string(Size2,Placar2),
    number_string(Player_Atual,Player_String),
    
    nl,
    write('PLACAR P1 '), write(Placar1), write(' X '), write(Placar2), write(' P2 - TURNO ATUAL: '),write(Rodada_String),
    write(' - PLAYER ATUAL: '),write(Player_String),
    nl,
  
    top(Pilha1,Carta1),
    top(Pilha2,Carta2),
    
    update_acumulador(Acumulador,Carta2,Acumulador_New),
    write('Nova Jogada'),nl,write('Carta Player '), write(Player_String),nl,
    mostraCartaAux(Player_Atual,Carta1,Carta2),nl,

    checaEspecial(Player_Atual,Carta1,Carta2,eh_Especial,Comparador),
    (eh_Especial == 1 -> Comp = Comparador 
     ; escolheAtributo(Player_Atual,Atributo,Carta2,Acumulador),
     comparadorAux(Player_Atual,Carta1,Carta2,Atributo,Comp)),nl,

    write('Carta Player Oponente: '),nl,
    mostraCartaAux(Player_Atual,Carta2,Carta1),nl,

    vencedor(Player_Atual,Comp,Player_Vencedor),
    trocaCartas(Player_Vencedor,Pilha1,Pilha2,Pilha1_n,Pilha2_n),
  
    Rodada_N is Rodada + 1,

    iniciaJogo(Pilha1_n,Pilha2_n,Player_Vencedor,Acumulador_New,Rodada_N).

trocaCartas(1,Pilha1,Pilha2,Pilha1_n,Pilha2_n) :-
        pop(Top,Pilha1,Pilha1_Sem_Top),
        pop(Removida,Pilha2,Pilha2_n),
        reverse(Pilha1_Sem_Top, Pilha1_Inverter),
        push(Top,Pilha1_Inverter,Pilha1_att),
        push(Removida,Pilha1_att,Pilha1_att2),
        reverse(Pilha1_att2,Pilha1_n).
    
    
trocaCartas(2,Pilha1,Pilha2,Pilha1_n,Pilha2_n) :-
     pop(Top,Pilha2,Pilha2_Sem_Top),
     pop(Removida,Pilha1,Pilha1_n),
     reverse(Pilha2_Sem_Top, Pilha2_Inverter),
     push(Top,Pilha2_Inverter,Pilha2_att),
     push(Removida,Pilha2_att,Pilha2_att2),
     reverse(Pilha2_att2,Pilha2_n).

vencedor(1,Comp,Vencedor) :-(Comp > 0 -> write('PLAYER 1 VENCEDOR DO TURNO!'),nl,Vencedor is 1 ; write('PLAYER 2 VENCEDOR DO TURNO!'),nl,Vencedor is 2 ).
vencedor(2,Comp,Vencedor) :-(Comp > 0 -> write('PLAYER 2 VENCEDOR DO TURNO!'),nl,Vencedor is 2 ; write('PLAYER 1 VENCEDOR DO TURNO!'),nl,Vencedor is 1 ).


comparadorAux(1,Carta1,Carta2,Atributo,Comparador) :- comparaCarta(Carta1,Carta2,Atributo,Comparador).
comparadorAux(2,Carta1,Carta2,Atributo,Comparador) :- comparaCarta(Carta2,Carta1,Atributo,Comparador).

checaEspecial(1,Carta1,Carta2,Is,Comparador) :-
    (ehEspecial(Carta1) -> Is = 1,
    checaEspecialAux(Carta2,Comparador)
; Is = 0).
checaEspecial(2,Carta1,Carta2,Is,Comparador) :-
        (ehEspecial(Carta2) -> Is = 1,
        checaEspecialAux(Carta1,Comparador)
    ; Is = 0).

checaEspecialAux(Carta2,Comparador) :-
    is_A(Carta2,Is),
(Is == 1 -> Comparador = -1 ; Comparador = 1).

escolheAtributo(1,Atributo,_,_) :- esclheAtributoJogador(Atributo).
escolheAtributo(2,Atributo,Carta2,Acumulador) :- 
    escolheAtributoMaquina(Carta2,Acumulador,Atributo),
    string_concat('Atributo Escolhido: ',Atributo,String),
    write(String),nl.

esclheAtributoJogador(Atributo) :-
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


criaJogo(Pilha1,Pilha2,Player_Inicia_Jogo,Acumulador) :-
    print_n_lines(2),
    iniciaCartasHerois(CartasHerois),
    iniciaCartasViloes(CartasViloes),
    random_permutation(CartasHerois, CartasHeroisEmbaralhas),
    random_permutation(CartasViloes, CartasViloesEmbaralhas),
    iniciaPilha(CartasHerois,PilhaHeroi),
    iniciaPilha(CartasViloes,PilhaVilao),
    build_acumulador_atributos(1,0,0,0,0,0,Acumulador),
    random(1, 3, Player_Inicia_Jogo),
    string_concat('PLAYER ', Player_Inicia_Jogo, P_Inicia1),
    string_concat(P_Inicia1,' INICIA O JOGO', P_Inicia),
    write(P_Inicia), nl.


escolheAtributoMaquina(Carta,Acumulador,Atributo) :-
        getVitalidade(Carta,Vitalidade_),
        number_string(Vitalidade, Vitalidade_),
        getInteligencia(Carta,Inteligencia_),
        number_string(Inteligencia, Inteligencia_),
        getForca(Carta,Forca_),
        number_string(Forca, Forca_),
        getVelocidade(Carta,Velocidade_),
        number_string(Velocidade, Velocidade_),
        getHabilidade(Carta,Habilidade_),
        number_string(Habilidade, Habilidade_),
        
       mediaVit(Acumulador,Media_Vit),
       mediaInt(Acumulador,Media_Int),
       mediaFor(Acumulador,Media_For),
       mediaVel(Acumulador,Media_Vel),
       mediaHab(Acumulador,Media_Hab),

       diferencaVit is Vitalidade - Media_Vit,
       diferencaInt is Forca - Media_Int,
       diferencaFor is Inteligencia - Media_For,
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

