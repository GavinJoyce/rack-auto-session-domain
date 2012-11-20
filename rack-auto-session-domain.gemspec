# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack-auto-session-domain/version'

Gem::Specification.new do |gem|
  gem.name          = "rack-auto-session-domain"
  gem.version       = Rack::AutoSessionDomain::VERSION
  gem.authors       = ["Gavin Joyce"]
  gem.email         = ["gavinjoyce@gmail.com"]
  gem.description   = "Automatically sets the rack session domain to the current request domain"
  gem.summary       = "Automatically sets the rack session domain to the current request domain"
  gem.homepage      = "https://github.com/GavinJoyce/rack-auto-session-domain"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'domainatrix', '>= 0.0.11'
  gem.add_development_dependency 'rack'
  gem.add_development_dependency 'rack/test'
  gem.add_development_dependency 'rspec', '~> 2.12'
end
