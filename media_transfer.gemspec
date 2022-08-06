lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'media_transfer/version'

Gem::Specification.new do |s|
  s.name        = 'media_transfer'
  s.version     = MediaTransfer::VERSION
  s.summary     = 'Media transfer'
  s.description = 'CLI for transfer media files from SD cards to HDD'
  s.authors     = ['PsixokoT']
  s.email       = 'psixo_kot@mail.ru'
  s.files       = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt']
  s.homepage    = 'https://github.com/PsixokoT/media_transfer'
  s.license     = 'MIT'

  s.metadata['homepage_uri'] = s.homepage
  s.require_paths = ['lib']
  
  s.add_dependency 'cli-ui', '~> 1.5'
  s.add_dependency 'win32ole', '~> 1.8'
end