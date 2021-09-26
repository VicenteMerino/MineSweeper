# frozen_string_literal: true

# cell class
class Cell
  attr_accessor :value, :is_visible

  def initialize(value, is_visible)
    @value = value
    @is_visible = is_visible
  end

  def equal(other_cell)
    other_cell.value == @value && other_cell.is_visible == @is_visible
  end
end
