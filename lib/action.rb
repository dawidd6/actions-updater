# frozen_string_literal: true

require 'yaml'

class Action
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

  def self.array_from_yaml(yaml)
    hash = YAML.safe_load(yaml)
    useses = hash['jobs'].values.map do |job|
      job['steps'].map do |step|
        step['uses']
      end
    end
    useses.flatten.compact.uniq.map do |uses|
      new(uses)
    end
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
    print
  end

  def print
    "#{@user}/#{@repo}#{@dir ? '/' : ''}#{@dir}#{@ref ? '@' : ''}#{@ref}"
  end

  def print_without_ref
    "#{@user}/#{@repo}#{@dir ? '/' : ''}#{@dir}"
  end

  def ==(other)
    to_s == other.to_s
  end

  def latest_tag
    tags = `git ls-remote -t #{@url}`.scan(TAGS_REGEX).flatten
    tags.reject! do |tag|
      TAG_REJECT_REASONS.any? do |reason|
        tag.include?(reason)
      end
    end
    tags.last
  end
end
