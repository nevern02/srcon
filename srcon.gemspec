
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "srcon/version"

Gem::Specification.new do |spec|
  spec.name          = "srcon"
  spec.version       = Srcon::VERSION
  spec.authors       = ["Brandon R."]
  spec.email         = ["brandon@blrice.net"]

  spec.summary       = %q{A socket library implementing the Steam RCON protocol.}
  spec.description   = %q{A socket library implementing the Steam RCON protocol.}
  spec.homepage      = "https://github.com/nevern02/srcon"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.7"
  spec.add_development_dependency "pry",     "~> 0.11"
end
