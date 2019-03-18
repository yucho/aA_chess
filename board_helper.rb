require_relative "piece.rb"

module BoardHelper
   
  def special_row
    [r, n, b, q, k, b, n, r]
  end

  def pawn_row
    Array.new(8) { Pawn.new }
  end
  
  def new_rook
    return Rook.new
  end

   def new_queen
    return Queen.new
  end

   def new_knight
    return Knight.new
  end

   def new_bishop
    return Bishop.new
  end

   def new_king
    return King.new
  end

  alias_method :r,:new_rook
  alias_method :q,:new_queen
  alias_method :n,:new_knight
  alias_method :b,:new_bishop
  alias_method :k,:new_king
  

end