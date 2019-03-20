require 'singleton'
require 'byebug'
class Piece

  attr_reader :color, :symbol, :board, :pos

  def initialize(color, symbol, board,pos)
    @color = color
    @symbol = symbol
    @board = board
    @pos = pos
  end

  def to_s
    symbol
  end

  def add(arr1,arr2)
    [arr1.first + arr2.first, arr1.last + arr2.last]
  end

  def valid_pos?(target_pos)
    board.valid_pos?(target_pos) && board[target_pos].color != self.color
  end

  def add_valid(arr1, arr2)
    new_pos = add(arr1, arr2)
    return new_pos if valid_pos?(new_pos)

    nil
  end
end

module Slideable
  HORI_DIRS = {:u=>[-1,0],:d=>[1,0],:r=>[0,1],:l=>[0,-1]}
  DIAG_DIRS = {:ur=>[-1,1],:ul=>[-1,1],:dr=>[1,1],:dl=>[1,-1]}

  attr_accessor :horizontal_dirs, :diagonal_dirs
  def moves
    valid_pos = []
    dir = move_dirs
    valid_pos += propagate_move(:horizontal, HORI_DIRS) if dir[:horizontal]
    valid_pos += propagate_move(:diagonal, DIAG_DIRS) if dir[:diagonal]
    valid_pos
  end

  def propagate_move(dir, moveset)
    valid_pos = []
    moveset.each_value do |value|
      new_pos = @pos
      until board.valid_pos?(new_pos)
        new_pos = add(new_pos, value)
        valid_pos << new_pos if valid_pos?(new_pos)
        break if board[new_pos].color == self.color
      end
    end
    valid_pos
  end

  private 

  def move_dirs
    raise "You must overwrite this"
  end

  def grow_ublocked_moves_in_dir(dx,dy)

  end

end

module Stepable
  def moves
    valid_diffs = move_diffs
    valid_pos = valid_diffs.map { |x| add(pos, x) }

    # Delete pos out of bound
    valid_pos.select { |x| valid_pos?(x) }
  end

  def move_diffs
    raise "You must overwrite this"
  end
end

class NullPiece < Piece
  
  include Singleton

  def initialize
    super(nil, "   ",nil,nil)
  end
end

class Pawn < Piece
  include Stepable
  def initialize(color,board,pos)
    super(color, color == 'black' ? " ♟ " : " ♙ ",board,pos)
  end

  def move_diffs
    valid_diffs = []

    # Determine direction
    black = (color == 'black')
    dir = (black ? 1 : -1)
    init_row = (black ? (pos.first == 1) : (pos.first == 6))

    # Can move twice on first move. Can't move forward if occupied by opponent
    adv_one = add_valid(pos, [dir, 0])
    adv_two = add_valid(pos, [dir * 2, 0])
    valid_diffs << [dir, 0] if !(adv_one.nil?) && board[adv_one].color != color
    valid_diffs << [dir * 2, 0] if !(adv_two.nil?) && init_row && board[adv_two].color != color

    # Can kill diagonally
    diag_r = add_valid(pos, [dir, 1])
    diag_l = add_valid(pos, [dir, -1])
    valid_diffs << [dir, 1] if !(diag_r.nil?) && board[diag_r].color == color
    valid_diffs << [dir, -1] if !(diag_l.nil?) && board[diag_l].color == color

    valid_diffs
  end
end

class Rook < Piece
  include Slideable
  def initialize(color,board,pos)
    super(color, color == 'black' ? " ♜ " : " ♖ ",board,pos)
  end

  def move_dirs
   {:horizontal=>true}
  end

end

class Knight < Piece
  include Stepable
  def initialize(color,board,pos)
    super(color, color == 'black' ? " ♞ " : " ♘ ",board,pos)
  end

  def move_diffs
    [1,-1,2,-2].permutation(2).select {|a,b| a.abs != b.abs}
  end
end

class Bishop < Piece
  include Slideable
  def initialize(color,board,pos)
    super(color, color == 'black' ? " ♝ " : " ♗ ",board,pos)
  end
   def move_dirs
   {:diagonal=>true}
  end

end

class Queen < Piece
  include Slideable
  def initialize(color,board,pos)
    super(color, color == 'black' ? " ♛ " : " ♕ ",board,pos)
  end

   def move_dirs
   {:horizontal=>true,:diagonal=>true}
  end

end

class King < Piece
  include Stepable
  def initialize(color,board,pos)
    super(color, color == 'black' ? " ♚ " : " ♔ ",board,pos)
  end

  def move_dirs
    [-1,0,-1].permutation(2).to_a << [1,1] << [-1,-1]
  end
end

