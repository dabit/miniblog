$:.push File.expand_path('../lib', __FILE__)

require 'miniblog/version'

Gem::Specification.new do |s|
  s.name        = 'miniblog'
  s.version     = Miniblog::VERSION
  s.authors     = ['David Padilla']
  s.email       = %w(david@padilla.cc)
  s.homepage    = 'http://github.com/dabit/miniblog'
  s.summary     = 'miniblog base functionality and backend'
  s.description = 'This mountable engine has the basic functionality to manage a very simple blog'
  s.license     = 'MIT'

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w(lib app)

  s.add_dependency 'rails', '~> 4.1'

  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'carrierwave', '~> 0.10.0'
  s.add_dependency 'gravtastic'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jbuilder'
  s.add_dependency 'redcarpet', '~> 3.2.2'
  s.add_dependency 'slim'
  s.add_dependency 'state_machine', '~> 1.2.0'

  s.add_development_dependency 'capybara-webkit', '~> 1.5.0'
  s.add_development_dependency 'database_cleaner', '~> 1.4.1'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'rspec-rails', '~> 3.2.1'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov', '~> 0.9.2'
  s.add_development_dependency 'simplecov-rcov-text'
  s.add_development_dependency 'sqlite3'
end
