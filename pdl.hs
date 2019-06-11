--arvore para receber a string recursivamente
data Arv = Null | Fo String | No String Arv Arv deriving (Show, Read, Eq)

isSatisfied :: Arv -> String
isSatisfied x = "ok"

--implicacao (->)
implicacao :: Bool -> Bool -> Bool 
implicacao p q
    | (p == True && q == False) = False 
    | otherwise = True 

--bi-implicacao (<->)
biImplicacao :: Bool -> Bool -> Bool
biImplicacao p q
    | (p == q) = True
    | otherwise = False  
