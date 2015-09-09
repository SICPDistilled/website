# Creating A Language Of Pictures
## How to describe Escher?

<img src="/images/SquareLimit500.jpg" width="450">

This section presents a simple language for drawing pictures that
illustrates the power of data abstraction and closure, and also
exploits higher-order functions in an essential way. The language is
designed to make it easy to experiment with patterns such as the ones
in the Escher picture above, which are composed of repeated elements
that are shifted and scaled. Just as cons , which satisfies the
closure property, allowed us to easily build arbitrarily complicated
list structure, the operations in this language, which also satisfy
the closure property, allow us to easily build arbitrarily complicated
patterns.

The picture language is based on the language Peter Henderson created
to construct images like M.C. Escher’s “Square Limit” woodcut (see
Henderson 1982)

## Our first picture
Here is our first picture, a stick man we will call George.

<img src="/images/1.png" width="400">

```clojure
(draw george)
```

We have used a function, `draw`, to draw the picture.

Now another picture, made using a function called `beside` that takes
two pictures and combines them left to right.

<img src="/images/2.png" width="500">

```clojure
(draw (beside george george))
```


<img src="/images/3.png" width="500">

```clojure
(draw (beside george (flip-horiz george)))
```

<img src="/images/4.png" width="500">

```clojure
(draw (above (beside george (flip-horiz george))
             (beside george (flip-horiz george))))
```

<img src="/images/5.png" width="500">

```clojure
(draw (rotate george))
```



# New pictures from old

Given that `above`, `beside` and `rotate` are functions that act on
pictures, we can make new functions that also act on pictures
ourselves.

```clojure
(defn rotate180 [p]
  (rotate (rotate p)))

(defn rotate270 [p]
  (rotate (rotate (rotate p))))

(defn above [p]
  ;; ...
  )
```

`above` is left as an exercise, see the [project](/section/project-escher)

We can even use recursive functions to draw more complex pictures:

## `right-split`

```clojure
(defn right-split [p n]
  (if (= n 0)
    p
    (let [smaller (right-split p (dec n))]
      (beside p (above smaller smaller)))))
```

<img src="/images/right-split.png" width="400">

<img src="/images/right-split-george.png" width="500">

```clojure
(draw (right-split george 4))
```



## `corner-split`

```clojure
(defn corner-split [p n]
  (if (= n 0)
    p
    (let [up (up-split p (dec n))
          right (right-split p (dec n))
          top-left (beside up up)
          bottom-right (above right right)
          top-right (corner-split p (dec n))]
      (beside (above top-left p)
              (above top-right bottom-right)))))
```

<img src="/images/corner-split.png" width="400">

<img src="/images/corner-split-george.png" width="500">

```clojure
(draw (corner-split george 4))
```

## `quartet`

```clojure
(defn quartet [p1 p2 p3 p4]
  (above (beside p1 p2)
         (beside p3 p4)))
```

<img src="/images/quartet.png" width="400">

```clojure
(draw (quartet george box man bruce))
```

# Higher Order Operations

In addition to abstracting patterns of combining pictures, we can work
at a higher level, abstracting patterns of combining picture
transforming operations.  That is, we can view the picture
transformations as elements to manipulate and can write means of
combination for these elements—functions that take picture
transformations as arguments and create new picture transformations.

```clojure
(defn square-of-four [tl tr
                      bl br]
  (fn [p]
    (let [top (beside (tl p) (tr p))
          bottom (beside (bl p) (br p))]
      (above top
             bottom))))
```

Takes 4 operations and returns a function of a picture that draws the
picture transformed by them, each in a quarter of the frame

```clojure
(draw ((square-of-four identity flip-vert
                       flip-horiz rotate)
       george))
```

<img src="/images/square-of-four.png" width="500">

# We still don't know how to draw anything!

We have thus far treated `draw` as a primitive function and `george`
as a primitive picture (whatever that means).

Before we get started: a note on [Quil](), a wonderful Clojure(script)
drawing library.

We instantiate a 'sketch' as follows, naming it `Escher` and setting
it's dimensions. It will call a function called `draw-image` to
update the picture.


