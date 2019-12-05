# frozen_string_literal: true

require 'test/unit'
require 'action'

class ActionTest < Test::Unit::TestCase
  def test_action_parsing
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

    expected = %w[
      dawidd6/action-closing-commit@v2.1.2
      dawidd6/action-delete-branch@v2.0.0
      dawidd6/action-delete-branch@v2.0.1
    ]
    got = Action.array_from_yaml(yaml)

    expected.each_index do |i|
      assert_equal expected[i], got[i].to_s
    end
  end

  def test_action_splitting
    cases = {
      {
        user: 'user1',
        repo: 'repo1',
        dir: nil,
        ref: 'master'
      } => Action.new('user1/repo1@master'), {
        user: 'user2',
        repo: 'repo2',
        dir: 'dir2',
        ref: 'master'
      } => Action.new('user2/repo2/dir2@master'), {
        user: 'user3',
        repo: 'repo3',
        dir: nil,
        ref: 'v1'
      } => Action.new('user3/repo3@v1'), {
        user: 'user4',
        repo: 'repo4',
        dir: nil,
        ref: '2.1.1'
      } => Action.new('user4/repo4@2.1.1')
    }

    cases.each do |expected, got|
      expected.keys.each do |key|
        assert_equal expected[key], got.method(key).call
      end
    end
  end
end
