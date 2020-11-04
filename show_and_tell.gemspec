# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "show_and_tell/version"

Gem::Specification.new do |spec|
  spec.name          = "show_and_tell"
  spec.version       = ShowAndTell::VERSION
  spec.authors       = ["Donald Merand"]
  spec.email         = ["dmerand@explo.org"]

  spec.summary       = 'Rails utility to unify front-end display and validation of linked fields'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.11"

  spec.add_dependency "activemodel", "~> 6.0"
  spec.add_dependency "activesupport", "~> 6.0"
end
