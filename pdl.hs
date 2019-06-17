--arvore para receber a string recursivamente
data Arv = Null | Fo String | No String Arv Arv deriving (Show, Read, Eq)

verifica :: (Arv,[[String]]) -> String
verifica (f,m)
    | avalia(f) == False = "Nao vale"
    | avalia(f) == True = "Vale"
--tratar os casos em que precisamos mostrar o caminho no modelo
--'f' de formula e 'm' de modelo

avalia:: Arv -> Bool
avalia(Fo f) = False 
avalia(No f (esq) (dir))
    | f == "~" =  not(avalia(esq))
    | f == "^" = avalia(esq) && avalia(dir)
    | f == "v" = avalia(esq) || avalia(dir)
    | f == "->" = avalia(esq) `implica` avalia(dir)
    | f == "<->" = avalia(esq) `biImplica` avalia(dir)
avalia f = error "caso nao tratado" 


modelo = [["a", "b", "alpha"], ["a", "c", "beta"], ["c", "d", "alpha"]]
-- chamar recursivamente pros dois lados no modelo


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
