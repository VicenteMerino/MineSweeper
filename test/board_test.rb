# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_model'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
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
end
