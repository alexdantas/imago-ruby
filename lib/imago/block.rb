require 'imago'

# A single Tetris block (brick that builds the pieces).
class Block
  attr_accessor :x, :y

  # Creates a block with +appearance+ (string that represents it onscreen).
  def initialize(x, y, appearance)
    @x = x
    @y = y
    @appearance = appearance
  end

  # Shows this block on the main game screen.
  def draw
    Imago::LAYOUT[:game].mvaddstr(@x, @y, @appearance)
  end
end

