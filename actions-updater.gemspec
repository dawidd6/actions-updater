# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'actions-updater'
  s.version = '0.1.4'
  s.summary = 'Updater of used Github Actions in workflow files'
  s.authors = ['Dawid Dziurla']
  s.licenses = ['MIT']
  s.homepage = "https://github.com/dawidd6/#{s.name}"
  s.files = Dir.glob('lib/*.rb')
  s.executables = [s.name]
end
