### Everything from nothing

    > (cons 2 3)
    (2 . 3)

--

    > (define a (cons 2 3))

--

    > (car a)
    2

    > (cdr a)
    3

--

    > (define b (cons 3 a))
    > b
    (3 2 . 3)

--

    > (car b)
    3

--

    > (cdr b)
    (2 . 3)

--

    > (cdr (cdr b))
    3

---
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
