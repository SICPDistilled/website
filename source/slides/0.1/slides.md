<img src="me.png" width="800">

---
# SICP Distilled
## An idiosyncratic tour of the best of Structure and Interpretation of Computer Programs in Clojure

* Distilled?
* Idiosyncratic?
* Tour?

---
# Why Study SICP?

<blockquote>
"To use an analogy, if SICP were about automobiles, it would be for the person who wants to know how cars work, how they are built, and how one might design fuel-efficient, safe, reliable vehicles for the 21st century. The people who hate SICP are the ones who just want to know how to drive their car on the highway, just like everyone else."
<cite>Peter Norvig</cite>
</blockquote>


---
# What is it *not* about?

* A particular programming language
* Clever or efficient Algorithms
* Mathematical analysis of algorithms

---
# What is it about?

* Computation
* Techniques to control complexity

---
<img src="microscope.jpg" height="600">

---
# Why in Clojure?

* A modern take on Lisp
* Slightly less parens (though obviously you will come to love them anyway)
* More immutability! (SICP gets as far as possible without mutation and quite rightly warns you to be careful when you start)
* Target JVM or Javascript, and use their libraries
* An excellent parser library in Instaparse
* A more fully featured logic engine for us to peek at in core.logic
* Different concurrency models

---
# WWRHD?

<blockquote>
<b>I don't think SICP is a book about a programming language. It's a book
about programming</b>. It uses Scheme because Scheme is in many ways an
atomic programming language. Lambda calculus + TCO for loops +
Continuations for control abstraction + syntactic abstraction (macros)
+ mutable state for when you need it. It is very small. It is
sufficient.

The book really deals with the issues in programming. Modularity,
abstraction, state, data structures, concurrency etc. It provides
descriptions and toy implementations of generic dispatch, objects,
concurrency, lazy lists, (mutable) data structures, 'tagging' etc,
designed to illuminate the issues.

Clojure is not an atomic programming language. I'm too tired/old/lazy
to program with atoms. <b>Clojure provides production implementations of
generic dispatch, associative maps, metadata, concurrency
infrastructure, persistent data structures, lazy seqs, polymorphic
libraries etc etc. Much better implementations of some of the things
you would be building by following along with SICP are in Clojure
already.</b>
<cite>Rich Hickey</cite>
</blockquote>

---
<blockquote>
<b>So the value in SICP would be in helping you understand programming
concepts</b>. If you already understand the concepts, Clojure lets you get
on with writing interesting and robust programs much more quickly,
IMO. And I don't think the core of Clojure is appreciably bigger than
Scheme's

<b>I think the Lisps prior to Clojure lead you towards a good path with
functional programming and lists, only to leave you high and dry when
it comes to the suite of data structures you need to write real
programs, such data structures, when provided, being mutable and
imperative</b>. Prior Lisps were also designed before pervasive in-process
concurrency, and before the value of high-performance polymorphic
dispatch (e.g. virtual functions) as library infrastructure was well
understood. Their libraries have decidedly limited polymorphism.

...

Learning Scheme or Common Lisp on your way to Clojure is fine. There
will be specifics that don't translate (from Scheme - no TCO, false/
nil/() differences, no continuations; from CL - Lisp-1, symbol/var
dichotomy). But I personally don't think SICP will help you much with
Clojure. YMMV.
<cite>Rich Hickey</cite>
</blockquote>

---
# The Shape of The Book

--

## Ch1 - Building Abstractions With Processes

--

## Ch2 - Building Abstractions With Data

--

## Ch3 - Modularity, Objects And State

--

## Ch4 - Metalinguistic Abstraction

--

## Ch5 - Computing With Register Machines


---
### Ch1/2
* Escher
* 21
* Numbers
* Big O

### Ch4
* interpreter
* python
* logic

### Ch3
* Add assignment to our interpretor and do it in that

### Ch5
* LLVM Compiler?
