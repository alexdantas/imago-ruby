require 'imago'
require 'imago/engine'

# A single Tetris block (brick that builds the pieces).
class Block
  attr_accessor :x, :y

  # Creates a block with +appearance+ on +window+.
  #
  # +appearance+ is the string that represents it onscreen.
  # +window+ is the Window on which it will be shown.
  def initialize(x, y, appearance, window)
    @x = x
    @y = y
    @appearance = appearance
    @window = window
  end

  # Shows this block on it's Window.
  def draw
    @window.mvaddstr(@x, @y, @appearance)
  end
end

