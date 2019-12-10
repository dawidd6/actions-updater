# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'actions-updater'
  s.version = File.read('VERSION')
  s.summary = 'Updater of used Github Actions in workflow files'
  s.authors = ['Dawid Dziurla']
  s.licenses = ['MIT']
  s.homepage = "https://github.com/dawidd6/#{s.name}"
  s.files = Dir.glob('lib/*.rb') << 'VERSION'
  s.executables = [s.name]
  s.add_runtime_dependency 'colorize', '~> 0.8'
  s.add_development_dependency 'bundler', '>= 1.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
end
