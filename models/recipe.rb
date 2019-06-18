class Recipe
  attr_reader :name, :description, :prep_time
  def initialize(name, description, prep_time, completed = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @completed = completed
  end

  def change_status
    if @completed == true
      @completed = false
    elsif @completed == false
      @completed = true
    end
  end

  def completed?
    @completed
  end
end
