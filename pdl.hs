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
