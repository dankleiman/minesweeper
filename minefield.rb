require 'pry'
class Minefield
  attr_reader :row_count, :column_count

  def initialize(row_count, column_count, mine_count)
    @column_count = column_count
    @row_count = row_count
    @mine_count = mine_count
    @detenated = false
    @mines = place_mines
  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    false
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    if contains_mine?(row, col)
      @detenated = true
    else
      adjacent_mines(row, col)
    end
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    if @detenated
      true
    else
      false
    end
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    false
  end

  def place_mines
    mines = []
    until mines.length == @mine_count
      mine = [rand(0..@row_count), rand(0..@column_count)]
      if !mines.include?(mine)
        mines << mine
      end
    end
    mines
  end

  def contains_mine?(row, col)
    @mines.include?([row,col])
  end

  def adjacent_mines(row, col)
    adj_mines = 0
    (-1..1).each do |i|
      adj_row = row + i
      (-1..1).each do |j|
        adj_col = col + j
        if i != 0 || j != 0
          if contains_mine?(adj_row, adj_col)
            adj_mines += 1
          end
        end
      end
    end
    adj_mines
  end
end


