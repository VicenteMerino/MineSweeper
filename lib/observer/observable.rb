# frozen_string_literal: true

# observable for observer pattern
class Observable
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def notify_all
    @observers.each { |observer| observer.update(self) }
  end

  attr_reader :observers
end
