---
title: Welcome to SICP Distilled
---

# SICP Distilled
### An idiosyncratic tour of SICP in Clojure

I notice lots of you are coming via Hacker News, I also did a
[blog post](http://www.thattommyhall.com/2015/09/06/sicp-distilled-now-public/)
about the status of the project (I should have probably written that
here but you should read it to see where I am with the project)

## SICP?

<blockquote><b>Wizard Book n.</b>
<br>
Hal Abelson's, Jerry Sussman's and Julie Sussman's Structure and
Interpretation of Computer Programs, an excellent computer science
text used in introductory courses at MIT. So called because of the
wizard on the jacket. One of the bibles of the LISP/Scheme world.
<cite>The New Hacker's Dictionary</cite></blockquote>

It is a great introduction to computation, Peter Norvig probably
[said it best](http://www.amazon.com/review/R403HR4VL71K8/):

>To use an analogy, if SICP were about automobiles, it would be for
>the person who wants to know how cars work, how they are built, and
>how one might design fuel-efficient, safe, reliable vehicles for the
>21st century. The people who hate SICP are the ones who just want to
>know how to drive their car on the highway, just like everyone else.

I was going to write more about why one should study SICP, but Kai Wu
did a stellar job
[here](https://archive.is/uTOol#selection-839.0-880.0)

## Distilled?

Abelson and Sussman themselves highlight the important lessons of SICP
in their paper
[Lisp: A Language For Stratified Design](http://dspace.mit.edu/bitstream/handle/1721.1/6064/AIM-986.pdf?sequence=2)
and I have my own favourite bits.

It’s a long book, with lots of exercises and lots of people I know
have started, loved it, but somehow not finished.

Taking a look at viewing figures for the original authors
[1986 recordings](https://www.youtube.com/playlist?list=PLE18841CABEA24090)
of a version of the course. The first one is 700k, the second 55k and
the last only 12k. I personally think the videos are excellent and
worth looking over alongside the treatment here, Abelson and Sussman
are excellent teachers and the necessity of writing out the code on
the blackboard and fitting into 20 roughly hour long sessions is a
'distillation' in itself.

As the book itself is available
[online for free](http://sicpebook.wordpress.com/) under a Creative
Commons licence, I have incorporated lots of the original text so you
still hear their voices (most directly in the introductions to each
chapter)

Some ideas come out a little different in Clojure, or I take a
slightly novel approach (hence idiosyncratic), maybe I miss something
out (hence tour, sorry), but I hope you have some fun along the way.

## Why Clojure?

* A modern take on Lisp
* Slightly less parens (though obviously you will come to love them anyway)
* More immutability! (SICP gets as far as possible without mutation
  and quite rightly warns you to be careful when you start)
* Target the JVM or Javascript, and use their libraries
* An [excellent parser library](https://github.com/Engelberg/instaparse)
* A more fully featured [logic engine](https://github.com/clojure/core.logic) for us to peek at
* Different concurrency models

## What will you do if you read this?

* Come to appreciate and use higher order functions
* Build everything from (almost) nothing
* Deeply embed DSLs into Clojure
* Draw Escher pictures
* Create datastructures
* Learn why [reduce is considered harmful](http://vimeo.com/6624203)
  (not SICP but I have some fun exercises planned)
* understand iteration and recursion
* Build a Lisp interpreter (or a mini version of your other favourite
  language)
* Make a compiler
* Do some logic programming

## Who am I?

My name is Tom Hall, I am [@thattommyhall](https://twitter.com/thattommyhall) on twitter and blog over
at [thattommyhall.com](http://www.thattommyhall.com)
