# TwO-O-Player Math Game

## Description

A 2-Player math game where players take turns to answer simple math addition
problems. A new math question is generated for each turn by picking two numbers
between 1 and 20. The player whose turn it is is prompted the question and must
answer correctly or lose a life.

---

## Details

Both players start with 3 lives. They lose a life if they mis-answer a
question. At the end of every turn, the game should output the new scores for
both players, so players know where they stand.

The game doesn’t end until one of the players loses all their lives. At this
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

Stores information on the current game state including references to player
classes, and who the current player is. It contains methods to say a message
when an answer is correct/incorrect. It also contains a method, new_round,
which is called to create a question, prompt a player for a response, validate
the response, manage player life if the response is incorrect, end the game
if a player is out of lives, and say_correct, say_incorrect, or say_game_over
as required. The method named to_s is used for troubleshooting and outputs a
string to identify the class.

- Properties: player_1, player_2, current_player
- Initialized with:
- Methods: new_round, say_correct, say_incorrect, say_game_over, to_s

**Player**

Stores information on a player, and handles player life. The method named to_s
is used for troubleshooting and outputs a string to identify the class.

- Properties: name, life
- Initialized with: name
- Methods: set_name, current_life, lose_a_life, alive?, to_s

**Question**

Generates a random math question with method new_question and stores the answer
in the answer variable. It also contains a method to check if an answer is
correct. The method named to_s is used for troubleshooting and outputs a string
to identify the class.

- Properties: number_one, number_two, answer
- Initialized with:
- Public methods: new_question, correct_answer?, to_s
