require_relative 'lib/media_transfer/version'

Gem::Specification.new do |s|
  s.name        = 'media_transfer'
  s.version     = MediaTransfer::VERSION
  s.summary     = 'Media transfer'
  s.description = 'CLI for transfer media files from SD cards to HDD'
  s.authors     = ['PsixokoT']
  s.email       = 'psixo_kot@mail.ru'
  s.files       = ['lib/media_transfer.rb']
  s.homepage    = 'https://github.com/PsixokoT/media_transfer'
  s.license     = 'MIT'
  
  s.add_dependency 'cli-ui', '~> 1.5'
  s.add_dependency 'win32ole', '~> 1.8'
end