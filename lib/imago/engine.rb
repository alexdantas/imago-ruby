require 'curses'

# The main interface with Curses.
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
    @has_colors = nil

    @screen = Curses::init_screen
    return nil if not @screen

    if min_width and min_height
      cur_width  = @screen.maxx
      cur_height = @screen.maxy

      if cur_width < @width or cur_height < @height
        self.exit
        $stderr << "Error: Screen size too small (#{cur_width}x#{cur_height})\n"
        $stderr << "Please resize your terminal to at least #{@width}x#{@height}\n"
        return nil
      end
    end

    @has_colors = Curses.has_colors?
    if @has_colors
      Curses.start_color
      Curses.use_default_colors # will use default background

      # Initializes:   constant          foreground             bg
      Curses.init_pair(Colors[:white],   Curses::COLOR_BLACK,   -1)
      Curses.init_pair(Colors[:blue],    Curses::COLOR_BLUE,    -1)
      Curses.init_pair(Colors[:red],     Curses::COLOR_RED,     -1)
      Curses.init_pair(Colors[:green],   Curses::COLOR_GREEN,   -1)
      Curses.init_pair(Colors[:magenta], Curses::COLOR_MAGENTA, -1)
      Curses.init_pair(Colors[:yellow],  Curses::COLOR_YELLOW,  -1)
      Curses.init_pair(Colors[:cyan],    Curses::COLOR_CYAN,    -1)
    end

    Curses::cbreak
    Curses::curs_set 0
    Curses::noecho
    Curses::nonl
    Curses::stdscr.keypad = true # extra keys
  end

  def width
    return Curses::cols
  end

  def height
    return Curses::lines
  end

  def self.exit
    Curses::refresh
    Curses::close_screen
  end

  def set_color color
    if @has_colors
      @screen.attron Curses::color_pair(color)
      return self
    else
      return nil
    end
  end

  def getchar
    return Curses::getch
  end

  # +timeout+ says how many milliseconds we wait for a key to be
  # pressed.
  def timeout timeout
    Curses::timeout = timeout
  end
end

