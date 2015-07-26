# Halting Problem
(Ex 4.15 in the book)

Given a one-argument procedure `p` and an object `a` , `p` is said to “halt” on `a` if evaluating the expression `(p a)` returns a value (as opposed to terminating with an error message or running forever).

Can you see it is impossible to write a procedure `halts?` that correctly determines whether `p` halts on `a` for any procedure `p` and object `a` .

If you had such a procedure, you could implement:

```clojure
(defn run-forever
  (run-forever))

(defn (try p)
  (if (halts? p p)
  (run-forever)
  'halted))
```

and now think about running `(try try)` and show that any possible outcome (either halting or running forever) violates the intended behaviour of `halts?`

Although we stipulated that halts? is given a procedure object, notice that this reasoning still applies even if halts? can gain access to the procedure’s text and its environment. This is Turing’s celebrated Halting Theorem, which gave the first clear example of a non-computable problem, i.e., a well-posed task that cannot be carried out as a computational procedure.
