import qualified Auxiliar as Auxiliar
import qualified Pilha as Pilha
import qualified Carta as Carta
import Control.Concurrent
import System.Console.ANSI
import System.Random.Shuffle


main :: IO()
main = do
  putStrLn ("HEROIS E VILOES - SUPER TRUNFO")
  threadDelay 3000000
  clearScreen
  menu

opcoesMenu :: String
opcoesMenu = "Escolha uma Opcão: \n1) Jogar \n2) Visualizar Baralhos \n3) Regras \n4) Sair"
  

menuInicial :: IO()
menuInicial = do
    putStrLn(opcoesMenu)
    putStrLn("Digite aqui sua opcao:")
    opcao <- getLine

    if opcao == "1" then do
        
        clearScreen
        putStrLn("Deseja jogar com: \n1) Herois \n2) Viloes")
        novaOpcao <- getLine
        if novaOpcao == "1" then do
            let cartasHerois = Auxiliar.iniciarCartasHerois
            let cartasViloes = Auxiliar.iniciarCartasViloes
            deckHerois <- shuffleM cartasHerois
            deckVilao <- shuffleM cartasViloes
            putStrLn (">>> CARTAS EMBARALHADAS <<<")
            threadDelay 2000000

            let lista_1 = take 3 deckHerois
            --Mostrar cartas de herois escolhidas
            let lista_2 = take 3 deckVilao
            let pilha_1 = Auxiliar.iniciarPilha lista_1
            let pilha_2 = Auxiliar.iniciarPilha lista_2
            putStrLn (">>> PILHAS MONTADAS <<<")
            threadDelay 2000000

            -- FALTA IMPLEMENTAR A LOGICA, FIZ APENAS A TRATACAO DOS DADOS E TRANSFORMEI-OS EM PILHAS.

    else if opcao == "2" then putStrLn("FALTA IMPLEMENTAR O FOR DAS BARALHOS ... Visualizar Baralhos...")

    else if opcao == "3" then putStrLn("FALTA IMPLEMENTAR... Mostrar Regras...")
    
    else if opcao == "4" then clearScreen
        else
            menu

