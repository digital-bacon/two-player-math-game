class Game
  attr_reader = :players, :question, :answer

  INITIAL_PLAYER_LIFE = 1

  def initialize
    @players = []
    puts ("TwO-O-Player Math Game")
    puts ("Challenge a friend to a math battle for the ages!")

    puts ("Enter P1 name:")
    player_1_name = gets.chomp
    
    puts ("Enter P2 name:")
    player_2_name = gets.chomp

    player_1 = Player.new(player_1_name, INITIAL_PLAYER_LIFE)
    player_2 = Player.new(player_2_name, INITIAL_PLAYER_LIFE)
    @players << player_1 
    @players << player_2
    @current_player = 0

    puts ("The names have been locked!")
    message = ""
    total_players = @players.length
    @players.each_with_index do |player, current|
      message += "#{player.name}"
      if (current + 1) < total_players
        message += " vs "
      end
    end
    puts message
    
    self.new_round(0)
    self.new_round(1)
  end

  private

  def new_round(player_number)
    @current_player = @players[player_number]
    new_question
    ask_question(@current_player.name)

    if correct?
      puts ("YES! You are correct.")
    else
      @current_player.lose_a_life
      puts ("Seriously? No!")
    end
    
    if continue?
      say_score
      puts ("----- NEW TURN -----")
    else
      say_winner
      puts ("----- GAME OVER -----")
      puts ("Good bye!")
    end
  end 

  def new_question
    @question = Question.new
  end

  def ask_question(name)
    puts ("#{name}: #{@question.ask}")
    @answer = gets.chomp.to_i
  end

  def correct?
    @question.correct?(@answer)
  end

  def continue?
    @players.each do |player|
      if !player.alive?
        return false
      end
    end
    return true
  end

  def say_score
    message = ""
    total_players = @players.length
    @players.each_with_index do |player, current|
      message += "#{player.name}: #{player.say_score}"
      if (current + 1) < total_players
        message += " vs "
      end
    end
    puts message
  end

  # def tied?
  #   score = @players[0].life
  #   @players.each do |player|
  #     if player.life !== score
  #       return false
  #     end
  #   end
  #   return true
  # end

  def find_winner
    score = 0
    winner = nil
    @players.each do |player|
      if player.life > score
        score = player.life
        winner = player
      end
    end
    return winner
  end

  def say_winner
    winner = find_winner
    if winner
      puts ("#{winner.name} wins with a score of #{winner.say_score}")
    else
      puts ("There was no winner")
    end
  end

  def to_s
    "I'm a Game"
  end
end