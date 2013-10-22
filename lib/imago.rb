require 'imago/engine'
require 'imago/window'
require 'imago/popup'

module Imago
  # All the windows of the game
  @@layout = {}

  # Main function of the game.
  # Initializes engine and runs the main game loop.
  def self.run

    Engine::init
    Engine::timeout 50

    win = Window.new(0, 0, 80, 24)
    win.background '.'
    win.box('a', 'b')
    @@layout[:main] = win

    finished = false
    while not finished
      c = Curses::getch
      case c
      when 'q'
        finished = true
      end
    end

    Engine::exit
  end
end
