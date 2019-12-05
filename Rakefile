# frozen_string_literal: true

task default: :build

task :clean do
  sh 'rm -f *.gem'
end

task :test do
  sh 'ruby -Ilib test/*.rb'
end

task :run do
  ARGV.delete_at(0)
  sh "ruby -Ilib bin/* #{ARGV.join(' ')}"
end

task build: :clean do
  sh 'gem build *.gemspec'
end

task install: :build do
  prefix = ENV['PREFIX'] || ENV['prefix']
  ENV['GEM_HOME'] = prefix if prefix
  sh 'gem install *.gem'
end
