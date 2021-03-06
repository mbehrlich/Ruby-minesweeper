require 'colorize'

class Tile
  attr_accessor :number
  attr_reader :bomb, :revealed

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
    if @flag == true
      @flag = false
    elsif @revealed == false
      @flag = true
    end
  end

  def to_s(end_game)
    if @bomb && end_game
      'B'.colorize(:red)
    elsif @flag
      'F'.colorize(:blue)
    elsif !@revealed
      '_'
    elsif @revealed
      @number.to_s.colorize(:green)
    end

  end

  # def bombed?
  #   @bombed
  # end
  #
  # def revealed?
  #   @revealed
  # end

end
