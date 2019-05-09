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
  

menuInicial :: IO()
menuInicial = do
    putStrLn(opcoesMenu)
    putStrLn("Digite aqui sua opcao:")
    opcao <- getLine

    if opcao == "1" then do
      clearScreen
      let cartasHerois = Auxiliar.iniciarCartasHerois
      deckHerois <- shuffleM cartasHerois
      let cartaViloes = Auxiliar.iniciarCartasViloes
      deckViloes <- shuffleM cartaViloes
      putStrLn (">>> CARTAS EMBARALHADAS <<<")
    
      let lista_herois = take 15 deckHerois
      let lista_viloes = take 15 deckViloes
      let pilha_herois = Auxiliar.iniciarPilha lista_herois
      let pilha_viloes = Auxiliar.iniciarPilha lista_viloes
      putStrLn (">>> PILHAS MONTADAS <<<")

      --gameLoop atributo pilha_herois pilha_viloes 1 0 0

    else if opcao == "2" then do
      clearScreen
      putStrLn("Visualizar Baralhos")
      
    else if opcao == "3" then do
      putStrLn("\nAs regras do jogo sao as seguintes:")
      putStrLn("->O jogador e a máquina irão alternar turnos")
      putStrLn("->O jogador puxa aleatoriamente 3 cartas das 15 do seu baralho")
      putStrLn("->Escolhe 1 para colocar em combate")
      putStrLn("->O mesmo serve para a máquina")
      putStrLn("->As outras 2 nao escolhidas retornam ao deck")
      putStrLn("->Em cada turno escolhe um atributo para a batalha")
      putStrLn("->Marca 1 ponto quem tiver maior atributo")
      putStrLn("->As duas cartas que batalharam são removidas do jogo")
      putStrLn("->Quando acabarem as cartas quem tiver mais ponto vence o jogo.")
      putStrLn("")
      menuInicial
    
    else if opcao == "4" then clearScreen
        else
            menuInicial

--gameLoop :: Int -> Pilha.Stack Carta.Carta -> Pilha.Stack Carta.Carta -> Int -> Int -> Int -> IO()
--gameLoop atributo pilha1 pilha2 rodadaAtual scoreJogador scoreMaquina = do
  --clearScreen
  --if Pilha.empty pilha1 then putStrLn ("FIM DE JOGO - MÁQUINA VENCEU!! \nTOTAL DE RODADAS: " ++ show(rodadaAtual))
  --else if Pilha.empty pilha2 then putStrLn ("FIM DE JOGO - VOCE VENCEU!! \nTOTAL DE RODADAS: " ++ show(rodadaAtual))
    --else do
      --let carta_p1 = Pilha.peek pilha1
      --let carta_p2 = Pilha.peek pilha2
 

ganhaCarta :: Carta.Carta -> Pilha.Stack Carta.Carta -> Pilha.Stack Carta.Carta
ganhaCarta carta pilha = do
  let (carta_removida,pilha_temp1) = Pilha.pop pilha
  let pilha_temp2 = Pilha.invertePilha pilha_temp1
  let pilha_temp3 = Pilha.push carta_removida pilha_temp2
  let pilha_temp4 = Pilha.push carta pilha_temp3
  Pilha.invertePilha pilha_temp4