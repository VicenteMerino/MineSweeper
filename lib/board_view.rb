# frozen_string_literal: true

require_relative './observer/observer'

$lose = false
# board view
class BoardView < Observer
  COLORS = %i[blue green red magenta black light_black yellow cyan light_cyan].freeze


  def clean
    system('clear') || system('cls')
  end

  def update(board_model)
    #clean
    print_board(board_model)
  end

  def apply_format(cell)
    if cell.is_visible
      # TODO: support a flags
      if cell.value != 9
        cell.value.to_s.colorize(color: COLORS[cell.value])
      else
        $lose = true
        '*'.colorize(:red)
      end
    else
      cell.value.to_s.colorize(background: :white).hide
    end
  end

  def print_board(board_model)
    header = "  #{(1..board_model.size).to_a.join(' ')}\n"
    board = board_model.board.each_with_index.map do |row, index|
      "#{index + 1} #{row.map { |cell| apply_format(cell) }.join(' ')}"
    end
    puts(header + board.join("\n"))
    if $lose == true
      game_over
    end
  end

  def congratulate
    #clean
    puts <<-BANNER
    ██╗  ██╗ █████╗ ███████╗     ██████╗  █████╗ ███╗   ██╗ █████╗ ██████╗  ██████╗ ██╗
    ██║  ██║██╔══██╗╚══███╔╝    ██╔════╝ ██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔═══██╗██║
    ███████║███████║  ███╔╝     ██║  ███╗███████║██╔██╗ ██║███████║██║  ██║██║   ██║██║
    ██╔══██║██╔══██║ ███╔╝      ██║   ██║██╔══██║██║╚██╗██║██╔══██║██║  ██║██║   ██║╚═╝
    ██║  ██║██║  ██║███████╗    ╚██████╔╝██║  ██║██║ ╚████║██║  ██║██████╔╝╚██████╔╝██╗
    ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝

    BANNER
  end

  def game_over
    #clean
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
