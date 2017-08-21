require "spec_helper"
require 'quickbuild/config/runner'
require 'quickbuild/config/runner/options'
require 'quickbuild/config/result_saver'
require 'shared/list_and_export'

module Quickbuild::Config

RSpec.describe Runner do

  describe '#run' do

    context 'list configurations' do

      include_context 'list and export'

      let(:mock_list_request_handler) do
        mock_request_handler = double('root/list/configuration-1')
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::ListConfigurations), any_args).and_return(mock_list_configuration_response)
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::GetConfigurationPath), any_args) do |request, args|
          create_get_configuration_path_response(request.configuration_id)
        end
        mock_request_handler
      end

      let(:runner_list) do
        cliOptions = RunnerOptions.new ['--list', 'root/list/configuration-1', 'root/list/configuration-2']
        Runner.new(cliOptions)
      end

      it 'lists configurations' do
        mock_action_factory = Action::Factory.new(mock_list_request_handler, mock_request_factory, mock_credentials)
        expect(runner_list.run(mock_action_factory, mock_result_saver)).to eql(['root', 'root/level-1', 'root/level-1/level-2', 'root/level-1-2'])
      end

    end

  end
end

end
