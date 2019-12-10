# frozen_string_literal: true

task default: :build

task :clean do
  sh 'rm -f *.gem'
end

task :test do
  sh 'rspec'
end

task :release do
  ARGV.delete_at(0)
  version = ARGV.last
  exit 1 unless version

  sh "echo #{version} > VERSION"
  sh 'git add VERSION'
  sh "git commit -S -m v#{version}"
  sh "git tag v#{version}"
  exit
end

task :run do
  ARGV.delete_at(0)
  sh "ruby -Ilib bin/* #{ARGV.join(' ')}"
  exit
end

task build: :clean do
  sh 'gem build *.gemspec'
end

task install: :build do
  prefix = ENV['PREFIX'] || ENV['prefix']
  ENV['GEM_HOME'] = prefix if prefix
  sh 'gem install *.gem'
end

task install_dev: :build do
  prefix = ENV['PREFIX'] || ENV['prefix']
  ENV['GEM_HOME'] = prefix if prefix
  sh 'gem install --development *.gem'
end
