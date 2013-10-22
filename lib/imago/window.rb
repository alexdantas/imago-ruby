require 'ffi-ncurses'
include FFI::NCurses

# A 2D segment of the terminal window.
#
class Window
  attr_reader :width, :height

  # Creates a Window at `x` `y` `w` `h`.
  def initialize(x, y, w, h)
    @win = newwin(h, w, y, x)
    @width  = w
    @height = h
  end

  # Sets the current color of the Window.
  def set_color color
    attrset COLOR_PAIR(color)
  end

  # Executes a block of code encapsulated within a color on/off.
  # Note that the color can be overrided.
  def with_color(color=nil)
    wattron(@win, COLOR_PAIR(color)) if color
    yield
    wattroff(@win, COLOR_PAIR(color)) if color
  end

  # Puts a character +c+ on (+x+, +y+) with optional +color+.
  def mvaddch(x, y, c, color=nil)
    return if x < 0 or x >= @width
    return if y < 0 or y >= @height

    self.with_color color do
      wmove(@win, y, x)
      waddch(@win,  c)
    end
  end

  # Puts a string +str+ on (+x+, +y+) with optional +color+.
  def mvaddstr(x, y, str, color=nil)
    return if x < 0 or x >= @width
    return if y < 0 or y >= @height

    self.with_color color do
#      @win.setpos(@win.begy + y, @win.begx + x)
#      @win.addstr str
      wmove(@win, y, x)
      waddstr(@win, str)
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
    werase @win
  end

  # Commits the changes on the Window.
  def refresh
    wrefresh @win
  end

  # Moves window so that the upper-left corner is at `x` `y`.
  def move(x, y)
    wmove(@win, y, x)
  end

  # Resizes window to +width+ and +h+eight.
  def resize(w, h)
    wresize(@win, h, w)
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
    wtimeout(@win, delay)
  end

  # Sets the background char of the window.
  def background char
    wbkgd(@win, char.ord)
    self.refresh
  end

  # Sets the Window border.
  #
  # * If all arguments are set, that's ok.
  # * If only the first 2 arguments are set, they are the vertical
  #   and horizontal chars.
  #
  def border(horizontal=0, vertical=0)
    box(@win, vertical.ord, horizontal.ord)
    self.refresh
  end
end

