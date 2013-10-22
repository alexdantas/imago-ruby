require 'ffi-ncurses'
include FFI::NCurses

# The main interface with
#
# This acts as a middleman, abstracting away Curses' details.
class Engine

  # All possible colors.
  Colors = {
    :black   => 1,
    :white   => 2,
    :red     => 3,
    :yellow  => 4,
    :magenta => 5,
    :blue    => 6,
    :green   => 7,
    :cyan    => 8
  }.freeze

  # Initializes Ncurses with minimal +width+ and +height+.
  #
  def self.init(min_width=nil, min_height=nil)

    initscr
    return nil if not stdscr

    if min_width and min_height
      cur_width  = COLS
      cur_height = LINES

      if cur_width < @width or cur_height < @height
        self.exit
        $stderr << "Error: Screen size too small (#{cur_width}x#{cur_height})\n"
        $stderr << "Please resize your terminal to at least #{@width}x#{@height}\n"
        return nil
      end
    end

    @has_colors = has_colors
    if @has_colors
      start_color
      use_default_colors # will use default background

      # Initializes:   constant          foreground             bg
      init_pair(Colors[:white],   COLOR_BLACK,   -1)
      init_pair(Colors[:blue],    COLOR_BLUE,    -1)
      init_pair(Colors[:red],     COLOR_RED,     -1)
      init_pair(Colors[:green],   COLOR_GREEN,   -1)
      init_pair(Colors[:magenta], COLOR_MAGENTA, -1)
      init_pair(Colors[:yellow],  COLOR_YELLOW,  -1)
      init_pair(Colors[:cyan],    COLOR_CYAN,    -1)
    end

    cbreak
    curs_set 0
    noecho
    nonl
    keypad(stdscr, true) # extra keys
  end

  def self.width
    return COLS
  end

  def self.height
    return LINES
  end

  def self.exit
    refresh
    endwin
  end

  def set_color color
    if @has_colors
      attron COLOR_PAIR(color)
      return self
    end

    return nil
  end

  def self.getchar
    return getch
  end

  # How many milliseconds we wait for a key to be pressed.
  #
  # * If +time+ is 0, will run with blocking input.
  # * If +time+ is less than zero, will run with nonblocking input.
  # * If +time+ is greater than zero, will wait +time+ miliseconds.
  #
  # If +time+ elapsed and user didn't press anything, will return +nil+.
  def self.timeout time
    wtimeout(stdscr, time)
  end
end

