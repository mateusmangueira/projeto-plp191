import qualified Auxiliar as Auxiliar
import qualified Pilha as Pilha
import qualified Carta as Carta
import Control.Concurrent
import System.Console.ANSI
import System.Random.Shuffle


main :: IO()
main = do
  putStrLn (Auxiliar.exibeLetreiro)
  menuInicial

opcoesMenu :: String
opcoesMenu = "\nEscolha uma Opcão: \n1) Jogar \n2) Visualizar Baralhos \n3) Regras \n4) Sair"

menuVisualizaBaralho :: IO()
menuVisualizaBaralho = do
  putStrLn("\nVocê deseja visualizar qual baralho: \n1) Heróis \n2) Vilões")
  deck <- getLine
  if(deck == "1") then do
      putStrLn("Funcao para imprimir lista de herois")
    --putStrLn(Auxiliar.imprimeLista listaHerois)
  else if(deck == "2") then do
       putStrLn("Funcao para imprimir lista de viloes")
     --putStrLn(Auxiliar.imprimeLista listaViloes)
  else do 
    putStrLn("Digite uma opção válida.")
    menuVisualizaBaralho

menuInicial :: IO()
menuInicial = do
    putStrLn(opcoesMenu)
    putStrLn("Digite aqui sua opção: ")
    opcao <- getLine

    if opcao == "1" then do
      clearScreen
      let cartasHerois = Auxiliar.iniciarCartasHerois
      deckHerois <- shuffleM cartasHerois
      let cartaViloes = Auxiliar.iniciarCartasViloes
      deckViloes <- shuffleM cartaViloes
      putStrLn ("Você deseja jogar com:  \n1) Heróis \n2) Vilões")
      baralho <- getLine
      if(baralho == "1") then do
        let listaHerois = take 15 deckHerois
        let listaViloes = take 15 deckViloes
        let pilhaHerois = Auxiliar.iniciarPilha listaHerois
        let pilhaViloes = Auxiliar.iniciarPilha listaViloes
        let heroi1 = Pilha.peek pilhaHerois
        --let heroi2 = ?? funcao next para pegar o proximo elemento da pilha
        --let heroi3 = ?? 
        let vilao1 = Pilha.peek pilhaViloes
        --let vilao2 = ??
        --let vilao3 = ??

        clearScreen

        putStrLn(Carta.descricaoCarta(heroi1))
        --putStrLn(Carta.descricaoCarta(heroi2))
        --putStrLn(Carta.descricaoCarta(heroi3))
    
      else do
        let listaViloes = take 15 deckViloes
        let pilhaViloes = Auxiliar.iniciarPilha listaViloes
        putStrLn (">>> PILHAS DOS VILÕES MONTADAS <<<")
        putStrLn("")
        let vilao = Pilha.peek pilhaViloes
        putStrLn(Carta.descricaoCarta(vilao))
        
    else if opcao == "2" then do
      clearScreen
      menuVisualizaBaralho

    else if opcao == "3" then do
      putStrLn("\nAs regras do jogo são as seguintes:")
      putStrLn("->O jogador e a máquina irão alternar turnos")
      putStrLn("->O jogador puxa aleatoriamente 3 cartas das 15 do seu baralho")
      putStrLn("->Escolhe 1 para colocar em combate")
      putStrLn("->O mesmo serve para a máquina")
      putStrLn("->As outras 2 nao escolhidas retornam ao deck")
      putStrLn("->Em cada turno escolhe um atributo para a batalha")
      putStrLn("->Marca 1 ponto quem tiver maior atributo")
      putStrLn("->As duas cartas que batalharam são removidas do jogo")
      putStrLn("->Quando acabarem as cartas quem tiver mais ponto vence o jogo.")
      putStrLn("->Cartas especiais concederá o dobro de pontos para o vencedor do turno.")
      putStrLn("")
      menuInicial
    
    else if opcao == "4" then clearScreen
        else
            menuInicial

