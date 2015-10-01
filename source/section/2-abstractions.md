# Abstractions in Clojure

<blockquote>It is better to have 100 functions operate on one data structure than
10 functions on 10 data structures.
<cite>Alan J. Perlis - Forward</cite>
</blockquote>

We have seen in the section on [Data Abstraction]() the only data
structure used in the original SICP, the `cons` cell (and I hinted
that Clojure provides us with more choices, we will see them soon).

A way of representing the list structured data created by `cons` is
the *box-and-pointer diagram*. The box for a primitive object contains
a representation of the object. For example, the box for a number
contains a numeral. The box for a pair is actually a double box, the
left part containing (a pointer to) the car of the pair and the right
part containing the cdr.

<img src="/images/fig2.3.png">

Above is a few different ways to combine 1,2,3,4 using `cons`

A very common pattern is the sequence (an ordered collection of data
objects), the usual way to do this with `cons` is depicted below

<img src="/images/fig2.4.png">

```
> (cons 1
        (cons 2
              (cons 3
                    (cons 4
                          nil))))
(1 2 3 4)
```

See, the chain of `cons`'s is represented in the REPL as a *list*. You
have of course seen lists already, expressions are made of them.

We can create lists using the `list` function, and can `cons` things
onto the beginning of existing lists.

```
> (def l1 (list 1 2 3 4))

> l1
(1 2 3 4)

> (cons 5 l1)
(5 1 2 3 4)
```

Be careful not to confuse the expression `(list 1 2 3 4)` with the
list `(1 2 3 4)` , which is the result obtained when the expression is
evaluated. Attempting to evaluate the expression (1 2 3 4) will signal
an error when the interpreter tries to apply the procedure 1 to
arguments 2, 3, and 4.


## A note on Clojures `cons`

In [Data Abstraction]() we spoke about `cons` `car` and `cdr` as they
are defined in SICP, and saw how we could implement them as
functions. The above examples do work in Clojure, but some of the
things we did earlier will not:

```clojure
> (cons 1 2)

IllegalArgumentException Don't know how to create ISeq from:
    java.lang.Long clojure.lang.RT.seqFrom (RT.java:505)

```

This confusing error message is because `cons` in clojure is only for
working with lists, the second argument must be a list. The reference
to `ISeq` mean that `2` is not the correct type for `cons`, it is
expecting a *sequence*.

## The Sequence Abstraction

Given a sequence, you can use `first` to get the first element and
`rest` to get the sequence without the first element

```clojure
> (def l (list 1 2 3 4))
> l
(1 2 3 4)

> (first l)
1

> (rest l)
(2 3 4)
```

`first` and `rest` are the equivalent of `car` and `cdr` for lists.
