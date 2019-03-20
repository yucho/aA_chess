require_relative "piece.rb"
require_relative "board_helper.rb"

class Board

  include BoardHelper

  def initialize
    @rows = Array.new(8) {[]}
    @sentinel = NullPiece.instance

    empty_line = Array.new(8, NullPiece.instance)

    @rows[2..5] = Array.new(4, empty_line)
    @rows[1], @rows[6] = pawn_row('black',self,1), pawn_row('white',self,6)
    @rows[0], @rows[7] = special_row('black',self,0), special_row('white',self,7)
  end

  def [](pos, pos_2=nil)
    pos = [pos, pos_2] unless pos_2.nil?
    @rows [pos.first][pos.last]
  end

  def []=(pos,val)
    @rows [pos.first][pos.last] = val
  end

  def move_piece(start_pos, end_pos) #add color agrument later
    if NullPiece === self[end_pos]
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    elsif NullPiece === self[start_pos]
      raise "Invalid move: no piece at start pos"
    else
      raise "Invalid move: piece exists at end pos"
    end
  end

  def valid_pos?(pos)
    pos.first.between?(0, 7) && pos.last.between?(0, 7)
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

  # Debug
  def test_board
    empty_line = Array.new(8, NullPiece.instance)
    @rows[0..7] = Array.new(8, empty_line)

    self[[4,4]] = b('black', self, [4,4])
  end
end