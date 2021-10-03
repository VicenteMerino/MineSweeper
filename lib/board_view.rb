# frozen_string_literal: false

require_relative './observer/observer'

INSTRUCTIONS = "Ingresa las coordenadas de la celda a descubrir
El formato es separados por coma Ejemplo: 2,1 (fila, columna)
Para terminar ingresa 'e'".freeze

COLORS = %i[blue green yellow cyan light_cyan magenta black light_black white].freeze

# board view
class BoardView < Observer
  def clean
    system('clear') || system('cls')
  end

  def update(board_model)
    clean
    print_board(board_model)
  end

  def apply_format(cell)
    if cell.is_visible
      # TODO: support a flags
      if cell.value != 9
        cell.value.to_s.colorize(color: COLORS[cell.value])
      else
        '*'.colorize(:red)
      end
    else
      cell.value.to_s.colorize(background: :white).hide
    end
  end

  def print_board(board_model)
    header = "  #{(0..board_model.size - 1).to_a.join(' ')}\n"
    board = board_model.board.each_with_index.map do |row, index|
      "#{index} #{row.map { |cell| apply_format(cell) }.join(' ')}"
    end
    puts(header + board.join("\n"))
  end

  def request_user_input
    puts INSTRUCTIONS
    gets.chomp
  end

  def congratulate(board_model)
    clean
    print_board(board_model)
    puts <<-BANNER
    ██╗  ██╗ █████╗ ███████╗     ██████╗  █████╗ ███╗   ██╗ █████╗ ██████╗  ██████╗ ██╗
    ██║  ██║██╔══██╗╚══███╔╝    ██╔════╝ ██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔═══██╗██║
    ███████║███████║  ███╔╝     ██║  ███╗███████║██╔██╗ ██║███████║██║  ██║██║   ██║██║
    ██╔══██║██╔══██║ ███╔╝      ██║   ██║██╔══██║██║╚██╗██║██╔══██║██║  ██║██║   ██║╚═╝
    ██║  ██║██║  ██║███████╗    ╚██████╔╝██║  ██║██║ ╚████║██║  ██║██████╔╝╚██████╔╝██╗
    ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝

    BANNER
  end

  def game_over(board_model)
    clean
    print_board(board_model)
    puts <<-BANNER
    ▄████  ▄▄▄       ███▄ ▄███▓▓█████     ▒█████   ██▒   █▓▓█████  ██▀███
    ██▒ ▀█▒▒████▄    ▓██▒▀█▀ ██▒▓█   ▀    ▒██▒  ██▒▓██░   █▒▓█   ▀ ▓██ ▒ ██▒
   ▒██░▄▄▄░▒██  ▀█▄  ▓██    ▓██░▒███      ▒██░  ██▒ ▓██  █▒░▒███   ▓██ ░▄█ ▒
   ░▓█  ██▓░██▄▄▄▄██ ▒██    ▒██ ▒▓█  ▄    ▒██   ██░  ▒██ █░░▒▓█  ▄ ▒██▀▀█▄
   ░▒▓███▀▒ ▓█   ▓██▒▒██▒   ░██▒░▒████▒   ░ ████▓▒░   ▒▀█░  ░▒████▒░██▓ ▒██▒
    ░▒   ▒  ▒▒   ▓▒█░░ ▒░   ░  ░░░ ▒░ ░   ░ ▒░▒░▒░    ░ ▐░  ░░ ▒░ ░░ ▒▓ ░▒▓░
     ░   ░   ▒   ▒▒ ░░  ░      ░ ░ ░  ░     ░ ▒ ▒░    ░ ░░   ░ ░  ░  ░▒ ░ ▒░
   ░ ░   ░   ░   ▒   ░      ░      ░      ░ ░ ░ ▒       ░░     ░     ░░   ░
         ░       ░  ░       ░      ░  ░       ░ ░        ░     ░  ░   ░
                                                        ░

    BANNER
  end
end