```clojure
(q/defsketch escher
  :title "Escher"
  :draw draw-image
  :size [width height])
```

## Drawing lines

As we are using quil, we have functions for drawing lines on our sketch

```
quil.core/line ([p1 p2]
                [x1 y1 x2 y2]
                [x1 y1 z1 x2 y2 z2])

Draws a line (a direct path between two points) to the screen. The
version of line with four parameters draws the line in 2D.  ...

```

`quil/draw` can be used in a few different ways,
we will be mostly calling it with 2 points

## Vectors

Using destructuring and Clojures vector type we define functions to
add, subtract and 'scale' (ie increase the length of) vectors.

```clojure
(defn add-vec [[x1 y1] [x2 y2]]
  [(+ x1 x2) (+ y1 y2)])

(defn sub-vec [[x1 y1] [x2 y2]]
  ; ...
  )

(defn scale-vec [[x y] s]
  ; ...
  )
```

## Line segments

Are just pairs of vectors

```clojure
[[0 0] [1 1]]
```

## Paths

A path is a sequence of line segments

```clojure
(path [0 0] [1 1] [0 1] [0 0])
 => (([0 0] [1 1]) ([1 1] [0 1]) ([0 1] [0 0]))

(defn path [& veclist]
  ; ...
  )

```

# Data is code, Code is data

We have seen the line between code and data blur, most strongly with
the Church Numerals or with `cons`, `car` and `cdr` implemented as
functions, now we do a similar thing again.

*Our pictures are also functions*, more precisely:

<blockquote>A picture is a function that takes a "frame" as an argument and draws itself inside it.</blockquote>


## What is a frame?

A frame is a rectangle, described precisely by an origin vector and 2
of it's edge vectors.

<img src="/images/frame-diagram.png" width="400">

```clojure
{:origin [100 50]
 :e1     [300 100]
 :e2     [150 200]})
```


## Our first picture

This function is a picture, in that it takes a frame as an argument
and draws something within the frame. It actually draws 4 lines, one
along each edge of the frame.

```clojure
(defn frame-painter [{:keys [origin e1 e2]}]
  (let [corner (add-vec origin (add-vec e1 e2))]
    (draw-line origin (add-vec origin e1))
    (draw-line origin (add-vec origin e2))
    (draw-line (add-vec origin e2) corner)
    (draw-line (add-vec origin e1) corner)))

(def frame1 {:origin [200 50]
             :e1 [200 100]
             :e2 [150 200]})

(def frame2 {:origin [50 50]
             :e1 [100 0]
             :e2 [0 200]})
```

<img src="/images/frame.png" width="500">

```
(frame-painter frame1)
(frame-painter frame2)
```

You can see from using `frame-painter` on `frame1` and `frame2` what
the shape of the frames is. We will draw more interesting things on
them soon.

Note that the `[0,0]` for our drawing is in the top left corner, and
`y` increases downwards. This is standard for 2D canvases.

## Segment painter
This function takes a list of segments and returns a picture (which
remember is a function of a frame that draws things inside the frame).

This one is harder to understand:

Ignoring `frame-coord-map` for now, you can see it calls `draw-line`
for each segment in `segment-list` with a transformed `start` and
`end` (transformed by `m`, which is `(frame-coord-map frame)`)

```clojure
(defn segment-painter [segment-list]
  (fn [frame]
    (let [m (frame-coord-map frame)]
      (doseq [[start end] segment-list]
        (draw-line (m start) (m end))))))

(defn frame-coord-map
  [{:keys [origin e1 e2]}]
  (fn [[x y]]
    (add-vec origin
             (add-vec (scale-vec e1 x)
                      (scale-vec e2 y)))))
```

## What is `frame-coord-map` doing?

Take a look at the drawing below:

```clojure
(def diag (segment-painter [[[0 0] [1 1]]]))
(frame-painter frame1)
(frame-painter frame2)
(diag frame1)
(diag frame2)
```
<img src="/images/diag.png" width="500">

We have drawn `frame-painter` again for `frame1` and `frame2`, but we
have also drawn `diag` for each.

