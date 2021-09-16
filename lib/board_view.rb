# frozen_string_literal: true
require  'matrix'
require_relative './observer/observer'

class BoardView < Observer

  def update(boardModel)
    clean()
    printBoard(boardModel)
  end
  
  def printBoard(boardModel)
    pos = 1
    for i in 1..3
      print "|"
      for j in 1..3
        symbol = boardModel.symbolAt(i,j)
        if symbol == '_' then
          print "#{pos}|"
        else
          print "#{symbol}|"
        end
        pos += 1
      end
      print "\n"
    end
    STDOUT.flush
  end
  def congratulate(playerSymbol)
    clean()
    print "Player: #{playerSymbol} WINS\n"
  end
  def gameOver()
    clean()
    print "GG - NO SKILL\n"
  end

  def clean
    # TODO
  end

  def printOptions(playerSymbol)
    print "select a position #{playerSymbol}\n"
  end

end
