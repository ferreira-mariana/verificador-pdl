--arvore para receber a string recursivamente
data Arv = Null | Fo String | No String Arv Arv deriving (Show, Read, Eq)

isSatisfied :: Arv -> String
isSatisfied x
    | isSatisfiedBool(x) == False = "Nao vale"
    | isSatisfiedBool(x) == True = "Vale"
--tratar os casos em que precisamos mostrar o caminho no modelo


isSatisfiedBool :: Arv -> Bool
isSatisfiedBool (Fo x) = False 
isSatisfiedBool (No x (right) (left))
    | x == "~" =  not(isSatisfiedBool(right))
    | x == "^" = isSatisfiedBool(right) && isSatisfiedBool(left)
    | x == "v" = isSatisfiedBool(right) || isSatisfiedBool(left)
    | x == "->" = isSatisfiedBool(right) `implica` isSatisfiedBool(left)
    | x == "<->" = isSatisfiedBool(right) `biImplica` isSatisfiedBool(left)
isSatisfiedBool x = error "caso nao tratado" 


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
