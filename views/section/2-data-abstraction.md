# Data Abstraction

We noted that a function used as an element in creating a more complex
function could be regarded not only as a collection of particular
operations but also as an abstraction. That is, the details
of how the function was implemented could be suppressed, and the
particular function itself could be replaced by any other function
with the same overall behavior. In other words, we could make an
abstraction that would separate the way the function would be used
from the details of how the function would be implemented in terms of
more primitive functions. The analogous notion for compound data is
called *data abstraction* . Data abstraction is a methodology that
enables us to isolate how a compound data object is used from the
details of how it is constructed from more primitive data objects.

The basic idea of data abstraction is to structure the programs that
are to use compound data objects so that they operate on “abstract
data.”  That is, our programs should use data in such a way as to make
no assumptions about the data that are not strictly necessary for
performing the task at hand. At the same time, a “concrete” data
representation is defined independent of the programs that use the
data. The interface between these two parts of our system will be a
set of functions, called *selectors* and *constructors* , that
implement the abstract data in terms of the concrete
representation. To illustrate this technique, we will consider how to
design a set of functions for manipulating rational numbers.

# Rational Numbers

Suppose we want to do arithmetic with rational numbers. We want to be
able to add, subtract, multiply, and divide them and to test whether
two rational numbers are equal.

Let us begin by assuming that we already have a way of constructing a
rational number from a numerator and a denominator. We also assume
that, given a rational number, we have a way of extracting (or
selecting) its numerator and its denominator. Let us further assume
that the constructor and selectors are available as functions:

`(make-rat n d)`

returns the rational number whose numerator is the integer `n` and
whose denominator is the integer `d`.

`(numer x)` returns the numerator of the rational number `x`.

`(denom x)` returns the denominator of the rational number `x`.

We are using here a powerful strategy of synthesis: *wishful
thinking*. We haven’t yet said how a rational number is represented,
or how the functions `numer`, `denom` and `make-rat` should be
implemented. Even so, if we did have these three functions, we could
then add, subtract, multiply, divide, and test equality by using the
following relations:

$$ \frac{p}{q} + \frac{r}{s} = \frac{ps + rq}{qs} $$

$$ \frac{p}{q} - \frac{r}{s} = \frac{ps - rq}{qs} $$

$$ \frac{p}{q} \cdot \frac{r}{s} = \frac{pr}{qs} $$

$$ \frac{p/q}{r/s} = \frac{ps}{qr} $$

$$ \frac{p}{q} = \frac{r}{s} \iff ps = qr $$

We can express these rules as Clojure functions:

```clojure
(defn add-rat [x y]
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(defn sub-rat [x y]
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(defn mul-rat [x y]
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(defn div-rat [x y]
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(defn equal-rat? [x y]
  (= (* (numer x) (denom y))
     (* (numer y) (denom x)))
```

Now we have the operations on rational numbers defined in terms of the
selector and constructor functions numer , denom , and make-rat .
But we haven’t yet defined these. What we need is some way to glue
together a numerator and a denominator to form a rational number.

## Pairs

For this section we are sticking closely to the original text, soon we
will see a more idiomatic way to do data abstraction in Clojure but
one of the interesting things about SICP is that you build
*everything* out of the pairs described here (interesting because it
is good and bad, sometimes you get bogged down re-implementing maps
constantly)

