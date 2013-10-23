require 'imago/block'
require 'imago/piece'

# The game board, containing all the blocks.
class Board

  # Creates a new Board on +window+.
  def initialize(x, y, width, height, window)

    @window = window

    @blocks = Array.new(width, nil) { Array.new(height, nil) }

    width.times do |i|
      height.times do |j|
        block = Block.new((i * 2), j, "[]", window, Block::Type[:EMPTY])

        @blocks[i][j] = block
      end
    end
  end

  # Shows the Board's contents.
  def draw
    @blocks.each do |line|
      line.each do |block|
        block.draw
      end
    end
  end

  # Locks +piece+ into the Board, copying each of it's
  # individual blocks.
  def lock_piece piece
    piece.blocks.each do |block|
      @blocks[block.x][block.y] = block.clone
    end
  end
end

