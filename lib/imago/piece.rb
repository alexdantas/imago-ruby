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

  # Creates a new piece of +type+.
  def initialize(x, y, type)
    @x = x
    @y = y
    @type = type

    @rotation = 0
    @appearance = "[]"
    @blocks = []

    # Building it's blocks based on it's type.
    # (each piece has exactly 4 blocks)
    4.times do
      block = Block.new(0, 0, @appearance)
      @blocks.push block
    end
  end

  # Draws the entire piece on the screen.
  def draw
    @blocks.each do |block|
      block.draw
    end
  end
end

