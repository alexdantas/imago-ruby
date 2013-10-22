require 'imago/engine'
require 'imago/window'
require 'imago/popup'

module Imago
  # Main function of the game.
  # Initializes engine and runs the main game loop.
  def self.run

    Engine::init

    text = <<END
dsoadsad
sadosapdjsadosaj
dsadjsadjsaidjsaoijdosjaoidjiosadoisajdas
END
    popup = Popup.new("title", text)
    popup.show

    Engine::exit
  end
end
