# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cekresi/version'

Gem::Specification.new do |spec|
  spec.name          = "cekresi"
  spec.version       = Cekresi::VERSION
  spec.authors       = ["Mada Aryakusumah"]
  spec.email         = ["mada@41studio.com"]

  spec.summary       = %q{Tracking AWB number use http://cekresi.com.}
  spec.description   = %q{Ruby helper for get data from http://cekresi.com.}
  spec.homepage      = "http://rubygems.org/gems/cekresi"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "capybara", '~> 2.7', ">= 2.7.1"
  spec.add_development_dependency 'poltergeist', '~> 1.9', ">= 1.9.0"
end
