# Verificador de fórmulas PDL

Trabalho de Linguagens de Programação, 2019.1.

Implementar um programa em uma linguagem de programação funcional (utilizando apenas
este paradigma) que receba como entrada um frame PDL (i.e. um grafo com arestas rotuladas)
F = <W, Rα> tal que W é um conjunto de mundos (vértices) e Rα é uma relação binária indexada
(arestas) e uma fómula PDL ϕ. A saída deve ser o resultado da verificação de se F |= ϕ, isto
é, o resultado da verificação de se ϕ é satisfeita no frame F. Quando a certificação da resposta
constar de um trecho do frame este deve ser apresentado na saída.

Para executar o programa, entre na pasta **verificador-pdl** e execute no terminal:
```
$ ghci
```
Você deve receber como retorno:
```
GHCi, version 8.0.2: http://www.haskell.org/ghc/  :? for help
Prelude> 
```

Depois, compile o programa:
```
Prelude> :l pdl.hs
```
Você deve receber como retorno:
```
[1 of 1] Compiling Main             ( pdl.hs, interpreted )
Ok, modules loaded: Main.
*Main>
``` 

Então podemos usar a função verifica para verificar as fórmulas PDL nos modelos:
```
*Main> verifica (Fo "p") [["a","b","alpha"]]
```
Onde a entrada da função verifica corresponde primeiro à fórmula PDL, que é uma árvore binária, e segundo ao modelo que é uma lista de lista.
Nesse caso, [["a","b","alpha"]] significa “a chega em b através de alpha”
E (Fo "p") significa que p é uma folha.

Mais exemplos de entradas:

* verifica (No "~" (Fo "p") (Null) [["a","b","alpha"]]

* verifica (No "^" (Fo "p") (Fo "q")) [["a","b","alpha"]])

* verifica (No "v" (Fo "p") (Fo "q")) [["a","b","alpha"]]

* verifica (No "->" (Fo "p") (Fo "q")) [["a","b","alpha"]]

* verifica (No "<->" (Fo "p") (Fo "q")) [["a","b","alpha"]]

* verifica (No "<>" (Fo "alpha") (Fo "q")) [["a","b","alpha"]]

* verifica (No "<>" (Fo "alpha") (No "~"(Fo "q") (Null))) [["a","b","alpha"]]

* verifica (No "[]" (Fo "alpha") (No "->" (No "~"(Fo "p") (Null)) (No "<>" (Fo "alpha") (Fo "q") ) )) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]

* verifica (No "<>" (Fo "alpha") (No "->" (No "~"(Fo "p") (Null) ) (No "<>" (Fo "beta") (No "~" (Fo "q") (Null) ) ) ) ) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]

* verifica (No "<>" (No "?" (Fo "q") (Null) ) (No "~"(Fo "p") (Null)))  [["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"]]

* verifica (No "<>" (No "?" (No "~"(Fo "q") (Null) ) (Null) ) (No "~"(Fo "p") (Null)) )  [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]

* verifica (No "<>" (No "?" (No "^" (Fo "q") (Fo "p") ) (Null)) (No "~"(Fo "p") (Null)))  [["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"]]

* verifica (No "<>" (No "?" (No "v" (Fo "q") (No "~"(Fo "p") (Null) ) ) (Null) ) (No "~"(Fo "p") (Null)))  [["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"]]

