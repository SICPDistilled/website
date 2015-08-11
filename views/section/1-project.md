# blackjack
Checkout the project from [Github]()

Join the chat at [![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/SICPDistilled/blackjack?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

Testing your understanding of higher order functions by creating strategys for [Blackjack](https://en.wikipedia.org/wiki/Blackjack) (also called Pontoon or 21)

We are going to build an increasingly complex model of playing Blackjack alongside strategys to play the game

## Starting out
### A simple model for the deck
We begin with a very simple model of both cards and the deck, we assume that they take a value from 1-10 and anything is equally likely, we can get a new card by calling `deal`

```clojure
(defn deal []
  (inc (rand-int 10)))
```

### Modelling hands
See the simple-hand namespace:
If a hand is a vector of numbers, we can make a new hand by defining

```clojure
(defn new-hand [] [(deal)])
```

and have the following helper functions to deal with them

```clojure
(defn up-card [hand]
  (first hand))

(defn add-card [hand card]
  (conj hand card))

(defn total [hand]
  (reduce + hand))
```

### Strategies
We will model a strategy as a procedure of the current hand and the dealers 'up card' (which a decent strategy will take into account) that returns true or false if it decides to 'hit'.

Take a look at the `play-game` procedure: it takes 2 strategies, for the player and dealer then uses `play-hand` to play the players hand and then (if the player didnt bust), plays the dealers hand. It returns 1 if the player wins and 0 if she loses.

The `play-hand` procedure takes a strategy, a hand (list of cards) and the visible card of the opponent, it always returns a hand and will stop if either

* the strategy decides to stop

or

* the player goes bust

otherwise it takes a card and recurs

### For you to complete
#### 'Stop at 17'
Write a strategy called `stop-at-17`
It should hit for as long as the hand is worth (strictly) less than 17

#### Test strategies
Write a procedure that takes a `player-strategy` a `house-strategy` and a number `n` of games to play and returns how many the player won that lets you know what fraction of the games was won by the player

(when I did it `(test-strategy stop-at-17 stop-at-17 100000)` was about 0.41)

#### 'Stop at n'
Write a procedure called `stop-at-n` that takes a number and returns a strategy that will stop when it gets higher than that number (so `stop-at-17` should be 'the same' as `(stop-at-n 17)`)

#### 'Watched'
Write a procedure called `watched` that takes a strategy and returns a strategy that behaves the same way only also prints (as a side-effect) the arguments it was called with (hand and up-card) and the decision to hit or not

#### Taking into account the dealers hand
Take a look at [Basic Strategy](https://en.wikipedia.org/wiki/Blackjack#Basic_strategy) in the Wikipedia Article

You can see that if we take into account the dealers hand that you should stop at 13 if their card is 6 or less, write a strategy that does this (maybe you can use other strategies you have created)

#### Majority
Write a procedure that takes a list of strategies and hits if a majority say they should hit. (think about what to do if the size of the list is even and there is a tie)

#### Just one more
Write a procedure that takes a strategy and returns a strategy that always stops one card later than the original

## License
Copyright © 2015 Tom Hall
