class Game
  attr_reader = :players, :losers, :question, :answer

  GAME_NAME = "TwO-O-Player Math Game"
  WELCOME_MESSAGE = "Challenge a friend to a math battle for the ages!\n\n"
  INITIAL_PLAYER_LIFE = 1

  def initialize
    puts ("~~~~~~~~~~~~~~~~~~~~~~")
    puts (GAME_NAME)
    puts ("~~~~~~~~~~~~~~~~~~~~~~")
    puts (WELCOME_MESSAGE)
    
    puts ("How many are playing?")
    total_players = gets.chomp.to_i
    if total_players < 2
      total_players = 2
    end
    
    # Generate the players
    @players = []
    @losers = []

    for count in 1..total_players
        puts ("Enter P#{count} name:")
        name = gets.chomp
        player = Player.new(name, INITIAL_PLAYER_LIFE)
        @players << player
    end

    puts ("Player names have been locked!")

    # Announce the players
    message = ""
    @players.each_with_index do |player, current|
      message += "#{player.name}"
      if (current + 1) < total_players
        message += " vs "
      end
    end
    puts message
    
    # Shuffle players and initialize game loop
    @players.shuffle!
    play_game = true
    remaining_players = total_players
    player_number = 0
    puts ("----- GAME START -----")
    while play_game
      @current_player = @players[player_number]
      self.new_round
      remaining_players = @players.length
      play_game = remaining_players >= 2 ? true : false
      player_number += 1
      if (remaining_players <= player_number)
        player_number = 0
      end
    end
  end

  private

  def new_round
    new_question
    ask_question(@current_player.name)

    if correct?
      puts ("YES! You are correct.")
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
    puts ("#{name}: #{@question.ask}")
    @answer = gets.chomp.to_i
  end

  def correct?
    @question.correct?(@answer)
  end

  def continue_play?
    return @players.length >= 2
  end

  def remove_losers
    @players.each_with_index do |player, index|
      if !player.alive?
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
      message += "#{player.name}: #{player.say_score}"
      if (current + 1) < total_players
        message += " vs "
      end
    end
    puts message
  end
  
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