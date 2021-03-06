# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'http_activity/version'

Gem::Specification.new do |spec|
  spec.name          = "http_activity"
  spec.version       = HttpActivity::VERSION
  spec.authors       = ["North"]
  spec.email         = ["north@tradegecko.com"]

  spec.summary       = %q{Mornitoring on http requests}
  spec.description   = %q{Mornitoring on http requests}
  spec.homepage      = "https://www.tradegecko.com/"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "httpclient"
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "excon"
  spec.add_development_dependency "patron"
  spec.add_development_dependency "rest-client"
end
