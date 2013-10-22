require 'imago/window'
require 'imago/engine'

# A simple centralized popup on the terminal.
class Popup < Window

  # Creates a Popup with `title` and inner `text`.
  #
  # It resizes to contain the whole text plus a 1x1 border
  # around itself.
  def initialize(title, text, border=true)
    @title = title
    @text = []
    text.each_line { |line| @text += [line.chomp] }

    max_width  = title.length
    max_height = 1

    @text.each do |line|
      max_width   = line.length if line.length > max_width
      max_height += 1
    end

    max_width  += 2 # left-right borders
    max_height += 1 # down border

    x = Engine::width/2  - max_width/2
    y = Engine::height/2 - max_height/2

    super(x, y, max_width, max_height)
    self.background ' '
    self.box if border

    self.mvaddstr_center(0, title, Engine::Colors[:cyan])

    y = 1
    @text.each do |line|
      self.mvaddstr(1, y, line)
      y += 1
    end
  end

  # Makes the Popup appear on the screen and wait for any key.
  # When it exits, clears the screen erasing itself.
  def show
    finished = false
    while not finished
      c = getch

      # This way will end no matter what the user presses
      finished = true

      # case c
      # when 'q'
      #   finished = true
      # end
    end

    stdscr.clear
    stdscr.refresh
    return false
  end
end

