# TwO-O-Player Math Game

## Description

A 2+ Player math game where players take turns to answer simple math addition
problems. A new math question is generated for each turn by picking two numbers
between 1 and 20. The player whose turn it is is prompted the question and must
answer correctly or lose a life.

---

## Details

Players start with 3 lives. They lose a life if they mis-answer a
question. At the end of every turn, the game should output the new scores for
players, so players know where they stand.

The game doesn’t end until one player is left standing. At this
point, the game should announce who won and what the other player’s score is.

---

## App planning

1. Extract nouns.
2. Write their roles.
3. Peer review.

### Example prompt

```
Player 1: What does 5 plus 3 equal?
> 9
Player 1: Seriously? No!
P1: 2/3 vs P2: 3/3
----- NEW TURN -----
Player 2: What does 2 plus 6 equal?
> 8
Player 2: YES! You are correct.
P1: 2/3 vs P2: 3/3
----- NEW TURN -----
... some time later ...
Player 1 wins with a score of 1/3
----- GAME OVER -----
Good bye!
```

### Extract nouns

Review the example output above, and extract nouns that could make for important
entities (classes) to encapsulate logic as part of this app.

- Player
- Game
- Round

### Write their roles

What is the role for each class?

**Game**

Stores information on the current game state, and manages the game loop.

- Properties: :players, :losers, :question, :answer
- Initialized with: none
- Methods:
  - continue_play?
  - correct?
  - find_winner
  - new_round
  - new_question
  - remove_losers
  - say_score
  - say_winner
  - score(player)
  - to_s

**Player**

Stores information on a player, and handles player life.

- Properties: :name, :initial_life, :life
- Initialized with: none
- Methods:
  - alive?
  - lose_a_life
  - to_s

**Question**

Creates and stores a random math question, and handles answer validation.

- Properties: :number_1, :number_2, :answer
- Initialized with: none
- Methods:
  - correct?,
  - give_question,
  - to_s