To enable us to implement the concrete level of our data abstraction,
assume our language provides a compound structure called a pair ,
which can be constructed with the primitive function `cons` (note:
This is *not* Clojure's `cons`) . This function takes two arguments
and returns a compound data object that contains the two arguments as
parts. Given a pair, we can extract the parts using the primitive
functions `car` and `cdr`. Thus, we can use `cons`, `car`, and `cdr`
as follows:

```clojure
> (def x (cons 1 2))
#'user/x

> (car x)
1

> (cdr x)
2
```

Notice that a pair is a data object that can be given a name and
manipulated, just like a primitive data object. Moreover, `cons` [^1]
can be used to form pairs whose elements are pairs, and so on:

[^1]: The name cons stands for “construct.” The names car and cdr
    derive from the original implementation of Lisp on the IBM 704. That
    machine had an addressing scheme that allowed one to reference the
    “address” and “decrement” parts of a memory location.  Car stands for
    “Contents of Address part of Register” and cdr (pronounced “could-er”)
    stands for “Contents of Decrement part of Register.”

```clojure
> (def x (cons 1 2))
#'user/x

> (def y (cons 3 4))
#'user/y

> (def z (cons x y))
#'user/z

> (car (car z))
1

> (car (cdr z))
3
```

Pairs can be used as general-purpose building blocks to create all
sorts of complex data structures. This single compound-data primitive,
implemented by the functions `cons`, `car` and `cdr` is the only glue
we *need* [^2]. Data objects constructed from pairs are called
list-structured data.

[^2]: But perhaps not all we *want*

## Representing Rational Numbers

Pairs offer a natural way to complete the rational-number
system. Simply represent a rational number as a pair of two integers:
a numerator and a denominator. Then `make-rat`, `numer` and `denom`
are readily implemented as follows:

```clojure
(defn make-rat [n d]
  (cons n d))

(defn numer [x]
  (car x))

(defn denom [x]
  (cdr x))
```

Also, in order to display the results of our computations, we can
print rational numbers by printing the numerator, a slash, and the
denominator:

```clojure
(define print-rat [x]
  (println (numer x) "/" (denom x)))
```

You can look up how `println` works
[here](http://conj.io/store/v1/org.clojure/clojure/1.7.0/clj/clojure.core/println/)

```clojure
> (def half (make-rat 1 2))
#'user/half

> (def third (make-rat 1 3))
#'user/third

> (print-rat (add-rat half third))
5 / 6
nil

> (print-rat (mul-rat half third))
1 / 6
nil

> (print-rat (add-rat third third))
6 / 9
nil
```

As the final example shows, our rational-number implementation does
not reduce rational numbers to lowest terms. We can remedy this by
changing make-rat . If we have a gcd function like the one
[earlier](/section/1.2.4) that produces the greatest common divisor of
two integers, we can use gcd to reduce the numerator and the
denominator to lowest terms before constructing the pair:

```clojure
(defn make-rat [n d]
  (let [g (gcd n d)]
    (cons (/ n g) (/ d g))))
```

Now we have:

```clojure
> (print-rat (add-rat third third))
2 / 3
nil
```

This modification was accomplished by changing the constructor
`make-rat` without changing any of the functions (such as `add-rat`
and `mul-rat`) that implement the actual operations.

TODO: Work in Ex 2.1 to 'Numbers' project.

# Abstraction Barriers

Before continuing with more examples of compound data and data
abstraction, let us consider some of the issues raised by the
rational-number example. We defined the rational-number operations in
terms of a con- structor `make-rat` and selectors `numer` and
`denom`. In general, the under- lying idea of data abstraction is to
identify for each type of data object a basic set of operations in
terms of which all manipulations of data objects of that type will be
expressed, and then to use only those operations in manipulating the
data.

We can envision the structure of the rational-number system as shown
below:

<img src="/images/abstraction_barriers.png" alt="Abstraction Barriers">

The horizontal lines represent abstraction barriers that isolate
different “levels” of the system. At each level, the barrier separates
the programs that use the data abstraction from the programs that
implement the data abstraction. Programs that use rational numbers
manipulate them solely in terms of the functions supplied “for public
use”: `add-rat` , `sub-rat` , `mul-rat` , `div-rat` , and `equal-rat?`
. These, in turn, are implemented solely in terms of the constructor
and selectors `make-rat` , `numer` , and `denom` , which themselves
are implemented in terms of pairs.  The details of how pairs are
implemented are irrelevant to the rest of the rational-number package
so long as pairs can be manipulated by the use of `cons`, `car`, and
`cdr`. In effect, functions at each level are the interfaces that
define the abstraction barriers and connect the different levels.

This simple idea has many advantages. One advantage is that it makes
programs much easier to maintain and to modify. Any complex data
structure can be represented in a variety of ways with the primitive
data structures provided by a programming language. Of course, the
choice of representation influences the programs that operate on it;
thus, if the representation were to be changed at some later time, all
such programs might have to be modified accordingly. This task could
be time-consuming and expensive in the case of large programs unless
the dependence on the representation were to be confined by design to
a very few program modules.

For example, an alternate way to address the problem of reducing
rational numbers to lowest terms is to perform the reduction whenever
we access the parts of a rational number, rather than when we
construct it. This leads to different constructor and selector
functions:

```clojure
(defn make-rat [n d]
  (cons n d))

(defn numer [x]
  (let [g (gcd (car x) (cdr x))]
    (/ (car x) g)))

(defn denom [x]
  (let [g (gcd (car x) (cdr x))]
    (/ (cdr x) g)))

```

The difference between this implementation and the previous one lies
in when we compute the gcd. If in our typical use of rational numbers
we access the numerators and denominators of the same rational numbers
many times, it would be preferable to compute the gcd when the
rational numbers are constructed. If not, we may be better off waiting
until access time to compute the gcd . In any case, when we change
from one representation to the other, the functions `add-rat`,
`sub-rat` , and so on do not have to be modified at all.

Constraining the dependence on the representation to a few interface
functions helps us design programs as well as modify them, because it
allows us to maintain the flexibility to consider alternate
implementations. To continue with our simple example, suppose we are
designing a rational-number package and we can’t decide initially
whether to perform the `gcd` at construction time or at selection
time.  The data-abstraction methodology gives us a way to defer that
decision without losing the ability to make progress on the rest of
the system.
