$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'pptx_markdown/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pptx_markdown'
  s.version     = PPTXMarkdown::VERSION
  s.authors     = ['Sergey Novikov']
  s.email       = ['novikov359@gmail.com']
  s.homepage    = 'https://github.com/droptheplot/pptx_markdown'
  s.summary     = 'PPTX <-> Markdown'
  s.license     = 'MIT'
  s.executables = ['pptx_markdown']

  s.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'nokogiri', '1.6.8'
  s.add_dependency 'rubyzip', '1.2.0'
  s.add_dependency 'thor', '0.19.1'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'rubocop'
end
