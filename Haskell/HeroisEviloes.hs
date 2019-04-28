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

    if opcao == "1" then putStrLn("Funcao jogar")

    else if opcao == "2" then putStrLn("FALTA IMPLEMENTAR... Visualizar Baralhos...")

    else if opcao == "3" then putStrLn("FALTA IMPLEMENTAR... Mostrar Regras...")
    
    else if opcao == "4" then clearScreen
        else
            menuInicial