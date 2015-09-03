# What Is Meant by Data?

We began the rational-number implementation in
[earlier](/section/2-data-abstraction) by implementing the
rational-number operations `add-rat`, `sub-rat` and so on in terms of
three unspecified functions: `make-rat`, `numer`, and `denom`.  At
that point, we could think of the operations as being defined in terms
of data objects - numerators, denominators, and rational numbers -
whose behavior was specified by the latter three functions.

But exactly what is meant by data? It is not enough to say “whatever
is implemented by the given selectors and constructors.” Clearly, not
every arbitrary set of three functions can serve as an appropriate
basis for the rational-number implementation. We need to guarantee
that, if we construct a rational number x from a pair of integers n
and d , then extracting the `numer` and the `denom` of `x` and
dividing them should yield the same result as dividing `n` by `d`. In
other words, `make-rat`, `numer`, and `denom` must satisfy the
condition that, for any integer n and any non-zero integer `d`, if `x`
is `(make-rat n d)`, then:

```clojure
> (= (/ (numer x)
        (demom y))
     (/ n d))
true
```

In fact, this is the only condition `make-rat`, `numer`, and `denom`
must fulfill in order to form a suitable basis for a rational-number
representation.  In general, we can think of data as defined by some
collection of selectors and constructors, together with specified
conditions that these functions must fulfill in order to be a valid
representation [^1]

[^1]: Surprisingly, this idea is very difficult to formulate
    rigorously. There are two approaches to giving such a formulation. One,
    pioneered by C. A. R. Hoare (1972), is known as the method of abstract
    models . It formalizes the “functions plus conditions” specification
    as outlined in the rational-number example above. Note that the
    condition on the rational-number representation was stated in terms of
    facts about integers (equality and division). In general, abstract
    models define new kinds of data objects in terms of previously defined
    types of data objects. Assertions about data objects can therefore be
    checked by reducing them to assertions about previously defined data
    objects. Another approach, introduced by Zilles at MIT, by Goguen,
    Thatcher, Wagner, and Wright at IBM (see Thatcher et al. 1978), and by
    Guttag at Toronto (see Guttag 1977), is called algebraic specification
    . It regards the “functions” as elements of an abstract algebraic
    system whose behavior is specified by axioms that correspond to our
    “conditions,” and uses the techniques of abstract algebra to check
    assertions about data objects. Both methods are surveyed in the paper
    by Liskov and Zilles (1975).

This point of view can serve to define not only “high-level” data
objects, such as rational numbers, but lower-level objects as
well.

# Everything From (Almost) Nothing

Consider the notion of a pair, which we used in order to define our
rational numbers. We never actually said what a pair was, only that
the language supplied functions cons , car , and cdr for operating on
pairs. But the only thing we need to know about these three operations
is that if we glue two objects together using cons we can retrieve the
objects using car and cdr . That is, the operations satisfy the
condition that, for any objects `x` and `y`, if `z` is `(cons x y)`
then `(car z)`is x and `(cdr z)` is y .

Indeed, we imagined that these three functions are included as
primitives in our language. However, any triple of functions that
satisfies the above condition can be used as the basis for
implementing pairs.  This point is illustrated strikingly by the fact
that we could implement `cons` , `car` , and `cdr` without using any
data structures at all but only using functions.

Here are the definitions:

```clojure
(defn cons [x y]
  (fn [m]
    (cond (= m 0) x
          (= m 1) y)))

(defn car [z]
  (z 0))

(defn cdr [z]
  (z 1))
```

This use of functions corresponds to nothing like our intuitive
notion of what data should be. Nevertheless, all we need to do to show
that this is a valid way to represent pairs is to verify that these
functions satisfy the condition given above.

The subtle point to notice is that the value returned by `(cons x y)`
is a function, which takes one argument and returns either `x` or `y`
depending on whether the argument is `0` or `1`. Correspondingly,
`(car z)` is defined to apply `z` to `0`. Hence, if `z` is the
function formed by `(cons x y)`, then `z` applied to `0` will yield
`x` . Thus, we have shown that `(car (cons x y))` yields `x`, as
desired. Similarly, `(cdr (cons x y))` applies the function returned
by `(cons x y)` to `1`, which returns `y`. Therefore, this functional
implementation of pairs is a valid implementation, and if we access
pairs using only `cons`, `car`, and `cdr` we cannot distinguish this
implementation from one that uses “real” data structures.

The point of exhibiting the functional representation of pairs is not
that our language works this way (Scheme, Clojure, and Lisp systems in
general, implement pairs directly, for efficiency reasons) but that it
could work this way. The functional representation, although obscure,
is a perfectly adequate way to represent pairs, since it fulfills the
only conditions that pairs need to fulfill. This example also
demonstrates that the ability to manipulate functions as objects
automatically provides the ability to represent compound data. This
may seem a curiosity now, but procedu- ral representations of data
will play a central role in our programming repertoire.

# Numbers from functions

In case representing pairs as functions wasn’t mind-boggling enough,
consider that, in a language that can manipulate functions, we can get
by without numbers (at least insofar as nonnegative integers are
concerned) by implementing `0` and the operation of adding `1` as

```clojure
(def zero (fn [f] (fn [x] x)))

(defn inc [n]
  (fn [f] (fn [x] (f ((n f) x)))))
```

Can you figure out what one and two would be?  (use substitution to
evaluate `(inc zero)`)

This representation is known as
[Church Numerals](https://en.wikipedia.org/wiki/Church_encoding#Church_numerals),
after its inventor, Alonzo Church, the logician who invented the
λ-calculus, and you will have lots of fun using them in the
[project](/project-numbers)

So in Chapter One we looked at functions of numbers, we then
introduced data structures and saw that we could create them from
functions, lastly we created numbers from functions. I'd say that was
pretty magic.
