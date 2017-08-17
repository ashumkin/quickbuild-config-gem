# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "quickbuild/config/version"

Gem::Specification.new do |spec|
  spec.name          = "quickbuild-config"
  spec.version       = Quickbuild::Config::VERSION
  spec.authors       = ["Alexey Shumkin"]
  spec.email         = ["Alex.Crezoff@gmail.com"]

  spec.summary       = %q{Save Quickbuild configurations. Run builds}
  spec.description   = %q{Use Quickbuild REST API to backup configurations, run builds, add new configurations based on projects templates}
  spec.homepage      = "http://github.com/ashumkin/quickbuild-config"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
