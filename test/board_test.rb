# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_model'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def setup
    @board = Board.new(board_values: [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                                      [[0, false], [0, false], [1, false], [2, false], [2, false]],
                                      [[1, false], [1, false], [2, false], [9, false], [1, false]],
                                      [[1, false], [9, false], [3, false], [2, false], [2, false]],
                                      [[1, false], [1, false], [2, false], [9, false], [1, true]]])
  end

  def test_random_board_size
    board_object = Board.new
    board_matrix = board_object.board
    size = board_object.size
    height = board_matrix.length
    width = board_matrix[0].length
    assert_equal(size, height)
    assert_equal(size, width)
  end

  def test_random_board_bombs
    board_object = Board.new
    board_matrix = board_object.board
    bombs = board_object.bombs
    bombs_count = 0
    board_matrix.each do |row|
      row.each do |cell|
        bombs_count += 1 if cell.value == 9
      end
    end
    assert_equal(bombs, bombs_count)
  end

  def test_nil_cells
    board_object = Board.new
    board_matrix = board_object.board
    nil_cells = 0
    board_matrix.each do |row|
      row.each do |cell|
        nil_cells += 1 if cell.nil?
      end
    end
    assert_equal(0, nil_cells)
  end

  def test_select_with_neighbor
    board_with_neighbor = Board.new(board_values: [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                                                   [[0, true], [0, true], [1, true], [2, true], [2, false]],
                                                   [[1, true], [1, true], [2, true], [9, false], [1, false]],
                                                   [[1, false], [9, false], [3, false], [2, false], [2, false]],
                                                   [[1, false], [1, false], [2, false], [9, false], [1, true]]])
    @board.undercover_cell(0, 0)
    assert_equal(@board.equal(board_with_neighbor), true)
  end

  def test_select_without_neighbor
    board_without_neighbor = Board.new(board_values: [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                                                      [[0, false], [0, false], [1, false], [2, false], [2, false]],
                                                      [[1, false], [1, false], [2, false], [9, false], [1, false]],
                                                      [[1, false], [9, false], [3, false], [2, false], [2, false]],
                                                      [[1, false], [1, false], [2, false], [9, true], [1, true]]])
    @board.undercover_cell(4, 3)
    assert_equal(@board.equal(board_without_neighbor), true)
  end

  def test_select_visible
    board_visible = Board.new(board_values: [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                                             [[0, false], [0, false], [1, false], [2, false], [2, false]],
                                             [[1, false], [1, false], [2, false], [9, false], [1, false]],
                                             [[1, false], [9, false], [3, false], [2, false], [2, false]],
                                             [[1, false], [1, false], [2, false], [9, false], [1, true]]])
    @board.undercover_cell(4, 4)
    assert_equal(@board.equal(board_visible), true)
  end

  def test_board
    values = [[[0, true], [0, true], [0, true]],
              [[0, true], [0, true], [1, true]],
              [[1, true], [1, true], [2, true]]]
    board_test = Board.new(board_values: values)
    assert_equal(board_test.board.length, values.length)
    assert_equal(board_test.board[0].length, values[0].length)
  end
end
