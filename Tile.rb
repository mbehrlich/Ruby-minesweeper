class Tile
  attr_accessor :number
  attr_reader :bomb :revealed

  def initialize(bomb_chance)
    @revealed = false
    @flag = false
    chance = rand(10) + 1
    if chance <= bomb_chance
      @bomb = true
    else
      @bomb = false
    end
    @number = 0
  end

  def reveal
    @revealed = true
    @flag = false
  end

  def flag
    @flag = true unless @revealed
  end

  def to_s(end)
    if @bomb && end
      'B'
    elsif @flag
      'F'
    elsif !@revealed
      '_'
    elsif @revealed
      @number
    end

  end

end
