# frozen_string_literal: true

require_relative './cell_model'
require_relative './board_model'
require_relative './board_view'
#
require_relative './game_flow'
#
require 'colorize'

board = Board.new

view = BoardView.new

#view.print_board(board)
#
rungame(board, view)
#board.surrender(board)
