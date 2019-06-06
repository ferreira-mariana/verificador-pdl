type Vertice = String
type Aresta = (String,String)
type Grafo = [Aresta]

strToGraph :: String -> Grafo
strToGraph [x] = [([x],"0")] --trocar esse "0" por um null, mas null eh funcao em haskell
strToGraph [x,y,z] = [([x],[y]), ([x],[z])]
strToGraph x = [("0","0")]

