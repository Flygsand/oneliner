# -*- coding: utf-8 -*-

require 'rake'

Gem::Specification.new do |gem|
  gem.name              = 'oneliner'
  gem.version           = '0.9.0'
  gem.date              = '2010-11-03'
  gem.summary           = 'Simple command-line application framework'
  gem.description       = 'oneliner is a stupid simple framework for building command-line tools'
  
  gem.authors           = ["Martin Häger"]
  gem.email             = 'martin.haeger@gmail.com'
  gem.homepage          = 'http://github.com/mtah/oneliner'
  
  gem.require_paths     = %w[lib]
  gem.files             = FileList['lib/**/*.rb', 'spec/**/*', 'Rakefile', 'Gemfile', 'oneliner.gemspec', 'README.md']

  gem.rubyforge_project = 'nowarning' # stop complaining already!
  gem.platform          = Gem::Platform::RUBY
end
