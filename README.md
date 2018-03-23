# GRR-LANGUAGE

Grr Language is a turing completeness recursive language that is based Chomsky grammar, however, works with few and powerful abtrasction.

Hello World:

```
[P <- "Hello World"]
[Init <- P]
```

Everything is a string and everything can be a rule (or a variable explicit or a variable implicit).

Explicit Attribution:
X <- T, that generates XXXXX = TTTTT
Implicit Attribution:
"Blue" <- "Yellow" that generates "Blue is a blue color" = "Yellow is a yellow colour"....
