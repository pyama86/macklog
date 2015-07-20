# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'macklog/version'

Gem::Specification.new do |spec|
  spec.name          = "macklog"
  spec.version       = Macklog::VERSION
  spec.authors       = ["kazuhiko yamahsita"]
  spec.email         = ["pyama@pepabo.com"]

  spec.summary       = %q{mackerel log watch plugin.}
  spec.description   = %q{mackerel log watch plugin }
  spec.homepage      = "http://tem-snapon.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_dependency "thor"
end
