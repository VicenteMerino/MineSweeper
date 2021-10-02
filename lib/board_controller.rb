# frozen_string_literal: true

# board controller.
class BoardController
  def initialize(board_model, board_view)
    @model = board_model
    @view = board_view
  end

  def select(row, col)
    @model.undercover_cell(row, col)
    @view.update(@model)
    if @model.check_victory
      @view.congratulate(@model)
    elsif @model.lose(row, col)
      @view.game_over(@model)
    else
      process_input
    end
  end

  def print_board
    @view.clean
    @view.print_board(@model)
  end

  def process_input
    input = @view.request_user_input
    row, col = input.split(',')
    if input == 'e'
      @model.surrender
      @view.game_over(@model)
    elsif correct?(row) & correct?(col)
      select(row.to_i, col.to_i)
    else
      process_input
    end
  end

  private

  def correct?(input)
    return false if input.nil? || input.empty?
    return false unless input.match('^[0-8]$')
    return false if input.to_i > 8

    true
  end
end
