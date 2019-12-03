# frozen_string_literal: true

def uses_split(uses)
  regex = %r{^(?<user>[^/]+)[/](?<repo>[^/]+)[/]?(?<dir>.+)?[@](?<ref>.+)$}
  captures = uses.match(regex).named_captures
  [captures['user'], captures['repo'], captures['dir'], captures['ref']]
end

def uses_join(user, repo, dir, ref)
  "#{user}/#{repo}#{dir ? '/' : ''}#{dir}@#{ref}"
end

def latest_tag(user, repo)
  url = "https://github.com/#{user}/#{repo}"
  regex = %r{refs/tags/(.*)$}
  tags = `git ls-remote -t #{url}`.scan(regex).flatten
  tags[-1]
end

def uses_all(hash)
  uses = []
  hash['jobs'].each_value do |job|
    job['steps'].each do |step|
      uses << step['uses'] if step['uses']
    end
  end
  uses.uniq.compact
end
