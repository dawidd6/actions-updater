# frozen_string_literal: true

require 'optparse'
require 'yaml'
require_relative 'lib.rb'

OptionParser.new do |parser|
  parser.banner += ' workflows ...'
  parser.on('-n', '--newer', 'deal only with actions that have an update') do
    @newer = true
  end
  parser.on('-w', '--write', 'write updates back to workflow files') do
    @write = true
  end
end.parse!

ARGV.each do |path|
  puts "==> #{path}"
  yaml = File.read(path)
  hash = YAML.safe_load(yaml)
  Uses.from_hash(hash).each do |uses|
    current_uses = Uses.new(uses)
    new_uses = Uses.new(uses)
    new_uses.ref = current_uses.latest_tag

    next if current_uses == new_uses && @newer

    puts "#{current_uses} -> #{new_uses}"

    next unless @write

    yaml = yaml.gsub(/#{current_uses}/, new_uses.to_s)
    File.open(path, 'w') { |f| f.puts yaml }
  end
end
