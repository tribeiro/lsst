require 'rspec/bash'

describe 'n8l::has_cmd' do
  include Rspec::Bash

  let(:stubbed_env) { create_stubbed_env }
  subject(:func) { 'n8l::has_cmd' }

  context 'parameters' do
    context '$1/command' do
      it 'is required' do
        out, err, status = stubbed_env.execute_function(
          'scripts/newinstall.sh',
          func,
        )

        expect(status.exitstatus).to_not be 0
        expect(out).to eq('')
        expect(err).to match(/command is required/)
      end

      it 'is passed to `command`' do
        command = stubbed_env.stub_command('command')

        out, err, status = stubbed_env.execute_function(
          'scripts/newinstall.sh',
          "#{func} batman",
        )

        expect(status.exitstatus).to be 0
        expect(out).to eq('')
        expect(err).to eq('')

        expect(command).to be_called_with_arguments.times(1)
        expect(command).to be_called_with_arguments('-v', 'batman')
      end
    end
  end
end
