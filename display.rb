require_relative "board.rb"
require_relative "cursor.rb"
require 'colorize'
require 'byebug'

class Display

  COLOR = {
    :active => :red,
    :cursor => :cyan,
    :cell_odd => :light_magenta,
    :cell_even => :light_black,
    :bpiece => :black,
    :wpiece => :white
  }

  attr_accessor :board, :cursor

  def initialize 
    @board = Board.new
    @cursor = Cursor.new([0,0],@board)
  end

  def render
    c_pos = cursor.cursor_pos
    board_str = ""
    8.times do |row|
      8.times do |col|
        pos = [row, col]
        piece = board[pos]
        symbol = piece.to_s 
        colors = {}
        colors[:color] = (piece.color == 'black' ? COLOR[:bpiece] : COLOR[:wpiece])
        if c_pos == pos
          colors[:background] = COLOR[:cursor]
        elsif (row+col).even?
          colors[:background] = COLOR[:cell_even]
        else
          colors[:background] = COLOR[:cell_odd]
        end
        symbol = symbol.colorize(colors)
        board_str += symbol
      end
      board_str += "\n"
    end
    puts board_str
  end

  def test_render
    while true
      render
      cursor.get_input
      system("clear")
    end
  end

  def test_valid_pos
    p board[6,7].moves
    # debugger
  end
end

# puts " ♟ ".colorize(:color=>:light_blue ,:background => :white) + " ♖ ".colorize(:color=>:black ,:background => :light_magenta)

d = Display.new
d.board.test_board
d.test_render
# d.test_valid_pos
