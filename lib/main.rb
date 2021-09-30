# frozen_string_literal: true

require_relative './cell_model'
require_relative './board_model'
require_relative './board_view'
require 'colorize'

board = Board.new

view = BoardView.new

view.print_board(board)
view.game_over
