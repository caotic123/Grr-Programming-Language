# GRR-LANGUAGE

Grr Language is a turing completeness recursive language that is based Chomsky grammar, however, works with few and powerful abstractions.

Hello World:

```
[P <- "Hello World"]
[Ώ <- P]
```

Everything is a string and everything can be a rule (or a variable explicit or a variable implicit).

# Some of implementations
 
Like Lambda Calculus is possible redute intenger in few lines of code:
As example:

```
[

   N* <- *
   ZERO <- N
   ONE <- INC(ZERO)
   TWO <- INC(TWO)
   THREE <- INC(THREE)
   FOUR <- INC(INC(INC(INC(N))))
   INC(Y) <- Y*
   DEC(K) <- K-
]
```
Let's think each rule generates more '*', so it's basically a increment or decrement of * then 0 =```N``` and 4 =```****```.
Although it's allow count number, only this way is limited so we can to define a new operation ```ADD(X)(Y) <- XY```, and allow the sum of two numbers. And after all the multiplication:
This following code back run the expression (4x3) and resolve this.

```
[
   Ώ <- MUL(FOUR)(DEC(FOUR))
   FOUR <- INC(INC(INC(INC(N))))
   N* <- *
   INC(Y) <- Y*
   DEC(K) <- K-
   *- <- λ
   ADD(X)(Y) <- XY
   MUL(X)(Y) <- Y-REPEATZ(X)
   *REPEATZ(X) <- REPEATZ(X)X
   REPEATZ(X) <- X  
]
```

Explicit Attribution:
X <- T, that generates XXXXX = TTTTT
Implicit Attribution:
"Blue" <- "Yellow" that generates "Blue is a blue color" = "Yellow is a yellow colour"....
