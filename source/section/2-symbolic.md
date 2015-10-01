# Symbolic Data

All the compound data objects we have used so far were constructed
ultimately from numbers. In this section we extend the
representational capability of our language by introducing the ability
to work with arbitrary symbols as data.

## Quotation

If we can form compound data using symbols, we can have lists such as

```nohighlight
(a b c d)

(23 45 17)

((Norah 12) (Molly 9) (Anna 7) (Lauren 6) (Charlotte 4))
```

Lists containing symbols can look just like the expressions of our
language:

```nohighlight
(* (+ 23 45)

(+ x 9))

(defn fact [n]
  (if (= n 1) 1 (* n (fact (- n 1)))))
```

In order to manipulate symbols we need a new element in our language:
the ability to *quote* a data object. Suppose we want to construct the
list `(a b)` . We can’t accomplish this with `(list a b)` , because
this expression constructs a list of the *values* of a and b rather
than the symbols themselves. This issue is well known in the context
of natural languages, where words and sentences may be regarded either
as semantic entities or as character strings (syntactic entities). The
common practice in natural languages is to use quotation marks to
indicate that a word or a sentence is to be treated literally as a
string of characters. For instance, the first letter of “John” is
clearly “J.” If we tell somebody “say your name aloud,” we expect to
hear that person’s name. However, if we tell somebody “say ‘your name’
aloud,” we expect to hear the words “your name.” Note that we are
forced to nest quotation marks to describe what somebody else might
say.

We can follow this same practice to identify lists and symbols that
are to be treated as data objects rather than as expressions to be
evaluated. However, our format for quoting differs from that of
natural languages in that we place a quotation mark (traditionally,
the single quote symbol `'`) only at the beginning of the object to be
quoted. We can get away with this in Scheme syntax because we rely on
blanks and parentheses to delimit objects. Thus, the meaning of the
single quote character is to quote the next object

Now we can distinguish between symbols and their values:

```nohighlight
> (def a 1)
> (def b 2)

> (list a b)
(1 2)

> (list 'a 'b)
(a b)

> (list 'a b)
(a 2)
```

`'` allows us to type in compound objects, using the
conventional printed representation for lists:

```nohighlight
> (first '(a b c))
a

> (rest '(a b c))
(b c)
```

## Reader Macros

The use of the quotation mark here violates the general rule that all
compound expressions in our language should be delimited by
parentheses and look like lists. We can recover this consistency by
introducing a special form `quote`, which serves the same purpose as
the quotation mark. Thus, we would type `(quote a)` instead of `'a` ,
and we would type `(quote (a b c))` instead of `'(a b c)`.

The quotation mark is just a single-character abbreviation for
wrapping the next complete expression with quote to form `(quote
⟨exp⟩)`.

This is important because it maintains the principle that any
expression seen by the interpreter can be manipulated as a data
object. For instance, we could construct the expression


```nohighlight
(first '(a b c))
```

which is the same as

```nohighlight
(first (quote (a b c)))
```

by evaluating

```nohighlight
(list 'first (list 'quote '(a b c)))
```

## The Empty List

We can obtain the empty list by evaluating `'()`, hence we can do.

```nohighlight
> (cons 1
        (cons 2
              (cons 3 '())))
(1 2 3)
```

## Equality

One additional primitive in Clojure is `=`, which
takes two arguments and tests whether they are the same.

Using `=`, we can implement a useful procedure called `memq`. This
takes two arguments, a symbol and a list. If the symbol is not
contained in the list (i.e., is not = to any item in the list), then
memq returns false. Otherwise, it returns the sublist of the list
beginning with the first occurrence of the symbol:

```nohighlight
(defn memq [item x]
  (cond (empty? x) false
        (= item (first x)) x
        :else (memq item (rest x))))
```

For example:

```nohighlight
> (memq 'apple '(pear banana prune))
false
```

```nohighlight
> (memq 'apple '(x (apple sauce) y apple pear))
(apple pear)
```

### Exercise 2.53:

What would the interpreter print in response
to evaluating each of the following expressions?

```nohighlight
(list 'a 'b 'c)

(list (list 'george))

(rest '((x1 x2) (y1 y2)))

(list? (first '(a short list)))

(memq 'red '((red shoes) (blue socks)))

(memq 'red '(red shoes blue socks))
```

### Exercise 2.54:

Two lists are said to be equal? if they contain equal elements
arranged in the same order. For example,

```
(equal? '(this is a list) '(this is a list))
```

is true, but

```nohighlight
(equal? '(this is a list) '(this (is a) list))
```

is false. To be more precise, we can define equal? recursively in
terms of the basic `=` equality of symbols by saying that a and b are
equal? if they are both symbols and the symbols are eq? , or if they
are both lists such that `(first a)` is `equal?` to `(first b)` and `(rest
a)` is `equal?` to `(rest b)` .

Using this idea, implement equal? as a procedure

### Exercise 2.55

Eva Lu Ator types to the interpreter the expression

```nohighlight
(first ''abracadabra)
```

To her surprise, the interpreter prints back `quote` why?
