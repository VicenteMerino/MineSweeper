# frozen_string_literal: true

require_relative './cell_model'

# model board
class Board
  attr_reader :size, :bombs, :board

  def initialize(board_values: [])
    @size = board_values.length.zero? ? 9 : board_values.length
    @bombs = 10
    @board = board_values.length.zero? ? generate_random_board : test_board(board_values)
  end

  def generate_random_board
    random_board = Array.new(@size) { Array.new(@size) }
    generated_bombs = []
    while generated_bombs.length <= @size
      new_bomb = [rand(9), rand(9)]
      unless generated_bombs.include?(new_bomb)
        generated_bombs << new_bomb
        random_board[new_bomb[0]][new_bomb[1]] = Cell.new(9, false)
      end
    end
    assign_board_cells(random_board)
  end

  def assign_board_cells(board)
    (0..board.length - 1).each do |row|
      (0..board[0].length - 1).each do |col|
        if board[row][col].nil?
          cell_value = neighbors_bombs(board, row, col)
          board[row][col] = Cell.new(cell_value, false)
        end
      end
    end
    board
  end

  def neighbors_bombs(board, row, col)
    movements = [[-1, -1], [-1, 0], [1, 0], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    movements.select! { |y, x| (y + row).between?(0, @size - 1) && (x + col).between?(0, @size - 1) }
    bombs_count = 0
    movements.each do |movement|
      bombs_count += 1 if board[row + movement[0]][col + movement[1]]
    end
    bombs_count
  end

  def test_board(board_values)
    board = Array.new(@size) { Array.new(@size) }
    board_values.each_with_index do |row, i|
      row.each_with_index { |value, j| board[i][j] = Cell.new(value[0], value[1]) }
    end
    board
  end

  def undercover_cell(row, col)
    cell = @board[row][col]
    return if cell.is_visible

    cell.is_visible = true
    return if cell.value != 0

    check_neighbors(row, col)
  end

  def check_neighbors(row, col)
    (row - 1..row + 1).each do |neighbor_row|
      (col - 1..col + 1).each do |neighbor_col|
        undercover_cell(neighbor_row, neighbor_col) if in_tablero(row, col, neighbor_row, neighbor_col) &&
                                                       @board[neighbor_row][neighbor_col].value != 9
      end
    end
  end

  def in_tablero(row, col, neighbor_row, neighbor_col)
    (neighbor_row.between?(0, @size - 1) && neighbor_col.between?(0, @size - 1) &&
      !(neighbor_row == row && neighbor_col == col))
  end

  def equal(other_board)
    (0..@size - 1).each do |row|
      (0..@size - 1).each do |col|
        return false unless (@board[row][col]).equal(other_board.board[row][col])
      end
    end
    true
  end
end
