# frozen_string_literal: true
require_relative './observer/observable'
require 'matrix'

class Board < Observable
    def initialize(initialMatrix = [
      ['*','*','*','*','*'],
      ['*','_','_','_','*'],
      ['*','_','_','_','*'],
      ['*','_','_','_','*'],
      ['*','*','*','*','*']])
      super()
      @matrix = initialMatrix
    end

    def mark(xo, yo, symbol)
      @matrix[xo][yo] = symbol
      notifyAll()
    end

    def symbolAt(xo,yo)
      @matrix[xo][yo]
    end

    def winner(symbol)
      for i in 1..3
        for j in 1..3
          if (@matrix[i][j] == symbol && sameNeighbors(i,j,symbol)) then
            return true
          end
        end
      end
      return false
    end

    def sameNeighbors(xo, yo, symbol)
      return (@matrix[xo][yo - 1] == symbol && @matrix[xo][yo + 1] == symbol) ||  (@matrix[xo - 1][yo] == symbol && @matrix[xo + 1][yo] == symbol) || (@matrix[xo - 1][yo - 1] == symbol && @matrix[xo + 1][yo + 1] == symbol) || (@matrix[xo + 1][yo - 1] == symbol && @matrix[xo - 1][yo + 1] == symbol)
    end
    def getMark(x,y)
      return @matrix[x][y]
    end

    def isFull
      counter = 0
      for i in 1..3
        for j in 1..3
          if (@matrix[i][j] == '_') then
            counter += 1
          end
        end
      end
      return counter == 0
    end

    def equal(otherBoard)
      for i in 1..3
        for j in 1..3
          if @matrix[i][j] != otherBoard.getMark(i,j) then
              return false
          end
        end
      end
      return true
    end
end
