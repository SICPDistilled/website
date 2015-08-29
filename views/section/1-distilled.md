# Outline of the Chapter
This chapter is all about pure functions of numbers, it introduces the
idea of *recursive* and *iterative* procedures and talks a bit about
space and time complexity of algorithms (so-called *big-O* notation)

It develops a model for evaluating Clojure expressions that suffices
as long as we have only *pure functions*

Most importantly it introduces the idea of *first class* elements in a
programming language and uses the fact that Clojure has first class
functions. Higher Order Functions is one of the main ideas in the book.

# What changed

SICP is very careful to always refer to *procedures* in programs and
reserves *function* for mathematical functions. I took the decision
(though was very conflicted) of saying *functions*, *mathematical
functions* and saying *pure functions* if
[referential transparency](https://en.wikipedia.org/wiki/Referential_transparency_(computer_science))
is significant in the context.

I think terms like *first class functions*, *higher order functions*
etc are in common enough use that it is better to use them. This may
change and I am interested to know what you think.

# What got left out

Sections 1.1 and 1.2 are mostly complete, if I can think of a
different example to replace Newtons Method I may well do it.

Section 1.3 I found the examples a bit contrived to stay within the
constraint of having not yet introduced data structures so skipped
lots of the examples (the coin counting one for instance makes much
more sense with a collection of coins)

# What was added
I took the Blackjack exercise from the [projects](https://mitpress.mit.edu/sicp/psets/) page

# Other resources

If you want to really understand recursion, check
out [The Litte Schemer](http://amzn.to/1hIHKIS) (it goes on to things
that appear later in the presentation here too)
