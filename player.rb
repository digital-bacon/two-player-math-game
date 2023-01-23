class Player
  attr_accessor :name, :life

  def initialize(name)
    @name = name
    @life = 3
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