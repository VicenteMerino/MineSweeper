# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/cell_model'
require 'test/unit'

class CellModelTest < Test::Unit::TestCase
  def setup
    @cell = Cell.new(5, false)
  end

  def test_same_cell
    other_cell = Cell.new(5, false)
    assert(@cell.equal(other_cell))
  end

  def test_different_value_cell
    other_cell = Cell.new(7, false)
    assert_equal(@cell.equal(other_cell), false)
  end

  def test_different_visible_cell
    other_cell = Cell.new(5, true)
    assert_equal(@cell.equal(other_cell), false)
  end
end
