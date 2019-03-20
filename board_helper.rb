require_relative "piece.rb"

module BoardHelper
   
  def special_row(color,board,row)
    c = color
    b = board
    x = row
    [r(c,b,[x,0]), n(c,b,[x,1]), b(c,b,[x,2]), q(c,b,[x,3]), k(c,b,[x,4]), b(c,b,[x,5]), n(c,b,[x,6]), r(c,b,[x,7])]
  end

  def pawn_row(color,board,row)
    Array.new(8) {|index| Pawn.new(color,board,[row,index]) }
  end
  
  def new_rook(color,board,pos)
    return Rook.new(color,board,pos)
  end

   def new_queen(color,board,pos)
    return Queen.new(color,board,pos)
  end

   def new_knight(color,board,pos)
    return Knight.new(color,board,pos)
  end

   def new_bishop(color,board,pos)
    return Bishop.new(color,board,pos)
  end

   def new_king(color,board,pos)
    return King.new(color,board,pos)
  end

  alias_method :r,:new_rook
  alias_method :q,:new_queen
  alias_method :n,:new_knight
  alias_method :b,:new_bishop
  alias_method :k,:new_king
  

end