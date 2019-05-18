import qualified Auxiliar as Auxiliar
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

menuMostraRegras :: IO()
menuMostraRegras = do
  putStrLn("\nAs regras do jogo são as seguintes:")
  putStrLn("->O jogador e a máquina irão alternar turnos")
  putStrLn("->O jogador puxa aleatoriamente 3 cartas das 15 do seu baralho")
  putStrLn("->Escolhe 1 para colocar em combate")
  putStrLn("->O mesmo serve para a máquina")
  putStrLn("->As outras 2 nao escolhidas retornam ao deck")
  putStrLn("->Em cada turno escolhe um atributo para a batalha")
  putStrLn("->Marca 1 ponto quem tiver maior atributo")
  putStrLn("->Cartas especiais concederá o dobro de pontos para o vencedor do turno.")
  putStrLn("->As duas cartas que batalharam são removidas do jogo")
  putStrLn("->Quando acabarem as cartas quem tiver mais ponto vence o jogo.")
  putStrLn("")
  menuInicial


 

menuInicial :: IO()
menuInicial = do
    putStrLn(opcoesMenu)
    putStrLn("Digite aqui sua opção: ")
    opcao <- getLine

    if (opcao == "1") then do
      clearScreen
      let cartasHerois = Auxiliar.iniciarCartasHerois
      deckHerois <- shuffleM cartasHerois
      let cartaViloes = Auxiliar.iniciarCartasViloes
      deckViloes <- shuffleM cartaViloes
      putStrLn ("Você deseja jogar com:  \n1) Heróis \n2) Vilões")
      baralho <- getLine
      if (baralho == "1") then do
        let cartaBatalha = deckViloes !! 0
        Auxiliar.escolheCarta deckHerois cartaBatalha
      else if( baralho == "2") then do
        let cartaBatalha = deckHerois !! 0
        Auxiliar.escolheCarta deckViloes cartaBatalha
      else do
        putStrLn("Entrada invalida.")
        menuInicial
        
    
      
    else if (opcao == "2") then do
      clearScreen
      menuVisualizaBaralho

    else if (opcao == "3") then do
      clearScreen
      menuMostraRegras

    else if (opcao == "4") then clearScreen
        else menuInicial

