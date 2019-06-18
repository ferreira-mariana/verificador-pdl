testes de <> e []:
verifica (No "<>" (Fo "alpha") (No "<>" (Fo "beta") (Fo "q") ) ) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "<>" (Fo "alpha") (No "->" (No "~" (Fo "p") (Null) ) (No "<>" (Fo "beta") (Fo "q") ) ) ) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "<>" (Fo "alpha") (No "->" (No "~" (Fo "p") (Null) ) (No "<>" (Fo "beta") (No "~" (Fo "q") (Null) ) ) ) ) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]

verifica (No "[]" (Fo "alpha") (Fo "p")) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "[]" (Fo "alpha") (No "~" (Fo "p") (Null) )) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "[]" (Fo "alpha") (No "->" (Fo "p") (No "<>" (Fo "alpha") (Fo "q") ) )) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "[]" (Fo "alpha") (No "->" (No "~" (Fo "p") (Null)) (No "<>" (Fo "alpha") (Fo "q") ) )) [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]

testes de ?:
verifica (No "<>" (No "?" (Fo "q") (Null) ) (No "~" (Fo "p") (Null)) )  [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "<>" (No "?" (No "~" (Fo "q") (Null) ) (Null) ) (No "~" (Fo "p") (Null)) )  [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "<>" (No "?" (No "^" (Fo "q") (Fo "p") ) (Null) ) (No "~" (Fo "p") (Null)) )  [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
verifica (No "<>" (No "?" (No "v" (Fo "q") (No "~" (Fo "p") (Null) ) ) (Null) ) (No "~" (Fo "p") (Null)) )  [ ["a","b","alpha"], ["a","c","alpha"], ["c","d","beta"] ]
