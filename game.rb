class Game

  INITIAL_PLAYER_LIFE = 1

  def initialize
    puts ("TwO-O-Player Math Game")
    puts ("Challenge a friend to a math battle for the ages!")

    puts ("Enter P1 name:")
    player_1_name = gets.chomp
    
    puts ("Enter P2 name:")
    player_2_name = gets.chomp

    player_1 = Player.new(player_1_name, INITIAL_PLAYER_LIFE)
    player_2 = Player.new(player_2_name, INITIAL_PLAYER_LIFE)

    puts ("The names have been locked!")
    puts ("#{player_1.name} vs #{player_2.name}")

    question = Question.new
    puts ("Player 1: #{question.ask}")
    player_answer = gets.chomp.to_i
    
    correct = question.correct?(player_answer)
    if !correct
      player_1.lose_a_life
      puts ("Seriously? No!")
    else
      puts ("YES! You are correct.")
    end

    continue_playing = player_1.alive? && player_2.alive?
    if continue_playing
      puts ("P1: #{player_1.say_score} vs P2: #{player_2.say_score}")
      puts ("----- NEW TURN -----")
    else
      if player_1.life === player_2.life
        puts ("Gameplay ends with a score of P1: #{player_1.say_score} vs P2: #{player_2.say_score}")
      elsif player_1.life > player_2.life
        puts ("Player 1 wins with a score of #{player_1.say_score}")
      else
        puts ("Player 2 wins with a score of #{player_2.say_score}")
      end
      puts ("----- GAME OVER -----")
      puts ("Good bye!")
    end

  end

  def to_s
    "I'm a Game"
  end
end
