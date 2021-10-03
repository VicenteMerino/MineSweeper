require_relative 'test_helper'
require_relative '../lib/observer/observable'
require_relative '../lib/observer/observer'
require_relative '../lib/board_controller'
require_relative '../lib/board_model'
require_relative '../lib/board_view'
require_relative 'mock_observer'
require 'test/unit'
require 'stringio'
require 'colorize'

class ControllerTest < Test::Unit::TestCase
  def setup
    @board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                     [[0, false], [0, false], [1, false], [2, false], [2, false]],
                     [[1, false], [1, false], [2, false], [9, false], [1, false]],
                     [[1, false], [9, false], [3, false], [2, false], [2, false]],
                     [[1, false], [1, false], [2, false], [9, false], [1, true]]]
    @board_view = BoardView.new
    @board = Board.new(board_values: @board_values, bombs: 4)

    @controller = BoardController.new(@board, @board_view )
  end

  def test_correct_select

    board_values = [[[0, false], [0, false], [0, false], [1, false], [9, false]],
                     [[0, false], [0, false], [1, false], [2, false], [2, false]],
                     [[1, true], [1, false], [2, false], [9, false], [1, false]],
                     [[1, false], [9, false], [3, false], [2, false], [2, false]],
                     [[1, false], [1, false], [2, false], [9, false], [1, true]]]
    board_after_select = Board.new(board_values: board_values, bombs: 4)
    @controller.start_game
    io = StringIO.new
    io.puts "2,0"
    io.string
    @controller.select(2,0)
    assert_equal(@board.equal(board_after_select), true)

  end
end
