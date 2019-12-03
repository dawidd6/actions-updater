# frozen_string_literal: true

require 'optparse'
require 'yaml'
require_relative 'lib.rb'

newer = false
write = false
OptionParser.new do |parser|
  parser.banner += ' workflows ...'
  parser.on('-n', '--newer', 'deal only with actions that have an update') do
    newer = true
  end
  parser.on('-w', '--write', 'write updates back to workflow files') do
    write = true
  end
end.parse!

ARGV.each do |path|
  puts "==> #{path}"
  yaml = File.read(path)
  hash = YAML.safe_load(yaml)
  uses_all(hash).each do |uses|
    user, repo, ref = uses_split(uses)
    tag = latest_tag(user, repo)

    next if tag == ref && newer

    puts "#{user}/#{repo} : #{ref} --> #{tag}"

    next unless write

    new_yaml = yaml.gsub(/#{uses}$/, uses_join(user, repo, tag))
    File.open(path, 'w') { |f| f.puts new_yaml }
  end
end
