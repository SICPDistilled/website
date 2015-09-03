# Chapter 2 Distilled

## Outline of the Chapter

This chapter in SICP introduces `cons` cells as a way of combining
data objects to form *compound data*, uses them to build lots of
different data structures and talks about *data abstraction*

We stick with the books presentation at first, working through the
rational number example with `cons`, `car` and `cdr`.

Then we learn about Clojure's datatypes and reimplement rationals
using them. We mostly use them from then on (sometimes summarising the
books approach in contrast).

## What changed

The book builds up data structures from `cons` cells it uses them
throughout the book. It is good in the sense you have a minimal set of
primitives and build everything from them. However, if you have used
another programming language you probably expect lots of
datastructures to be built in. Clojure is particularly nice here
compared to the Scheme in the book, having lots of data structures, a
literal syntax for most of them, and immutability.

I think having to roll-your-own datastructures clouds the description
of more complex topics like the interpreter, the presentation here
gains a lot from relying on Clojure maps to represent environments for
example.

## Was was left out

I find the extended exercise on interval arithmetic boring so left it
out. Despite enjoying it myself and it prefiguring the interpreter in
Ch4 somewhat I have (at least for now) left out the Symbolic
Differentiation example as I think the 'one has to learn calculus to
do SICP' meme is not helpful.

## What was added

I make a bit more of a fuss about Church Numerals as I think it is a
wonderful *a-ha* moment potentially buried in the questions.

Obviously talking about Clojure's built-in data types is different and
I think it clarifies the presentation of sets and coding.
