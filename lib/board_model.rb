# frozen_string_literal: true

require_relative './cell_model'

# model board
class Board
  def initialize
    @size = 9
    @bombs = 10
    @board = generate_random_board
  end

  def generate_random_board
    random_board = Array.new(@size) { Array.new(@size) }
    generated_bombs = []
    while generated_bombs.length < @size
      new_bomb = [rand(9), rand(9)]
      unless generated_bombs.include?(new_bomb)
        generated_bombs << new_bomb
        random_board[new_bomb[0]][new_bomb[1]] = Cell.new(9, false)
      end
    end
    assign_board_cells(random_board)
  end

  def assign_board_cells(board)
    (0..@size - 1).each do |row|
      (0..@size - 1).each do |col|
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
end
