--arvore para receber a string recursivamente
data Arv = Null | Fo String | No String Arv Arv deriving (Show, Read, Eq)

--modelo = [["a", "b", "alpha"], ["a", "c", "beta"], ["c", "d", "alpha"]]
-- chamar recursivamente pros dois lados no modelo


verifica :: Arv -> [[String]] -> String
verifica formula modelo
    | avalia formula modelo estado == False = "Nao vale"
    | avalia formula modelo estado == True = "Vale"
    where estado = estadoInicial modelo
--tratar os casos em que precisamos mostrar o caminho no modelo
--'f' de formula, 'm' de modelo e 'e' de estado

avalia :: Arv -> [[String]] -> String -> Bool
avalia (Fo f) _ _ = False 
avalia (No f (esq) (dir)) m e
    | f == "~" = not(avalia esq m e)
    | f == "^" = avalia esq m e && avalia dir m e
    | f == "v" = avalia esq m e || avalia dir m e
    | f == "->" = avalia esq m e `implica` avalia dir m e
    | f == "<->" = avalia esq m e `biImplica` avalia dir m e
--test:
    | f == "<>" = verificaPrograma esq m e && avaliaEstadosTag esq dir m (procura esq m e [])
    --(procura esq m e []) é a lista dos estados possíveis de chegar, os estados destinos
    | f == "[]" = not(verificaPrograma esq m e) || avaliaEstadosCol esq dir m (procura esq m e [])
avalia x y z = error "caso nao tratado" 

-- avaliaEstados vai conferindo cada estado até que ache um que seja possível executar o programa
-- caso não ache nenhum estado, retorna falso. (ou seja, se achar pelo menos um já retorna True)
avaliaEstadosTag :: Arv -> Arv -> [[String]] -> [String] -> Bool
avaliaEstadosTag esq dir [] _ = False
avaliaEstadosTag esq dir _ [] = False
avaliaEstadosTag esq dir m destinos
    | avalia dir m (head destinos) == True = True
    | otherwise = avaliaEstadosTag esq dir m (tail destinos)


avaliaEstadosCol :: Arv -> Arv -> [[String]] -> [String] -> Bool
avaliaEstadosCol esq dir [] _ = False
avaliaEstadosCol esq dir _ [] = True
avaliaEstadosCol esq dir m destinos
    | avalia dir m (head destinos) == False = False
    | otherwise = avaliaEstadosCol esq dir m (tail destinos)

--procura caminho no grafo
--procura se podemos executar o programa no estado atual do grafo
--parametros: programa, modelo, estado atual e lista com os estados destinos
procura :: Arv -> [[String]] -> String -> [String] -> [String] 
procura pi [] e _ = []
procura (Fo pi) (x:xs) e destinos 
    | (head x == e) && elem pi x  = [x !! 1] ++ procura (Fo pi) xs e destinos
    | otherwise = procura (Fo pi) xs e destinos
--procura (No f) xs e tratar esse caso
procura x y z w = error "caso nao tratado"
--deve retornar uma lista com os estados destinos que chegamos depois de executar p


--verifica se tem transicao com esse programa no estado atual
verificaPrograma :: Arv -> [[String]] -> String -> Bool
verificaPrograma pi [] e = False 
verificaPrograma (Fo pi) (x:xs) e
    | (head x == e) && elem pi x = True
    | otherwise = verificaPrograma (Fo pi) xs e


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
