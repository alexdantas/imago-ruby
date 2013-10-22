require 'imago/block'

# A single Tetris piece.
#
#
class Piece

  # All possible piece types.
  # Each one is referred by names resembling it's appearance:
  #
  #                       []
  #                       []  []      []
  #   [][]  [][]    [][]  []  []      []  [][][]
  # [][]      [][]  [][]  []  [][]  [][]    []
  #   S        Z     O     I    L    J      T
  Type = {
    :S => 1,
    :Z => 2,
    :O => 3,
    :I => 4,
    :L => 5,
    :J => 6,
    :T => 7
  }.freeze

  # Creates a new piece of +type+, that will be shown on +window+.
  #
  # See Window class.
  def initialize(x, y, type, window)
    @x = x
    @y = y
    @type = type

    @rotation = 0
    @appearance = "[]"
    @blocks = []

    # Building it's blocks based on it's type.
    # (each piece has exactly 4 blocks)
    block = Block.new(@x, @y, @appearance, window)
    @blocks.push block
    block = Block.new(@x+2, @y, @appearance, window)
    @blocks.push block
    block = Block.new(@x+4, @y, @appearance, window)
    @blocks.push block
    block = Block.new(@x, @y+1, @appearance, window)
    @blocks.push block
  end

  # Draws the entire piece on the screen.
  def draw
    @blocks.each do |block|
      block.draw
    end
  end
end

