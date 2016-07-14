require_relative "Board"

class Game

  def initialize(size = 9, bomb_chance = 1)
    @board = Board.new(size, bomb_chance)
    @board.tile_factory
  end

  def play
    until bombed? || solved?
      @board.render()
      puts "enter position example = (0,0)"
      pos = parse_pos(gets.chomp)
      puts "press f for flag or r for reveal"
      val = parse_val(gets.chomp)
      #@board.reveal(pos)
      if val == 'f'
        @board.flag(pos)
      elsif val == 'r'
        @board.reveal(pos)
      end
    end
    @board.render(true)
    if bombed?
      puts " You lose!! "
    else
      puts " You win!! "
    end

  end

  def solved?
    @board.solved
  end

  def bombed?
    @board.bombed
  end

end
