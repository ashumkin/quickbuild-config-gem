require "spec_helper"
require 'quickbuild/config/runner'
require 'quickbuild/config/runner/options'
require 'quickbuild/config/result_saver'
require 'shared/common'
require 'shared/list_and_export'

module Quickbuild::Config

RSpec.describe Runner do

  describe '#run' do

    context 'export configuration' do
      include_context 'list and export'

      let(:mock_export_configuration_response_text) do
        <<RESPONSE
<?xml version="1.0" encoding="UTF-8"?>

<com.pmease.quickbuild.model.Configuration>
  <id>1</id>
  <concurrent>false</concurrent>
  <disabled>false</disabled>
  <name>root</name>
...
RESPONSE
      end

      let(:mock_export_configuration_response) do
        mock_response = double
        allow(mock_response).to receive(:ok?).and_return(true)
        allow(mock_response).to receive(:body).and_return(mock_export_configuration_response_text)
        mock_response
      end

      let(:runner_export_1) do
        cliOptions = RunnerOptions.new ['--export', 'root/export/configuration-1']
        Runner.new(cliOptions)
      end

      let(:mock_request_handler) do
        mock_request_handler = double('root/export/configuration-1')
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::GetConfigurationID), any_args).and_return(mock_get_configuration_id_response)
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::ExportConfiguration), any_args) do |request|
          expect(request.configuration_id).to eql FAKE_CONFIG_ID
          mock_export_configuration_response
        end
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::ListConfigurations), any_args).and_return(mock_list_configuration_response)
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::GetConfigurationPath), any_args) do |request, args|
          create_get_configuration_path_response(request.configuration_id)
        end
        mock_request_handler
      end

      it 'exports a configuration' do
        mock_action_factory = Action::Factory.new(mock_request_handler, mock_request_factory, mock_credentials)
        expect(runner_export_1.run(mock_action_factory, mock_result_saver)).to eql([ 'root/export/configuration-1' ])
      end

      let(:runner_export_all) do
        cliOptions = RunnerOptions.new ['--export', '*']
        Runner.new(cliOptions)
      end

      let(:mock_export_result_saver) do
        result_saver = double('mock_result_saver')
        allow(result_saver).to receive(:save).with(/root(\/level-1(\/level-2)?)?/, any_args)
        result_saver
      end

      it 'exports all configurations' do
        mock_action_factory = Action::Factory.new(mock_request_handler, mock_request_factory, mock_credentials)
        expect(runner_export_all.run(mock_action_factory, mock_export_result_saver)).to eql(['root', 'root/level-1', 'root/level-1/level-2', 'root/level-1-2'])
      end

    end

  end
end

end
