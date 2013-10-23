require 'imago/block'
require 'imago/pieces_definition'

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
    :O => 0,
    :I => 1,
    :L => 2,
    :J => 3,
    :S => 4,
    :Z => 5,
    :T => 6
  }.freeze

  attr_reader :blocks

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
    #
    # Each piece definition is a 5x5 matrix with values 0, 1 and 2.
    # It contains the piece's shape.
    #
    # * 0 means an empty slot, will be ignored
    # * 1 means a block, will be inserted
    # * 2 means the pivot block, nothing special
    k = 0

    5.times do |i|
      5.times do |j|
        if $global_pieces[@type][@rotation][j][i] != 0

          # we multiply by 2 for pretty-printing on the terminal
          block_x = (@x + i) * 2
          block_y = (@y + j)

          block = Block.new(block_x, block_y, @appearance, window)
          @blocks.push block

          k += 1
        end
      end
    end

  end

  # Draws the entire piece on the screen.
  def draw
    @blocks.each do |block|
      block.draw
    end
  end

  # Drops piece by one tile.
  def soft_drop
    @y += 1
    @blocks.each { |block| block.y += 1 }
  end

  # Moves Piece sideways.
  #
  # 0 is left, 1 is right.
  def move_sideways direction
    delta = (direction == 0) ? -1 : 1

    @x += delta
    @blocks.each { |block| block.x += delta }
  end
end

