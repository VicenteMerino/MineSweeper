# frozen_string_literal: true

require_relative './cell_model'
require_relative './board_model'
require_relative './board_view'
require 'colorize'

def rungame(board, view)
  puts "\n Bienvenido a Minesweeper. \n Su tablero se presenta a continuacion: \n"
  view.print_board(board)

  puts "\n Ingrese la fila en que desea jugar: "
  selectedRow = gets.chomp.to_i
  puts "\n Ingrese la Columna en que desea jugar: "
  selectedCol = gets.chomp.to_i
  puts "Selecciono la coordenada ("+ selectedRow.to_s+","+selectedCol.to_s+ ") -> Actualizando tablero: \n"


end
