# frozen_string_literal: true
INSTRUCTIONS = "Ingresa las coordenadas de la celda a descubrir\nEl formato es separados por coma Ejemplo: 2,1\nPara terminar ingresa 'e'"
ERROR_INPUT = 'Formato de coordenada incorrecto. ej: 2,1'

class BoardController
    def getUserInput
        correct_input = false
        puts INSTRUCTIONS
        while !correct_input
            input = gets.chomp
            return -1 if input == 'e'
            x,y  = input.split(',')
            correct_input = (isCorrect?(x) and isCorrect?(y))
            puts ERROR_INPUT if !correct_input
        end
        return x,y
    end

    private 
    def isCorrect?(input)
        return false if input.nil? or input.empty?
        return false if !input.match("^[0-9]$")
        return false if input.to_i > 8 
        return true
    end
end


b = BoardController.new
puts b.getUserInput