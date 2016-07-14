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
      pos = parse_pos
      puts "press f for flag or r for reveal"
      val = parse_val
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

  def parse_pos
    pos = gets.chomp
    pos = pos.split(',').map(&:to_i)
    until valid_pos?(pos)
      puts "Invalid position"
      pos = gets.chomp
      pos = pos.split(',').map(&:to_i)
    end
    pos
  end

  def parse_val
    val = gets.chomp
    until valid_val?(val)
      puts "Invalid value, put f or r"
      val = gets.chomp
    end
    val
  end

  def valid_pos?(pos)
    x, y = pos
    return false if pos.length != 2
    return false if x < 0 || x >= @board.size || y < 0 || y >= @board.size
    true
  end

  def valid_val?(value)
    if value.downcase == 'f' || value.downcase == 'r'
      return true
    end
    false
  end


  def solved?
    @board.solved?
  end

  def bombed?
    @board.bombed?
  end

end

game = Game.new(4)
game.play
