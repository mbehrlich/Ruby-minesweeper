require_relative "Board"
require "yaml"

class Game

  def initialize(size = 9, bomb_chance = 1)
    @board = Board.new(size, bomb_chance)
    @board.tile_factory
  end

  def play
    until bombed? || solved?
      @board.render()
      puts "type save or load or press enter to continue"
      save = parse_save
      if save == "s"
        saved_game = @board.to_yaml
        File.open("saved_game.txt", "w") { |file| file.write(saved_game)}
      elsif save == "l"
        f = File.open("saved_game.txt") { |file| data = file.read }
        loaded_game = YAML::load(f)
        @board = loaded_game
        @board.render
        #p# saved_game
      end
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
  def parse_save
    save = gets.chomp
   if save.downcase == "s" || save.downcase == "save"
     return "s"
   elsif save.downcase == "l" || save.downcase == "load"
     return "l"
   else
     false
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

puts "How big do you want the board? (Enter a number)"
size = gets.chomp.to_i
until (1..50).to_a.include?(size)
  puts "invalid size, enter a number between 1 and 50"
  size = gets.chomp.to_i
end
puts "Enter difficulty (1-9)"
diff = gets.chomp.to_i
until (1...10).to_a.include?(diff)
  puts "Invalid difficulty enter a number between 1 and 9"
  diff = gets.chomp.to_i
end
game = Game.new(size, diff)
game.play
