# frozen_string_literal: true

# board controller.
class BoardController
  def initialize(board_model, board_view)
    @model = board_model
    @view = board_view
  end

  def select(row, col, stop: false)
    @model.undercover_cell(row, col)
    if @model.check_victory
      @view.congratulate(@model)
    elsif @model.check_lose
      @view.game_over(@model)
    else
      process_input unless stop
    end
  end

  def process_input(stop: false)
    input = @view.request_user_input
    row, col = input.split(',')
    if input == 'e'
      @model.surrender
      @view.game_over(@model)
    elsif correct?(row) && correct?(col)
      select(row.to_i, col.to_i, stop: stop)
    else
      process_input unless stop
    end
  end

  def start_game(stop: false)
    @view.clean
    @view.print_board(@model)
    process_input(stop: stop)
  end

  def correct?(input)
    return false if input.nil? || input.empty?
    return false unless input.match('^[0-8]$')

    true
  end
end
