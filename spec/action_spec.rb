# frozen_string_literal: true

require 'action'

describe Action do
  describe '.array_from_yaml' do
    it 'returns array of Actions parsed from given YAML' do
      yaml = %(
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

      expect(Action.array_from_yaml(yaml)).to eq(
        %w[
          dawidd6/action-closing-commit@v2.1.2
          dawidd6/action-delete-branch@v2.0.0
          dawidd6/action-delete-branch@v2.0.1
        ]
      )
    end
  end

  describe '.new' do
    context 'parses given "uses" field of YAML' do
      it 'tests case 1' do
        action = Action.new('user1/repo1@master')

        expect(action.user).to eq('user1')
        expect(action.repo).to eq('repo1')
        expect(action.dir).to be_nil
        expect(action.ref).to eq('master')
      end

      it 'tests case 2' do
        action = Action.new('user2/repo2/dir2@master')

        expect(action.user).to eq('user2')
        expect(action.repo).to eq('repo2')
        expect(action.dir).to eq('dir2')
        expect(action.ref).to eq('master')
      end

      it 'tests case 3' do
        action = Action.new('user3/repo3@v1')

        expect(action.user).to eq('user3')
        expect(action.repo).to eq('repo3')
        expect(action.dir).to be_nil
        expect(action.ref).to eq('v1')
      end

      it 'tests case 4' do
        action = Action.new('user4/repo4@2.1.1')

        expect(action.user).to eq('user4')
        expect(action.repo).to eq('repo4')
        expect(action.dir).to be_nil
        expect(action.ref).to eq('2.1.1')
      end
    end
  end
end
