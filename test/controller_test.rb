# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_controller'
require_relative '../lib/board_model'
require_relative '../lib/board_view'
require 'test/unit'
require 'stringio'
require 'colorize'

class ControllerTest < Test::Unit::TestCase
  def setup
    @board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                     [[0, false], [0, false], [1, false], [2, false], [2, false]],
                     [[1, false], [1, false], [2, false], [9, false], [1, false]],
                     [[1, false], [9, false], [3, false], [2, false], [2, false]],
                     [[1, false], [1, false], [2, false], [9, false], [1, false]]]
    @board_view = BoardView.new
    @board = Board.new(board_values: @board_values, bombs: 4)

    @controller = BoardController.new(@board, @board_view)
  end

  def test_correct_select
    board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                    [[0, false], [0, false], [1, false], [2, false], [2, false]],
                    [[1, true], [1, false], [2, false], [9, false], [1, false]],
                    [[1, false], [9, false], [3, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, false], [1, false]]]
    board_after_select = Board.new(board_values: board_values, bombs: 4)
    $stdin = StringIO.new('2,0')
    @controller.start_game(stop: true)
    assert(@board.equal(board_after_select))
  end

  def test_incorrect_select
    board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                    [[0, false], [0, false], [1, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, false], [1, false]],
                    [[1, false], [9, false], [3, false], [2, false], [2, false]],
                    [[1, false], [1, false], [2, false], [9, false], [1, false]]]
    board_after_select = Board.new(board_values: board_values, bombs: 4)
    $stdin = StringIO.new('fgsagasg')
    @controller.start_game(stop: true)
    assert(@board.equal(board_after_select))
  end

  def test_surrender_select
    $stdin = StringIO.new('e')
    @controller.start_game(stop: true)
    @board.board.each do |row|
      row.each do |cell|
        assert(cell.is_visible)
      end
    end
  end

  def test_win
    board_values = [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                    [[0, true], [0, true], [1, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, true]],
                    [[1, true], [9, false], [3, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, false]]]

    board = Board.new(board_values: board_values, bombs: 4)
    controller = BoardController.new(board, @board_view)
    $stdin = StringIO.new('4,4')
    controller.process_input(stop: true)
    assert_true(board.check_victory)
  end

  def test_lose
    board_values = [[[0, true], [0, true], [0, true], [1, true], [9, false]],
                    [[0, true], [0, true], [1, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, true]],
                    [[1, true], [9, false], [3, true], [2, true], [2, true]],
                    [[1, true], [1, true], [2, true], [9, false], [1, false]]]

    board = Board.new(board_values: board_values, bombs: 4)
    controller = BoardController.new(board, @board_view)
    $stdin = StringIO.new('0,4')
    controller.process_input(stop: true)
    assert_true(board.check_lose)
  end

  def test_correct_input
    assert(@controller.correct?('2'))
  end

  def test_blank_input
    assert_false(@controller.correct?(''))
  end

  def test_nil_input
    assert_false(@controller.correct?(nil))
  end

  def test_unmatched_input
    assert_false(@controller.correct?('234'))
  end
end
