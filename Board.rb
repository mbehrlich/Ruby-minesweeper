require_relative "Tile"

class Board

  attr_reader :grid, :size

  def initialize(size, bomb_chance)
    @size = size
    @bomb_chance = bomb_chance
  end
  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def tile_factory
    @grid = Array.new(@size) {Array.new(@size)}
    @grid = @grid.map do |row|
      row.map do |el|
        Tile.new(@bomb_chance)
      end
    end
    assign_numbers
  end

  def assign_numbers
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, el_idx|
        pos = [row_idx, el_idx]
        self[pos].number = adjacents(pos)
      end
    end
  end

  def adjacents(pos)
    x,y = pos
    sum = 0
    (-1..1).each do |num1|
      (-1..1).each do |num2|
        sum += 1 if bomb_check([x + num1,y + num2])
      end
    end
    sum
  end

  def bomb_check(pos)
    x,y = pos
    return false if x < 0 || x >= @size || y < 0 || y >= @size
    self[pos].bomb
  end

  def render(end_game = false)
    first_row = (0...@size).to_a.map do |num|
      if num > 9
        num.to_s + ' '
      else
        num.to_s + '  '
      end
    end
    puts '   ' + first_row.join('')
    @grid.each_with_index do |row,row_idx|
      print "#{row_idx} " if row_idx > 9
      print "#{row_idx}  " if row_idx < 10
      row.each_with_index do |el,el_idx|
        pos = [row_idx,el_idx]
        print "#{self[pos].to_s(end_game)}  "
      end
      print "\n"
    end
  end

  def reveal(pos)
    x,y = pos
    return if x < 0 || x >= @size || y < 0 || y >= @size
    return if self[pos].revealed
    self[pos].reveal
    if self[pos].number == 0
      adjacent_reveal(pos)
    end
    self[pos].bomb
  end

  def adjacent_reveal(pos)
    x,y = pos
    (-1..1).each do |num1|
      (-1..1).each do |num2|
        reveal([x+num1,y+num2])
      end
    end
  end

  def flag(pos)
    self[pos].flag
  end

  def solved?
    @grid.each do |row|
      row.each do |el|
        return false unless el.revealed || el.bomb
      end
    end
    true
  end

  def bombed?
    @grid.each do |row|
      row.each do |el|
        return true if el.revealed && el.bomb
      end
    end
    false
  end

end
