# frozen_string_literal: true

require_relative './board_model'
require_relative './board_view'
require_relative './board_controller'
require 'colorize'

model = Board.new
view = BoardView.new
model.add_observer(view)
controller = BoardController.new(model, view)
controller.start_game
