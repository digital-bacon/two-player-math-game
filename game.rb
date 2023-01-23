class Game
  def initialize
    puts ("TwO-O-Player Math Game")
    puts ("Challenge a friend to a math battle for the ages!")

    puts ("Enter P1 name:")
    player_1_name = gets.chomp
    
    puts ("Enter P2 name:")
    player_2_name = gets.chomp

    player_1 = Player.new (player_1_name)
    player_2 = Player.new (player_2_name)

    puts ("The names have been locked!")
    puts ("#{player_1.name} vs #{player_2.name}")

    question = Question.new
    puts ("Player 1: #{question.ask}")
    player_answer = gets.chomp.to_i
    puts question.correct?(player_answer)
  end

  def to_s
    "I'm a Game"
  end
end