`diag` is a `segment-painter` for the segment `[[0 0] [1 1]]`

I hope this gives a clue to how `segment-painter` works, each segment
passed in should be within the 'unit square' (the square with corners
`[0,0]`, `[1,0]`, `[1,1]` and `[0,1]`) and each is scaled using
`frame-coord-map` to be within the frame, so that `[0,0]` is one
corner and `[1,1]` is the opposite corner.

## The `draw` function

So, we have pictures (which are functions of frames), but what exactly
was our `draw` function, that we treated as primitive for a while,
doing?

Simple, `draw` takes a picture and passes it a frame that is the whole
window (we `dec` `height` and `width` here because we want boxes etc
to draw on the outside edges)

```clojure
(def whole-window {:origin [0 0]
                   :e1 [(dec width) 0]
                   :e2 [0 (dec height)]})

(defn draw [picture]
  (picture whole-window))
```

# Making new pictures from old

```clojure
(defn transform-picture [p origin e1 e2]
  (fn [frame]
    (let [map (frame-coord-map frame)
          new-origin (map origin)]
      (p {:origin new-origin
          :e1 (sub-vec (map e1) new-origin)
          :e2 (sub-vec (map e2) new-origin)}))))
```

TODO: Describe `transform-picture`

## `flip-` and `rotate`
```clojure
(defn flip-vert [p]
  (transform-picture p [0 1] [1 1] [0 0]))

(defn flip-horiz [p]
  ; ...
  )

(defn rotate [p]
  ; ...
  )
```

## `beside` and `above`

```clojure
(defn beside [p1 p2]
  (let [split [0.5 0]
        left (transform-picture p1 [0 0] split [0 1])
        right (transform-picture p2 split [1 0] [0.5 1])]
    (fn [frame]
      (left frame)
      (right frame))))

(defn above [p1 p2]
  ; ...
)
```

# A different picture type

We used 4 pictures in the `quartet` example above: `george`, `box`,
`man` and `bruce`. Clearly `bruce` and `man` are not made up of line
segments like our pictures so far. They are made using Quil's
`load-image` function and a function called `image-painter` that you
have to complete as an exercise.

<img src="/images/bruce.png" width="400">

## Drawing it

```clojure
(def bruce (image-painter (q/load-image "data/bruce.jpg")))
(bruce frame1)
(bruce frame2)
```

<img src="/images/image.png" width="500">

## Exercise: image-painter

```
(defn image-painter [img]
  (fn [{[ox oy] :origin
        [e1x e1y] :e1
        [e2x e2y] :e2
        }]
    (let [width (.width img)
          height (.height img)]
      ; ...
      )))
```

See [the docs](http://quil.info/api/transform) for Quil transforms

## Saving images

Just call `q/save` inside the draw function to save an image

```clojure
(q/save "5.png")
```

## Square Limit
We have all we need to draw Square Limit now, it is just 4 of our
`corner-split`'s rotated and reflected and arranged as below with
`combine-four`

```
(def combine-four (square-of-four flip-horiz
                                  identity
                                  rotate180
                                  flip-vert))

(defn square-limit [p n]
  (combine-four (corner-split p n)))
```

### Bruce-Finity!

<img src="/images/square-limit-bruce.png" width="500">

```clojure
(draw (square-limit bruce 4))
```

### Angels

<img src="/images/square-limit-angels.png" width="500">

```clojure
(draw (square-limit angels 4))
```

# References
* Henderson's [wonderful paper](http://eprints.soton.ac.uk/257577/1/funcgeo2.pdf)
* [Frank Buss](http://www.frank-buss.de/lisp/functional.html) (You might want to use his tiles and do a line-segment square-limit
* [Escher In JS canvas](http://dl.acm.org/citation.cfm?id=1858597&dl=ACM&coll=DL)
* [Geomlab](http://www.cs.ox.ac.uk/geomlab/home.html) Great intro to FP for kids based on these ideas
* My [talk](https://skillsmatter.com/skillscasts/5488-escaping-dsl-hell-by-having-parenthesis-all-the-way-down) on DSLs (and my Geomlab in Clojure)
