# frozen_string_literal: true

# cell class
class Cell
  attr_accessor :value, :is_visible

  def initialize(value, is_visible)
    @value = value
    @is_visible = is_visible
  end
end
