class Game
  attr_reader = :players, :losers, :question, :answer

  GAME_NAME = "TwO-O-Player Math Game"
  WELCOME_MESSAGE = "Challenge a friend to a math battle for the ages!\n\n"
  INITIAL_PLAYER_LIFE = 3

  def initialize
    puts ("~~~~~~~~~~~~~~~~~~~~~~")
    puts (GAME_NAME)
    puts ("~~~~~~~~~~~~~~~~~~~~~~")
    puts (WELCOME_MESSAGE)
    
    puts ("How many are playing?")
    total_players = gets.chomp.to_i
    total_players = 2 if total_players < 2
    
    # Generate the players
    @players = []
    @losers = []

    1.upto(total_players) { |count|
      puts ("Enter P#{count} name:")
      name = gets.chomp
      player = Player.new(name, INITIAL_PLAYER_LIFE)
      @players << player
    }

    puts ("Player names have been locked!")

    # Announce the players
    message = ""
    @players.each_with_index do |player, current|
      message += "#{player.name}"
      end_of_list = (current + 1) >= total_players
      message += " vs " unless end_of_list
    end
    puts message
    
    # Shuffle players and initialize game loop
    @players.shuffle!
    play_game = true
    remaining_players = total_players
    first_player = 0
    this_player = 0
    puts ("----- GAME START -----")
    until remaining_players <= 1 do
      this_player = first_player if remaining_players <= this_player
      @current_player = @players[this_player]
      self.new_round
      remaining_players = @players.length
      this_player += 1
    end
  end

  private

  def new_round
    new_question
    ask_question(@current_player.name)

    if correct?
      puts ("YES! You are correct.") if correct?
    else
      @current_player.lose_a_life
      puts ("Seriously? No!")
    end
    
    remove_losers

    if continue_play?
      say_score
      puts ("----- NEW TURN -----")
      return true
    else
      say_winner
      puts ("----- GAME OVER -----")
      puts ("Good bye!")
    end

    return false
  end 

  def new_question
    @question = Question.new
  end

  def ask_question(name)
    puts ("#{name}: #{@question.give_question}")
    @answer = gets.chomp.to_i
  end

  def correct?
    @question.correct?(@answer)
  end

  def continue_play?
    return @players.length >= 2
  end

  def score(player)
    "#{player.life}/#{INITIAL_PLAYER_LIFE}"
  end

  def remove_losers
    @players.each_with_index do |player, index|
      unless player.alive?
        @losers << player
        @players.delete_at(index)
        puts ("It's game over for #{player.name}. So sad!")
      end
    end
  end

  def say_score
    message = ""
    total_players = @players.length
    @players.each_with_index do |player, current|
      message += "#{player.name}: #{score(player)}"
      end_of_list = (current + 1) >= total_players
      message += " vs " unless end_of_list
    end
    puts message
  end

  def say_winner
    winner = @players[0]
    puts ("#{winner.name} wins with a score of #{score(winner)}") if winner
  end

  def to_s
    "I'm a Game"
  end
end