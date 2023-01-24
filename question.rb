class Question
  attr_reader :number_1, :number_2, :answer

  def initialize    
    @number_1 = rand(1..20)
    @number_2 = rand(1..20)
    @answer = @number_1 + @number_2
  end
  
  def give_question
    "What does #{@number_1} plus #{@number_2} equal?"
  end

  def correct? answer
    answer === @answer;
  end

  def to_s
    "I'm a Question"
  end
end