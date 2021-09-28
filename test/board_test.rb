# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_model'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def setup
    @board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                     [[0, false], [0, false], [1, false], [2, false], [2, false]],
                     [[1, false], [1, false], [2, false], [9, false], [1, false]],
                     [[1, false], [9, false], [3, false], [2, false], [2, false]],
                     [[1, false], [1, false], [2, false], [9, false], [1, true]]]
    @board = Board.new(board_values: @board_values)
    @bomb_board = [[nil, nil, nil, nil, Cell.new(9, false)], [nil, nil, nil, nil, nil],
                   [nil, nil, nil, Cell.new(9, false), nil], [nil, Cell.new(9, false), nil, nil, nil],
                   [nil, nil, nil, Cell.new(9, false), nil]]
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

  def test_board_length
    values = [[[0, true], [0, true], [0, true]],
              [[0, true], [0, true], [1, true]],
              [[1, true], [1, true], [2, true]]]
    board_test = Board.new(board_values: values)
    assert_equal(board_test.board.length, values.length)
    assert_equal(board_test.board[0].length, values[0].length)
  end

  def test_board_test_bombs
    values = [[[0, true], [9, true], [0, true]],
              [[9, false], [0, true], [1, true]],
              [[1, true], [1, true], [2, true]]]
    board_test = Board.new(board_values: values)
    assert_equal(board_test.bombs, 2)
  end

  def test_victory_true
    board_win = Board.new(board_values: [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                                         [[0, true], [0, true], [1, true], [2, true], [2, true]],
                                         [[1, true], [1, true], [2, true], [9, false], [1, true]],
                                         [[1, true], [9, false], [3, true], [2, true], [2, true]],
                                         [[1, true], [1, true], [2, true], [9, false], [1, true]]])
    assert_true(board_win.check_victory)
  end

  def test_victory_false
    board_win = Board.new(board_values: [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                                         [[0, true], [0, true], [1, true], [2, true], [2, true]],
                                         [[1, false], [1, true], [2, true], [9, false], [1, true]],
                                         [[1, true], [9, false], [3, true], [2, true], [2, true]],
                                         [[1, true], [1, true], [2, true], [9, false], [1, true]]])
    assert_false(board_win.check_victory)
  end
end
