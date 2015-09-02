Chapter 1 - Building Abstractions with Procedures
-------------------------------------------------

<blockquote>The acts of the mind, wherein it exerts its power over simple ideas,
are chiefly these three: 1. Combining several simple ideas into one
compound one, and thus all complex ideas are made. 2. The second is
bringing two ideas, whether simple or complex, together, and setting
them by one another so as to take a view of them at once, without
uniting them into one, by which it gets all its ideas of relations.
3. The third is separating them from all other ideas that accompany
them in their real existence: this is called abstraction, and thus all
its general ideas are made.
<cite>John Locke, An Essay Concerning Human Understanding (1690)</cite>
</blockquote>

We are about to study the idea of a *computational process*.
Computational processes are abstract beings that inhabit computers. As
they evolve, processes manipulate other abstract things called *data*.
The evolution of a process is directed by a pattern of rules called a
*program*. People create programs to direct processes. In effect, we
conjure the spirits of the computer with our spells.

A computational process is indeed much like a sorcerer’s idea of a
spirit. It cannot be seen or touched. It is not composed of matter at
all. However, it is very real. It can perform intellectual work. It can
answer questions. It can affect the world by disbursing money at a bank
or by controlling a robot arm in a factory. The programs we use to
conjure processes are like a sorcerer’s spells. They are carefully
composed from symbolic expressions in arcane and esoteric *programming
languages* that prescribe the tasks we want our processes to perform.

A computational process, in a correctly working computer, executes
programs precisely and accurately. Thus, like the sorcerer’s apprentice,
novice programmers must learn to understand and to anticipate the
consequences of their conjuring. Even small errors (usually called
*bugs* or *glitches*) in programs can have complex and unanticipated
consequences.

Fortunately, learning to program is considerably less dangerous than
learning sorcery, because the spirits we deal with are conveniently
contained in a secure way. Real-world programming, however, requires
care, expertise, and wisdom. A small bug in a computer-aided design
program, for example, can lead to the catastrophic collapse of an
airplane or a dam or the self-destruction of an industrial robot.

Master software engineers have the ability to organize programs so
that they can be reasonably sure that the resulting processes will
perform the tasks intended. They can visualize the behavior of their
systems in advance. They know how to structure programs so that
unanticipated problems do not lead to catastrophic consequences, and
when problems do arise, they can *debug* their programs. Well-designed
computational systems, like well-designed automobiles or nuclear
reactors, are designed in a modular manner, so that the parts can be
constructed, replaced, and debugged separately.

## Programming in Lisp

We need an appropriate language for describing processes, and we will
use for this purpose the programming language Lisp. Just as our
everyday thoughts are usually expressed in our natural language (such
as English, French, or Japanese), and descriptions of quantitative
phenomena are expressed with mathematical notations, our procedural
thoughts will be expressed in Lisp. Lisp was invented in the late
1950s as a formalism for reasoning about the use of certain kinds of
logical expressions, called *recursion equations*, as a model for
computation. The language was conceived by John McCarthy and is based
on his paper “Recursive Functions of Symbolic Expressions and Their
Computation by Machine”
[McCarthy 1960](http://www-formal.stanford.edu/jmc/recursive.pdf)

Despite its inception as a mathematical formalism, Lisp is a practical
programming language. A Lisp *interpreter* is a machine that carries
out processes described in the Lisp language. The first Lisp
interpreter was implemented by McCarthy with the help of colleagues
and students in the Artificial Intelligence Group of the MIT Research
Laboratory of Electronics and in the MIT Computation Center. Lisp,
whose name is an acronym for LISt Processing, was designed to provide
symbol-manipulating capabilities for attacking programming problems
such as the symbolic differentiation and integration of algebraic
expressions. It included for this purpose new data objects known as
atoms and lists, which most strikingly set it apart from all other
languages of the period.

Lisp was not the product of a concerted design effort. Instead, it
evolved informally in an experimental manner in response to users’ needs
and to pragmatic implementation considerations. Lisp’s informal
evolution has continued through the years, and the community of Lisp
users has traditionally resisted attempts to promulgate any “official”
definition of the language. This evolution, together with the
flexibility and elegance of the initial conception, has enabled Lisp,
which is the second oldest language in widespread use today (only
Fortran is older), to continually adapt to encompass the most modern
ideas about program design. Thus, Lisp is by now a family of dialects,
which, while sharing most of the original features, may differ from one
another in significant ways. The dialect of Lisp used in this book is
called Clojure

Because of its experimental character and its emphasis on symbol
manipulation, Lisp was at first very inefficient for numerical
computations, at least in comparison with Fortran. Over the years,
however, Lisp compilers have been developed that translate programs into
machine code that can perform numerical computations reasonably
efficiently. And for special applications, Lisp has been used with great
effectiveness.[^3^](#FOOT3) Although Lisp has not yet overcome its old
reputation as hopelessly inefficient, Lisp is now used in many
applications where efficiency is not the central concern. For example,
Lisp has become a language of choice for operating-system shell
languages and for extension languages for editors and computer-aided
design systems.

If Lisp is not a mainstream language, why are we using it as the
framework for our discussion of programming? Because the language
possesses unique features that make it an excellent medium for
studying important programming constructs and data structures and for
relating them to the linguistic features that support them. The most
significant of these features is the fact that Lisp descriptions of
processes, called *functions*, can themselves be represented and
manipulated as Lisp data. The importance of this is that there are
powerful program-design techniques that rely on the ability to blur
the traditional distinction between “passive” data and “active”
processes.  As we shall discover, Lisp’s flexibility in handling
functions as data makes it one of the most convenient languages in
existence for exploring these techniques. The ability to represent
functions as data also makes Lisp an excellent language for writing
programs that must manipulate other programs as data, such as the
interpreters and compilers that support computer languages. Above and
beyond these considerations, programming in Lisp is great fun.
