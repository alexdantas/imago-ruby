require 'imago/engine'
require 'imago/window'
require 'imago/popup'
require 'imago/piece'

module Imago
  # All the windows of the game
  LAYOUT = {}

  # Main function of the game.
  # Initializes engine and runs the main game loop.
  def self.run

    Engine::init
    Engine::timeout 50

    LAYOUT[:game] = Window.new(0, 0, 80, 24)

    piece = Piece.new(5, 5, Piece::Type[:S], LAYOUT[:game])

    finished = false
    while not finished
      c = getch
      case c
      when 'q'.ord
        finished = true
      when KEY_LEFT
        piece.x -= 1
      when KEY_RIGHT
        piece.x += 1
      when KEY_UP
        piece.y -= 1
      when KEY_DOWN
        piece.y += 1
      end
      LAYOUT[:game].clear
      LAYOUT[:game].background '.'
      LAYOUT[:game].border
      piece.draw
      LAYOUT[:game].refresh
    end

    Engine::exit
  end
end
