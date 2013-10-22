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

    win = Window.new(0, 0, 80, 24)
    win.background '.'
    win.border('a', 'b')
    LAYOUT[:game] = win

    piece = Piece.new(0, 0, Piece::Type[:S])

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
      piece.draw
    end

    Engine::exit
  end
end
