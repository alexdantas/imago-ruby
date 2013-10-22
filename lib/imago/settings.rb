require 'optparse'
require 'imago/version'

# Global configurations of the program, along with a commandline
# argument parser.
#
# Contains the program's specific configuration rules.
#
# Usage:
#   settings = Settings.new
#   settings.parse ARGV
#   ...
#   a = settings[:your_custom_setting]
#
class Settings

  # Creates a configuration, with default values.
  def initialize
    @settings = {}

  end

  # Sets options based on commandline arguments `args`.
  # It should be `ARGV`.
  def parse args

    opts = OptionParser.new do |parser|
      parser.banner = "Usage: imago [options]"

      # Make output beautiful
      parser.separator ""
      parser.separator "Options:"

      # These options appear if no other is given.
      parser.on_tail("-h", "--help", "Show this message") do
        puts parser
        exit
      end

      parser.on_tail("--version", "Show version") do
        puts "imago #{Imago::VERSION}"
        exit
      end
    end
    opts.parse! args

    return @settings
  end

  # Returns a specific setting previously set.
  def [] name
    return @settings[name]
  end
end

