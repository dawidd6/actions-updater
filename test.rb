# frozen_string_literal: true

require 'yaml'
require 'test/unit'
require_relative 'lib.rb'

class UsesTest < Test::Unit::TestCase
  def test_uses_all
    yaml = %(
      name: Cleaning

      on:
        push:
          branches:
            - master
          paths:
            - 'Formula/*.rb'

      jobs:
        clean:
          runs-on: ubuntu-latest
          steps:
            - name: Get numbers
              id: numbers
              uses: dawidd6/action-closing-commit@v2.1.2
            - name: Delete head branches
              uses: dawidd6/action-delete-branch@v2.0.0
              with:
                numbers: ${{steps.numbers.outputs.numbers}}
            - name: Delete pr-* branches
              uses: dawidd6/action-delete-branch@v2.0.1
              with:
                branches: ${{steps.numbers.outputs.numbers}}
                prefix: pr-
    )
    hash = YAML.safe_load(yaml)

    expected = %w[
      dawidd6/action-closing-commit@v2.1.2
      dawidd6/action-delete-branch@v2.0.0
      dawidd6/action-delete-branch@v2.0.1
    ]
    got = uses_all(hash)

    assert_equal expected.sort, got.sort
  end

  def test_uses_split
    uses = %w[
      user1/repo1@master
      user2/repo2/dir@master
      user3/repo3@v1
      user4/repo4@2.1.1
    ]

    expected = [
      ['user1', 'repo1', nil, 'master'],
      %w[user2 repo2 dir master],
      ['user3', 'repo3', nil, 'v1'],
      ['user4', 'repo4', nil, '2.1.1']
    ]
    got = uses.map { |u| uses_split(u) }

    assert_equal expected.sort, got.sort
  end

  def test_uses_join
    expected = %w[
      user1/repo1@master
      user2/repo2/dir@master
      user3/repo3@v1
      user4/repo4@2.1.1
    ]
    got = [
      uses_join('user1', 'repo1', nil, 'master'),
      uses_join('user2', 'repo2', 'dir', 'master'),
      uses_join('user3', 'repo3', nil, 'v1'),
      uses_join('user4', 'repo4', nil, '2.1.1')
    ]

    assert_equal expected.sort, got.sort
  end
end
