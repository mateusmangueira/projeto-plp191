:- initialization main.
:- use_module(library(pio)).
:- include('Auxiliar.pl').
:- include('MenuAuxiliar.pl').

main :-
    exibeLetreiro,
    menu.

iniciaJogo :-
    write('Comeca a putaria aqui!').

menu :-
    shell(clear),
    menuInicial,
    read_opcao(Opcao),
    selecionaOpcao(Opcao).

read_opcao(Opcao) :-
  read(Option),
  (validaOpcao(Option) -> Opcao = Option ; read_opcao(Opcao)).

validaOpcao(1).
validaOpcao(2).
validaOpcao(3).
validaOpcao(4).

selecionaOpcao(1) :- iniciaJogo.

selecionaOpcao(2) :- visualizaBaralho.

selecionaOpcao(3) :- exibeRegras.
selecionaOpcao(4) :- halt(0).