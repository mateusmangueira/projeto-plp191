import qualified Auxiliar as Auxiliar
import qualified Pilha as Pilha
import qualified Carta as Carta
import Control.Concurrent
import System.Console.ANSI
import System.Random.Shuffle


main :: IO()
main = do
  putStrLn ("HEROIS E VILOES - SUPER TRUNFO")
  menuInicial

opcoesMenu :: String
opcoesMenu = "Escolha uma Opcão: \n1) Jogar \n2) Visualizar Baralhos \n3) Regras \n4) Sair"
  

menuInicial :: IO()
menuInicial = do
    putStrLn(opcoesMenu)
    putStrLn("Digite aqui sua opcao:")
    opcao <- getLine

    if opcao == "1" then do
      let cartasHerois = Auxiliar.iniciarCartasHerois
      deckHerois <- shuffleM cartasHerois
      let cartaViloes = Auxiliar.iniciarCartasViloes
      deckViloes <- shuffleM cartaViloes
      putStrLn (">>> CARTAS EMBARALHADAS <<<")
      
      let lista_herois = take 15 deckHerois
      let lista_viloes = take 15 deckViloes
      let pilha_herois = Auxiliar.iniciarPilha lista_herois
      let pilha_herois = Auxiliar.iniciarPilha lista_viloes
      putStrLn (">>> PILHAS MONTADAS <<<")
      
    
    else if opcao == "2" then putStrLn("FALTA IMPLEMENTAR... Visualizar Baralhos...")

    else if opcao == "3" then putStrLn("FALTA IMPLEMENTAR... Mostrar Regras...")
    
    else if opcao == "4" then clearScreen
        else
            menuInicial


ganhaCarta :: Carta.Carta -> Pilha.Stack Carta.Carta -> Pilha.Stack Carta.Carta
ganhaCarta carta pilha = do
  let (carta_removida,pilha_temp1) = Pilha.pop pilha
  let pilha_temp2 = Pilha.invertePilha pilha_temp1
  let pilha_temp3 = Pilha.push carta_removida pilha_temp2
  let pilha_temp4 = Pilha.push carta pilha_temp3
  Pilha.invertePilha pilha_temp4