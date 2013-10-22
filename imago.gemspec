# coding: utf-8

# requiring `lib` on load path
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imago/version'

Gem::Specification.new do |spec|
  spec.name          = "imago"
  spec.version       = Imago::VERSION
  spec.authors       = ["Alexandre Dantas"]
  spec.email         = ["eu@alexdantas.net"]

  spec.summary       = "Falling blocks game, T*tris clone for the console."
  spec.description   = <<END_OF_DESCRIPTION
Falling blocks game, T*tris clone for the console.
END_OF_DESCRIPTION

  spec.homepage      = "http://www.alexdantas.net/projects/imago"
  spec.license       = "GPL-3.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # "close-to-the-metal" ncurses wrapper
  spec.add_dependency "ffi-ncurses"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
