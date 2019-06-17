--arvore para receber a string recursivamente
data Arv = Null | Fo String | No String Arv Arv deriving (Show, Read, Eq)

modelo = [["a", "b", "alpha"], ["a", "c", "beta"], ["c", "d", "alpha"]]
-- chamar recursivamente pros dois lados no modelo


verifica :: (Arv, [[String]]) -> String
verifica (formula, modelo)
    | avalia(f, m, e) == False = "Nao vale"
    | avalia(f, m, e) == True = "Vale"
    where e = estadoInicial modelo
--tratar os casos em que precisamos mostrar o caminho no modelo
--'f' de formula, 'm' de modelo e 'e' de estado

avalia :: (Arv, [[String]], String) -> Bool
avalia ((Fo f), m, e) 
    | (length f == 1) = False
    | otherwise = procura(Fo f, m, e) --procura programa no grafo
avalia ((No f (esq) (dir)), m, e)
    | f == "~" = not(avalia((esq), m, e))
    | f == "^" = avalia((esq), m, e) && avalia((dir), m, e)
    | f == "v" = avalia((esq), m, e) || avalia((dir), m, e)
    | f == "->" = avalia((esq), m, e) `implica` avalia((dir), m, e)
    | f == "<->" = avalia((esq), m, e) `biImplica` avalia((dir), m, e)
--test:
--    | f == "<>" = avalia((esq), m, e) && avalia((dir), m, "proximo estado")
--    | f == "[]" = avalia((esq), m, e) && avalia((dir), m, "proximo estado")
avalia x = error "caso nao tratado" 


--procura caminho no grafo
--procura se podemos executar o programa no estado atual do grafo
procura :: (Arv, [[String]], String) -> Bool
procura x = error "caso nao tratado"


--primeiro estado da lista (do modelo)
estadoInicial :: [[String]] -> String
estadoInicial xs = head(head xs)
--estado onde vamos começar avaliando


--implicacao (->)
implica :: Bool -> Bool -> Bool 
implica p q
    | (p == True && q == False) = False 
    | otherwise = True 

--bi-implicacao (<->)
biImplica :: Bool -> Bool -> Bool
biImplica p q
    | (p == q) = True
    | otherwise = False  

--obs:
-- (No "~" (Fo "p") (Null) )
-- quando tivermos negaçao, o filho a direita será sempre vazio
-- Vamos considerar string de tamanho 1 como p, q, r etc
-- strings maiores serao programas: alpha, beta, gama etc


--entradas:
-- (Fo ("p"), [["a","b","alpha"]])
-- ((No "~" (Fo "p") (Null)), [["a","b","alpha"]])
-- ((No "^" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "v" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "->" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "<->" (Fo "p") (Fo "q")), [["a","b","alpha"]])
