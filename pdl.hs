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
    | f == "~" = not(avalia(esq, m, e))
    | f == "^" = avalia(esq, m, e) && avalia(dir, m, e)
    | f == "v" = avalia(esq, m, e) || avalia(dir, m, e)
    | f == "->" = avalia(esq, m, e) `implica` avalia(dir, m, e)
    | f == "<->" = avalia(esq, m, e) `biImplica` avalia(dir, m, e)
--test:
    | f == "<>" = verificaPrograma esq m e && avalia(dir, m, proximoEstado)
    where proximoEstado = head (procura esq m e [])
--    | f == "[]" = ? 
avalia x = error "caso nao tratado" 


--procura caminho no grafo
--procura se podemos executar o programa no estado atual do grafo
--parametros: programa, modelo, estado atual e lista com os estados destinos
procura :: Arv -> [[String]] -> String -> [String] -> [String] 
procura p [] e _ = []
procura (Fo p) (x:xs) e destinos 
    | (head x == e) && elem p x  = [x !! 1] ++ procura (Fo p) xs e destinos
    | otherwise = procura (Fo p) xs e destinos
--procura (No f) xs e tratar esse caso
procura x y z w = error "caso nao tratado"
--deve retornar uma lista com os estados destinos que chegamos depois de executar p


--verifica se tem transicao com esse programa no estado atual
verificaPrograma :: Arv -> [[String]] -> String -> Bool
verificaPrograma p [] e = False 
verificaPrograma (Fo p) (x:xs) e
    | (head x == e) && elem p x = True
    | otherwise = verificaPrograma (Fo p) xs e


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

--entradas:
-- (Fo ("p"), [["a","b","alpha"]])
-- ((No "~" (Fo "p") (Null)), [["a","b","alpha"]])
-- ((No "^" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "v" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "->" (Fo "p") (Fo "q")), [["a","b","alpha"]])
-- ((No "<->" (Fo "p") (Fo "q")), [["a","b","alpha"]])
