# frozen_string_literal: true

class MockObserver < Observer
  def initialize
    super()
    @is_updated = false
  end

  def update(_board)
    @is_updated = true
  end

  attr_reader :is_updated
end
