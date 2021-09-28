# frozen_string_literal: true
INSTRUCTIONS = "Ingresa las coordenadas de la celda a descubrir
El formato es separados por coma Ejemplo: 2,1
Para terminar ingresa 'e'"

ERROR_INPUT = 'Formato de coordenada incorrecto. ej: 2,1'

# boar controller.
class BoardController
  def request_user_input
    correct_input = false
    puts INSTRUCTIONS
    until correct_input
      input = gets.chomp
      break if input == 'e'

      x, y = input.split(',')
      correct_input = (correct?(x) and correct?(y))
      puts ERROR_INPUT unless correct_input
    end
  end

  private

  def correct?(input)
    return false if input.nil? || input.empty?
    return false unless input.match('^[0-9]$')
    return false if input.to_i > 8
    return true
  end
end


a = BoardController.new
a.request_user_input