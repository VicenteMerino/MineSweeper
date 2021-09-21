# frozen_string_literal: true

require_relative './cell_model'

# model board
class Board
  def initialize
    @board = generate_random_board
    @size = 9
    @bombs  = 10
  end

  def generate_random_board
    # falta definir
  end
end
