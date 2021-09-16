# frozen_string_literal: true
require 'matrix'

class BoardController
  def initialize(boardModel, boardView)
    @model = boardModel
    @view = boardView
    @playerSymbol = 'O'
  end

  def printBoard
    @view.clean()
    @view.printBoard(@model)
  end

  def requestInput
    @view.printOptions(playerSymbol)
    key = $stdin.gets.to_i
    x = (key/3.0).ceil()
    y = (key%3).to_i
    if y == 0 then
      y = 3
    end
    select(x,y);
  end

  def select(xo,yo)
    @model.mark(xo,yo,@playerSymbol)
    if @model.winner(@playerSymbol) then
      @view.congratulate(@playerSymbol)
    else
      swapPlayer()
      if @model.isFull() then
        @view.gameOver()
      else
        requestInput()
      end
    end
    @view.clean()
  end

  def swapPlayer
    if @playerSymbol == 'O' then
      @playerSymbol = 'X'
    else
      @playerSymbol = 'O'
    end
  end
end
