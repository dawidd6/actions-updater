# frozen_string_literal: true

class Uses
  attr_accessor :user, :repo, :dir, :ref
  attr_reader :url

  USES_REGEX = %r{^(?<user>[^/]+)[/](?<repo>[^/]+)[/]?(?<dir>.+)?[@](?<ref>.+)$}.freeze
  TAGS_REGEX = %r{refs/tags/(.*)$}.freeze
  DOMAIN = 'https://github.com'
  TAG_REJECT_REASONS = %w[
    alpha
    beta
    rc
    ^{}
  ].freeze

  def self.from_hash(hash)
    hash['jobs'].values.map do |j|
      j['steps'].map do |s|
        s['uses']
      end
    end.flatten.compact.uniq
  end

  def ==(other)
    to_s == other.to_s
  end

  def initialize(uses)
    captures = uses.match(USES_REGEX).named_captures
    @user = captures['user']
    @repo = captures['repo']
    @dir = captures['dir']
    @ref = captures['ref']
    @url = "#{DOMAIN}/#{@user}/#{@repo}"
  end

  def to_s
    "#{@user}/#{@repo}#{@dir ? '/' : ''}#{@dir}#{@ref ? '@' : ''}#{@ref}"
  end

  def latest_tag
    tags = `git ls-remote -t #{@url}`.scan(TAGS_REGEX).flatten
    tags = tags.reject do |tag|
      reject = false
      TAG_REJECT_REASONS.each do |reason|
        if tag.include?(reason)
          reject = true
          break
        end
      end
      reject
    end
    tags[-1]
  end
end
