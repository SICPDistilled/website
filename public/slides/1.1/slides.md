class: center
# The Elements of Programming

--
## Primative expressions
Simple entities

--
## Means of combination
How compound elements are built from simpler ones

--
## Means of abstraction
Allow compound elements to be named and manipulated

---
# Primative expressions

    > 3
--
    3
--

    > :foo
--
    :foo
--

    > "Hello"
--
    "Hello"
--

    > true
--
    true
--

    > undefined
--
    CompilerException java.lang.RuntimeException:
            Unable to resolve symbol: undefined in this context

--

    > \c
--
    \c
---

# Compound elements

    > (+ 2 4)
--
    6
--

    > (* 2 3 4)
--
    24
--

    > (/ 45 5 3)
--
    3

---
# Pretty Printing
    (+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))

--
```
    (+ (* 3
          (+ (* 2 4)
          (+ 3 5)))
       (+ (- 10 7)
          6))
```

---
# Naming Things

    > (define a 2)
--
    #'user/a

--

    > (* a 3)
--
    6
--

    > (+ a a 3)
--
    7

---
# Predicates
```clojure
(= x y)
```

Returns true if:

* numbers in the same 'category', and numerically the same, where category is one of (integer or ratio), floating point, or BigDecimal.
* sequences, lists, vectors, or queues, with equal elements in the same order.
* sets, with equal elements, ignoring order.
* maps, with equal key/value pairs, ignoring order.
* symbols, or both keywords, with equal namespaces and names.
* refs, vars, or atoms, and they are the same object, i.e. (identical? x y) is true.
* the same type defined with deftype. The type's equiv method is called and its return value becomes the value of (= x y).
* other types, and Java's x.equals(y) is true. The result should be unsurprising for nil, booleans, characters, and strings.

---
## Numbers with coercion
```clojure
(== x y)
```
--
    > (= 2 2.0)
    false ; has different categories integer and floating point
--

    > (== 2 2.0)
    true
--

    > (== 5 5N (float 5.0) (double 5.0) (biginteger 5))
    true
--

    > (== Double/NaN Double/NaN)
    false ; Floating point spec says this
--

    > (== :foo)
    true
--

    > (== :foo :foo)
    ClassCastException clojure.lang.Keyword cannot be cast to java.lang.Number
    clojure.lang.Numbers.equiv (Numbers.java:206)
--

    > (== 2 "a")
    ClassCastException java.lang.String cannot be cast to java.lang.Number
    clojure.lang.Numbers.equiv (Numbers.java:206)

---
# and
    (and <e1> ... <en>)
--

    > (and 3 (= 1 2) (/ 1 0))
    false
--

    > (and 3 (= 1 1) (/ 1 0))
    ArithmeticException Divide by zero  clojure.lang.Numbers.divide (Numbers.java:156)

---
# or

    (or <e1> ... <en>)
--

    > (or (= 1 1) (/ 1 0))
    true
--

    > (or (= 0 1) :truthy)
    :truthy

---
# Not

    (not <e>)

False if <e> truthy, true if <e> false


---
# Conditional Expressions
```clojure
> (def x -12)

> (cond (> x 0)
        x

        (= x 0)
        0

        (< x 0)
        (- x))
```
--
```clojure
(cond (< 0 x)
      "Negative"
      :else
      "Positive")
```

---
```
(if <predicate>
    <consequent>
    <alternative>)
```

--
```clojure
> (if (= (count "four")
         4)
      :predicate-was-true
      :predicate-was-false)
:predicate-was-true
```

--

```clojure
> (if (= (count "three")
         3)
      :no-consequent)
nil
```

---

---
# Evaluating Combinations
* Evaluate the subexpressions of the combination.
* Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).
mark

---
```clojure
(* (+ 3 (/ 10 2))
   (- 2 3)
   (+ (* 2 3) (* 5 2)))
```
---
```clojure
(def a 3)
```
'Special forms' don't follow the evaluation rule
---
# So far
* Primative
  - Data (numbers, strings, keywords, chars)
--

  - Procedures (arithmetic)

--

## Combine operations by nesting.
```clojure
(+ (* 3 5)
   (- (/ 4 3) (* 2 9)))
```
--

## Associate names with values.
```clojure
(def a 3)
(+ a 2)
```
---
## Compound Procedures
```clojure
(def square (fn [x]
              (* x x)))
```
```clojure
(defn square [x]
  (* x x))
```

```scheme
(define square (lambda (x) (* x x)))
```
```scheme
(define (square x)
   (* x x)
```
---

## The Substitution Model for Procedure Application
To apply a compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.

```
(square 5)
```
--

Take the body of the procedure
```
(* x x)
```

--

Replace formal parameter (x) with the value of the arguement (5)
```
(* 5 5)
```

--
Evaluate
```
25
```
