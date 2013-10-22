require 'imago/engine'
require 'imago/window'
require 'imago/popup'
require 'imago/block'

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
    win.box('a', 'b')
    LAYOUT[:game] = win

    block = Block.new(0, 0, "[]")

    finished = false
    while not finished
      c = Curses::getch
      case c
      when 'q'
        finished = true
      when Curses::KEY_LEFT
        block.x -= 1
      when Curses::KEY_RIGHT
        block.x += 1
      end
      LAYOUT[:game].clear
      block.draw
    end

    Engine::exit
  end
end
