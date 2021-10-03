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
    @board = Board.new(board_values: @board_values, bombs: 4)
    @bomb_board = [[nil, nil, nil, nil, Cell.new(9, false)], [nil, nil, nil, nil, nil],
                   [nil, nil, nil, Cell.new(9, false), nil], [nil, Cell.new(9, false), nil, nil, nil],
                   [nil, nil, nil, Cell.new(9, false), nil]]
  end

  def test_select_with_neighbor
    board_values = [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                    [[0, true], [0, true], [1, true], [2, true], [2, false]],
                    [[1, true], [1, true], [2, true], [9, false], [1, false]],
                    [[1, false], [9, false], [3, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, false], [1, true]]]
    board_with_neighbor = Board.new(board_values: board_values, bombs: 4)
    @board.undercover_cell(0, 0)
    assert(@board.equal(board_with_neighbor))
  end

  def test_select_without_neighbor
    board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                    [[0, false], [0, false], [1, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, false], [1, false]],
                    [[1, false], [9, false], [3, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, true], [1, true]]]
    board_without_neighbor = Board.new(board_values: board_values, bombs: 4)
    @board.undercover_cell(4, 3)
    assert(@board.equal(board_without_neighbor))
  end

  def test_select_visible
    board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                    [[0, false], [0, false], [1, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, false], [1, false]],
                    [[1, false], [9, false], [3, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, false], [1, true]]]
    board_visible = Board.new(board_values: board_values, bombs: 9)
    @board.undercover_cell(4, 4)
    assert(@board.equal(board_visible))
  end

  def test_board_length
    values = [[[0, true], [0, true], [0, true]],
              [[0, true], [0, true], [1, true]],
              [[1, true], [1, true], [2, true]]]
    board_test = Board.new(board_values: values, bombs: 0)
    assert_equal(board_test.board.length, values.length)
    assert_equal(board_test.board[0].length, values[0].length)
  end

  def test_victory_true
    board_values = [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                    [[0, true], [0, true], [1, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, true]],
                    [[1, true], [9, false], [3, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, true]]]
    board_win = Board.new(board_values: board_values, bombs: 4)
    assert(board_win.check_victory)
  end

  def test_victory_false
    board_values = [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                    [[0, true], [0, true], [1, true], [2, true], [2, true]],
                    [[1, false], [1, true], [2, true], [9, false], [1, true]],
                    [[1, true], [9, false], [3, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, true]]]
    board_win = Board.new(board_values: board_values, bombs: 4)
    assert_false(board_win.check_victory)
  end

  def test_surrender
    @board.surrender
    @board.board.each do |row|
      row.each do |cell|
        assert_true(cell.is_visible)
      end
    end
  end

  def test_not_lose
    assert_false(@board.check_lose)
  end

  def test_lose
    board_values = [[[0, true], [0, true], [0, true], [1, true], [9, true]],
                    [[0, true], [0, true], [1, true], [2, true], [2, true]],
                    [[1, false], [1, true], [2, true], [9, false], [1, true]],
                    [[1, true], [9, false], [3, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, true]]]
    board_lost = Board.new(board_values: board_values, bombs: 4)
    assert(board_lost.check_lose)
  end
end
