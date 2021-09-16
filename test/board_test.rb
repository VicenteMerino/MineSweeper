# frozen_string_literal: true
require_relative 'test_helper'
require_relative '../lib/board_model'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def setup
    #an empty board
    @board = Board.new([
      ['*','*','*','*','*'],
      ['*','_','_','_','*'],
      ['*','_','_','_','*'],
      ['*','_','_','_','*'],
      ['*','*','*','*','*']
    ])
  end

  def test_first_mark
    @board.mark(1,1,'O')
    expected = Board.new([
      ['*','*','*','*','*'],
      ['*','O','_','_','*'],
      ['*','_','_','_','*'],
      ['*','_','_','_','*'],
      ['*','*','*','*','*']
    ])
    #note that I keep the object state private
    assert_true(@board.equal(expected))
  end
  def test_second_mark
    @board.mark(1,1,'O')
    @board.mark(1,2,'X')
    expected = Board.new([
      ['*','*','*','*','*'],
      ['*','O','X','_','*'],
      ['*','_','_','_','*'],
      ['*','_','_','_','*'],
      ['*','*','*','*','*']
    ])
    assert_true(@board.equal(expected))
  end
  def test_equal
    a = Board.new([
      ['*','*','*','*','*'],
      ['*','X','_','_','*'],
      ['*','_','X','_','*'],
      ['*','_','_','X','*'],
      ['*','*','*','*','*']
    ])
    b = Board.new([
      ['*','*','*','*','*'],
      ['*','X','_','_','*'],
      ['*','_','X','_','*'],
      ['*','_','_','X','*'],
      ['*','*','*','*','*']
    ])
    assert_true(a.equal(b))
  end
  def test_not_equal
    a = Board.new([
      ['*','*','*','*','*'],
      ['*','_','_','_','*'],
      ['*','_','X','_','*'],
      ['*','_','_','_','*'],
      ['*','*','*','*','*']
    ])
    b = Board.new([
      ['*','*','*','*','*'],
      ['*','_','_','_','*'],
      ['*','dsgsdg','0','_','*'],
      ['*','_','_','_','*'],
      ['*','*','*','*','*']
    ])
    assert_false(a.equal(b))
  end
end
