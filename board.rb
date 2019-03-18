require_relative "piece.rb"

class Board
  # Temporary!!!!!!!!!!!!
  attr_accessor :rows



  
  def initialize()
    @rows = Array.new(8) {[]}
    #@sentinel = NullPiece.instance

    # empty_line = Array.new(8, NullPiece.instance)
    empty_line = Array.new(8, " ")

    @rows[2..5] = Array.new(4, empty_line)
    @rows[1], @rows[6] = pawn_row, pawn_row
    @rows[0], @rows[7] = special_row, special_row
  end

  def pawn_row
    Array.new(8) { Pawn.new }
  end

  def special_row
    #[R, N, B, Q, K, B, N, R]
    %w[R N B Q K B N R]
  end

  def [](pos)

  end

  def []=(pos,val)

  end

  def move_piece(color,start_pos,end_pos)

  end

  def valid_pos?(pos)

  end

  def add_piece(piece,pos)

  end

  def checkmate?(color)

  end

  def in_check?(color)

  end

  def find_king(color)

  end

  def pieces

  end

  def dup

  end

  def move_piece!(color,start_pos,end_pos)

  end

end

b = Board.new
b.rows.each {|row| p row}
