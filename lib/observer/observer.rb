# frozen_string_literal: true

# observer for observer pattern
class Observer
  def update(_board)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
