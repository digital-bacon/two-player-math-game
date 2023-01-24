class Game
  attr_reader = :players, :total_players, :losers, :round, :question, :answer

  GAME_NAME = "TwO-O-Player Math Game"
  WELCOME_MESSAGE = "Challenge a friend to a math battle for the ages!\n\n"
  INITIAL_PLAYER_LIFE = 3

  def initialize
    @players = []
    @losers = []
    @total_players = 0
    @round = 0
    greet_players
    ask_total_players
    ask_player_names
    puts ("Player names have been locked!")
    announce_players
    play
    say_winner
    say_game_over
  end

  private

  def announce_players
    message = ""
    @players.each_with_index do |player, current|
      message += "#{player.name}"
      end_of_list = (current + 1) >= @total_players
      message += " vs " unless end_of_list
    end
    puts message
  end

  def ask_question(name)
    puts ("#{name}: #{@question.give_question}")
  end
  
  def ask_for_answer
    @answer = gets.chomp.to_i
  end

  def ask_player_names
    1.upto(@total_players) { |count|
      puts ("Enter P#{count} name:")
      name = gets.chomp
      player = Player.new(name, INITIAL_PLAYER_LIFE)
      @players << player
    }
  end

  def ask_total_players
    puts ("How many are playing?")
    @total_players = gets.chomp.to_i
    @total_players = 2 if @total_players < 2
  end

  def check_answer
    @question.correct?(@answer)
  end

  def greet_players
    puts ("~~~~~~~~~~~~~~~~~~~~~~")
    puts (GAME_NAME)
    puts ("~~~~~~~~~~~~~~~~~~~~~~")
    puts (WELCOME_MESSAGE)
  end

  def play
    # Shuffle players and initialize game loop
    @players.shuffle!
    remaining_players = @total_players
    first_player = 0
    this_player = 0
    until remaining_players <= 1 do
      this_player = first_player if remaining_players <= this_player
      @current_player = @players[this_player]
      play_round
      remove_losers
      remaining_players = @players.length
      this_player += 1
    end
  end

  def play_round
    @round += 1
    say_round_start
    request_new_question
    ask_question(@current_player.name)
    ask_for_answer
    process_answer    
    say_score
  end

  def request_new_question
    @question = Question.new
  end
  
  def process_answer
    if check_answer
      say_correct
    else
      @current_player.lose_a_life
      say_incorrect
    end
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

  def request_score(player)
    "#{player.life}/#{INITIAL_PLAYER_LIFE}"
  end

  def say_correct
    puts ("YES! You are correct.")
  end

  def say_game_over
    puts ("----- GAME OVER -----")
    puts ("Good bye!")
  end

  def say_incorrect
    puts ("Seriously? No!")
  end

  def say_round_start
    if @round === 1
      puts ("----- GAME START -----")
    else
      puts ("----- NEW TURN -----")
    end
  end

  def say_score
    message = ""
    total_players = @players.length
    @players.each_with_index do |player, current|
      message += "#{player.name}: #{request_score(player)}"
      end_of_list = (current + 1) >= total_players
      message += " vs " unless end_of_list
    end
    puts message
  end

  def say_winner
    winner = @players[0]
    puts ("#{winner.name} wins with a score of #{request_score(winner)}") if winner
  end

  def to_s
    "I'm a Game"
  end
end