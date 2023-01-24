class Player
  attr_accessor :name, :initial_life, :life
  
  def initialize name, initial_life
    @name = name
    @initial_life = initial_life
    @life = initial_life
  end

  def lose_a_life
    @life -= 1
  end

  def alive?
    @life > 0
  end

  def to_s
    "I'm a Player"
  end
end