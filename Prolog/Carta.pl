constroiCarta(Nome,Vitalidade,Inteligencia,Forca,Velocidade,Habilidade,Especial,carta(Nome,Vitalidade,Inteligencia,Forca,Velocidade,Habilidade,Especial)).

getNome(carta(Nome,_,_,_,_,_,_),Nome).
getVitalidade(carta(_,Vitalidade,_,_,_,_,_),Vitalidade).
getInteligencia(carta(_,_,_Inteligencia,_,_,_)).
getForca(carta(_,_,_,Forca,_,_,_),Forca).
getVelocidade(carta(_,_,_,_,Velocidade,_,_),Velocidade).
getHabilidade(carta(_,_,_,_,_,Habilidade,_,),Velocidade).
getEspecial(carta(_,_,_,_,_,_,isEspecial),isEspecial.

isEspecial(carta(_,_,_,_,_,_,True))

descricaoCarta(Carta) :-
    write('') ,nl,
    getNome(Carta,Nome_),
    getVitalidade(Carta,Vitalidade_),
    getInteligencia(Carta,Vitalidade_),
    getForca(Carta,Forca_),
    getVelocidade(Carta,Velocidade_),
    getHabilidade(Carta,Habilidade_),
    Trunfo = isEspecial(Carta),
    string_concat('Nome: ', Nome_, Nome),
    string_concat('Vitalidade: ', Vitalidade_, Vitalidade),
    string_concat('Inteligencia: ', Inteligencia_, Inteligencia),
    string_concat('Forca: ', Forca_, Forca),
    string_concat('Velocidade: ', Velocidade_, Velocidade),
    string_concat('Habilidade: ', Habilidade_ , Habilidade),
    
    write(Nome),nl,
    write(Vitalidade),nl,
    write(Inteligencia),nl,
    write(Forca),nl,
    write(Velocidade),nl,
    write(Habilidade),nl,
    Trunfo -> write('CARTA ESPECIAL') ; write('').