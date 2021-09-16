# frozen_string_literal: true
require_relative 'test_helper'
require_relative '../lib/board_model'
require 'test/unit'

class BoardTest < Test::Unit::TestCase

  def test_winner_horizontal
    board = Board.new([
      ['*','*','*','*','*'],
      ['*','X','X','X','*'],
      ['*','_','0','_','*'],
      ['*','_','0','_','*'],
      ['*','*','*','*','*']
    ])
    assert_true(board.winner('X'))
  end
  def test_winner_vertical
    board = Board.new([
      ['*','*','*','*','*'],
      ['*','X','0','X','*'],
      ['*','_','0','_','*'],
      ['*','_','0','_','*'],
      ['*','*','*','*','*']
    ])
    assert_true(board.winner('0'))
  end
  def test_winner_diagonal_left
    board = Board.new([
      ['*','*','*','*','*'],
      ['*','X','0','X','*'],
      ['*','_','X','_','*'],
      ['*','_','0','X','*'],
      ['*','*','*','*','*']
    ])
    assert_true(board.winner('X'))
    assert_false(board.winner('0'))
  end
  def test_winner_diagonal_right
    board = Board.new([
      ['*','*','*','*','*'],
      ['*','X','X','0','*'],
      ['*','_','0','_','*'],
      ['*','0','0','X','*'],
      ['*','*','*','*','*']
    ])
    assert_true(board.winner('0'))
    assert_false(board.winner('X'))
  end
  def test_no_winner
    board = Board.new([
      ['*','*','*','*','*'],
      ['*','X','X','0','*'],
      ['*','_','0','X','*'],
      ['*','_','0','X','*'],
      ['*','*','*','*','*']
    ])
    assert_false(board.winner('0'))
    assert_false(board.winner('X'))
  end
  def test_is_not_full
    board = Board.new([
      ['*','*','*','*','*'],
      ['*','X','X','0','*'],
      ['*','_','0','X','*'],
      ['*','_','0','X','*'],
      ['*','*','*','*','*']
    ])
    assert_false(board.isFull())
  end
  def test_is_full
    board = Board.new([
      ['*','*','*','*','*'],
      ['*','X','X','0','*'],
      ['*','X','0','X','*'],
      ['*','0','0','X','*'],
      ['*','*','*','*','*']
    ])
    assert_true(board.isFull())
  end
end
