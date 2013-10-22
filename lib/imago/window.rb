require 'imago/engine'

# A segment of the terminal window.
#
# BUG WARNING HACK FUCK
# Whenever I use @win.attrset/@win.setpos/@win.addch
# it doesn't work at all.
# Apparently, when I do this, Curses::getch clears up
# the entire window.
#
# DO NOT DO THIS
#
class Window
  attr_reader :width, :height

  # Creates a Window at `x` `y` `w` `h`.
  def initialize(x, y, w, h)
    @win = Curses::Window.new(h, w, y, x)
    @width  = w
    @height = h
  end

  # Sets the current color of the Window.
  def set_color color
    Curses::attrset(Curses::color_pair color)
  end

  # Executes a block of code encapsulated within a color on/off.
  # Note that the color can be overrided.
  def with_color(color=nil)
    Curses::attron(Curses::color_pair color) if color
    yield
    Curses::attroff(Curses::color_pair color) if color
  end

  # Puts a character +c+ on (+x+, +y+) with optional +color+.
  def mvaddch(x, y, c, color=nil)
    return if x < 0 or x >= @width
    return if y < 0 or y >= @height

    self.with_color color do
      Curses::setpos(@win.begy + y, @win.begx + x)
      Curses::addch c
    end
  end

  # Puts a string +str+ on (+x+, +y+) with optional +color+.
  def mvaddstr(x, y, str, color=nil)
    return if x < 0 or x >= @width
    return if y < 0 or y >= @height

    self.with_color color do
#      @win.setpos(@win.begy + y, @win.begx + x)
#      @win.addstr str
      Curses::setpos(@win.begy + y, @win.begx + x)
      Curses::addstr str
    end
  end

  # Puts a string +str+ centered on +y+ with optional +color+.
  def mvaddstr_center(y, str, color=nil)
    x = (@width/2) - (str.length/2)
    self.mvaddstr(x, y, str, color)
  end

  def mvaddstr_left(y, str, color=nil)
    self.mvaddstr(0, y, str, color)
  end

  def mvaddstr_right(y, str, color=nil)
    x = @width - str.length
    self.mvaddstr(x, y, str, color)
  end

  # Erases all of the Window's contents
  def clear
    @win.clear
  end

  # Commits the changes on the Window.
  def refresh
    # Y U NO WORK
    # @win.refresh
    Curses::refresh
  end

  # Moves window so that the upper-left corner is at `x` `y`.
  def move(x, y)
    @win.move(y, x)
  end

  # Resizes window to +width+ and +h+eight.
  def resize(w, h)
    @win.resize(h, w)
    @width  = w
    @height = h
  end

  # Set block/nonblocking reads for window.
  #
  # * If `delay` is negative, blocking read is used.
  # * If `delay` is zero, nonblocking read is used.
  # * If `delay` is positive, waits for `delay` milliseconds and
  #   returns ERR of no input.
  def timeout(delay=-1)
    @win.timeout = delay
  end

  def background char
    @win.bkgd char
    @win.refresh
  end

  # Sets the Window border.
  #
  # * If all arguments are set, that's ok.
  # * If only the first 2 arguments are set, they are the vertical
  #   and horizontal chars.
  #
  def box(horizontal=0, vertical=0)
    @win.box(horizontal, vertical)
    @win.refresh
  end
end

