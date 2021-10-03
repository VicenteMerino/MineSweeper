# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/observer/observable'
require_relative '../lib/observer/observer'
require_relative '../lib/board_view'
require_relative 'mock_observer'
require 'test/unit'

class ObserverTest < Test::Unit::TestCase
  def setup
    @observable = Observable.new
  end

  def test_add_observer
    (0..5).each do |_i|
      @observable.add_observer(MockObserver.new)
    end
    assert_equal(6, @observable.observers.length)
  end

  def test_observer_with_update
    mock_observer = MockObserver.new
    view = BoardView.new
    board = Board.new
    board.add_observer(mock_observer)
    board.add_observer(view)
    board.notify_all
    assert_equal(true, mock_observer.is_updated)
  end

  def test_observer_without_updat
    observer = Observer.new
    @observable.add_observer(observer)
    assert_raise NotImplementedError do
      @observable.notify_all
    end
  end
end
