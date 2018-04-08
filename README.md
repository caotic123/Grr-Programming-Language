# GRR-LANGUAGE

Try Grr Online in : https://caotic123.github.io/GRR-REPL/

Grr Language is a turing completeness recursive language that is based in Chomsky theory about Chomsky hierarchy in focus on Type-0 Languages and Generative grammar.

Hello World:

```
[P <- "Hello World"]
[Ώ <- P]
```

Everything is a string and everything can be a rule (or a variable explicit or a variable implicit).

# Introdution

Grr works with rules that can be definied to be replaced by others rules so....

```
X <- S
P <- X
```

X takes a the S string and P takes a X, so... P in the finally takes a S rule. It's make simple a recursive loop ```P <- P```
( 'P' Read P->Write P 'P'->Read P->Write P 'P'....). But the Machine Turing needs to halt to recognize the program.

```
 X <- DX
 DDDDDDDDDX <- halt
```

Begining X this generates a string X <- DX so... (DDX)...(DDDX)....., until don't generate the rule (DDDDDDDDDX) and halts.
A recurse added in Grr Language that don't belong the gramatic of chomsky it's a parameterization of rules it's means that rules can be ignore, extract and treat substrings.

```
P <- D(return this)
D(x) <- x
```

The rule apply D(return this) in D(x) and do a small recursive call(it's recursive because the interpreter creates a context separated and interpreter only this so... is the same thing that ```x <- return this D <- x``` ). Then P go to return this.

```
P <- f(f(12)(13)(14))(f(12)(13)(14))(f(12)(13)(14))
f(x)(y)(z)(_) <- _
```

f returns only the last parameter, so the result is f(12)(13)(14) and in finally (14), P takes a 14 :)
We can call this of function, but procedural function or math functions?(let's go discuss before).

Other recurse powerful is a backing recursive, ok we know that rules can be recursives and call itself, however, this is not good for big rules that you need a strict control. For this exist a recurse of scope.

```
[ (1)
  P <- F(F(x))x (x <- λ) (F(y) <- y) (only two rules) rules only of (1 + 1) = (2)
  x <- λ 
  [ if a string down in a rule here (2 + 1) = (3)
    F(y) <- y  (x <- K) (if a string down here the string gain a new rule of x)
    [ (3) 
      x <- K
    ]
  ]
]
```

In the example, the code returns only K by rule P, because P is F(F(x))x and all to belong in first scope, if a rule of context more down generates a new string then this string gain a new options of rule.

# Some Implications of Grr

To proof that Grr is a turing-complete it's necessary construct a Turing Machine in Grr or just descrive a language that also being turing completeness. The proof was a interpreter of brainfuck a minimal and basic turing completeness language constructed where the file brainf.gmt is the code, however, exist others forms to proof this.

In Grr exist a new form of rules that ignore and to receive substring and we called this of functions, but this functions maybe can be a math function and simulate lambda calculus?. In theory Grr Functions only do replace of strings no more...., but it's means that this function can to return a other function and to receive a function as parameter ok then they are higher-order function. Using only textual names for descrive the lambda functions it's possibly creates a combinator Y.

```
((f(_) (_ _)) (f(_) (_ _) ))
[
   Ώ <- LAMBDAF(LAMBDAX)
   LAMBDAF(_) <- _(_)
   LAMBDAX(_) <- _(_)
]
```

Hummm, to stay thinking.... :D

# Some of implementations
 
Like Lambda Calculus is possible reduce integer numbers in few lines of code:
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
Although it's allow count number, only this way is limited so we can to define a new operation ```ADD(X)(Y) <- XY```, and this allow the sum of two numbers. And after all, the multiplication:
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
