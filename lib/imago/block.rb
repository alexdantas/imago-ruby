require 'imago'
require 'imago/engine'

# A single Tetris block (brick that builds the pieces).
class Block
  attr_accessor :x, :y, :type

  # Block's content
  Type = {
    :BLOCK => 0,
    :EMPTY => 1
  }.freeze

  # Creates a block with +appearance+ on +window+.
  #
  # +appearance+ is the string that represents it onscreen.
  # +window+ is the Window on which it will be shown.
  def initialize(x, y, appearance, window, type=Type[:BLOCK])
    @x = x
    @y = y
    @type = type
    @window = window
    @appearance = appearance
  end

  # Shows this block on it's Window.
  def draw
    return if @type == Type[:EMPTY]

    @window.mvaddstr(@x, @y, @appearance)
  end

  # Returns a new block just like this one.
  def clone
    Block.new(@x, @y, @appearance, @window, @type)
  end
end

