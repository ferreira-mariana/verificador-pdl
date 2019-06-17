--arvore para receber a string recursivamente
data Arv = Null | Fo String | No String Arv Arv deriving (Show, Read, Eq)

modelo = [["a", "b", "alpha"], ["a", "c", "beta"], ["c", "d", "alpha"]]
-- chamar recursivamente pros dois lados no modelo


verifica :: (Arv, [[String]]) -> String
verifica (formula, modelo)
    | avalia(formula, modelo, estado) == False = "Nao vale"
    | avalia(formula, modelo, estado) == True = "Vale"
    where estado = estadoInicial modelo
--tratar os casos em que precisamos mostrar o caminho no modelo
--'f' de formula, 'm' de modelo e 'e' de estado

avalia :: (Arv, [[String]], String) -> Bool
avalia ((Fo f), _, _) = False 
avalia ((No f (esq) (dir)), m, e)
    | f == "~" = not(avalia((esq), m, e))
    | f == "^" = avalia((esq), m, e) && avalia((dir), m, e)
    | f == "v" = avalia((esq), m, e) || avalia((dir), m, e)
    | f == "->" = avalia((esq), m, e) `implica` avalia((dir), m, e)
    | f == "<->" = avalia((esq), m, e) `biImplica` avalia((dir), m, e)
--test:
    | f == "<>" = avalia((dir), m, proximoEstado)
    where proximoEstado = head (procura esq m e)
--    | f == "[]" = ? 
avalia x = error "caso nao tratado" 


--procura caminho no grafo
--procura se podemos executar o programa no estado atual do grafo
procura :: Arv -> [[String]] -> String -> [String] 
procura p [] e = []
procura (Fo p) (x:xs) e 
    | elem e x && elem p x  = [segundo x]
    | otherwise = procura (Fo p) xs e
--procura (No f) xs e tratar esse caso
procura x y z = error "caso nao tratado"
--deve retornar uma lista com os estados destinos que chegamos depois de executar p


--primeiro estado da lista (do modelo)
estadoInicial :: [[String]] -> String
estadoInicial xs = head(head xs)
--estado onde vamos começar avaliando


--segundo elemento da lista
segundo :: [String] -> String 
segundo [_,x,_] = x

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

--entradas:
-- (Fo ("p"), [["a","b","alpha"]])
-- ((No "~" (Fo "p") (Null)), [["a","b","alpha"]])
-- ((No "^" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "v" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "->" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "<->" (Fo "p") (Fo "q")), [["a","b","alpha"]])
