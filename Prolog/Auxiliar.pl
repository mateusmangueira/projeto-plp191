:- include('Carta.pl').

iniciaCartaHerois(Carta) :-
    open('herois.txt', read, Str),
    read_file(Str,Cartas),
    random(0,16,indexSuper),
    map(indexSuper,mapeiaCartas,Cartas,Carta),
    close(Str).

iniciaCartaViloes(Carta) :-
    open('viloes.txt', read, Str),
    read_file(Str,Cartas),
    random(0,16,indexSuper),
    map(indexSuper,mapeiaCartas,Cartas,Carta),
    close(Str).

iniciaPilha([H|T],Pilha1) :-
    takeLista([H|T],Lista1),
    stack(Lista1,Pilha1).
   
takeLista([H|T],[[NH|NT]]) :-
    takeListaAux(0,[H|T],[NH|NT]).

takeListaAux(16,_,_).
takeListaAux(Index,[H|T],[NH|NT]) :-
    Index_1 is Index + 1,
    NH = H,
    takeListaAux(Index_1,T,NT).

map(Index,FunctionName,[H|T],[NH|NT]):-
   Function=..[FunctionName,Index,H,NH],
   call(Function),
   map(Index,FunctionName,T,NT).
map(_,_,[],[]).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, String),
    atomic_list_concat(X,' ', String),
    read_file(Stream,L), !.

mapeiaCartas(posicaoSuper,List_String,Carta) :-
        nth0(0, List_String, String),
        split_string(String, ',', ' ,', List),
        nth0(0, List, Nome),
        nth0(1, List, Vitalidade),
        nth0(2, List, Inteligencia),
        nth0(3, List, Forca),
        nth0(4, List, Velocidade),
        nth0(5, List, Habilidade),
        nth0(6, List, Especial),
        nth0(7, List, Index),
        number_string(Index_Number, Index),
        eh_super(Index_Number,posicaoSuper,Especial),
        constroiCarta(Nome,Vitalidade,Inteligencia,Forca,Velocidade,Habilidade,Especial,Carta).

eh_Super(Index,IndexCarta,Super):- 
    (Index == IndexCarta -> Super = 1 ; Super = 0).

print_n_lines(0):-!. 
print_n_lines(X):- 
    integer(X), 
    Y is X - 1, 
    nl, 
    print_n_lines(Y).