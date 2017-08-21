require "spec_helper"
require 'quickbuild/config/runner'
require 'quickbuild/config/runner/options'
require 'quickbuild/config/result_saver'
require 'shared/common'
require 'shared/run'

module Quickbuild::Config

RSpec.describe Runner do

  describe '#run' do

    context 'run build' do

      include_context 'run'

      let(:runner_run_build_root_example) do
        cliOptions = RunnerOptions.new ['--run-build', 'root/example']
        Runner.new(cliOptions)
      end

      let(:mock_run_build_response) do
        mock_response = double
        allow(mock_response).to receive(:ok?).and_return(true)
        allow(mock_response).to receive(:body).and_return(<<-RESPONSE
<?xml version="1.0" encoding="UTF-8"?>

<com.pmease.quickbuild.RequestResult>
  <requestId>build request GUID</requestId>
  <loopedRequest>false</loopedRequest>
</com.pmease.quickbuild.RequestResult>
RESPONSE
)
        mock_response
      end

      let(:mock_run_build_request_handler) do
        mock_request_handler = mock_get_configuration_id_request_handler
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::RunBuild), any_args) do |request|
          expect(request.configuration_id).to eql FAKE_CONFIG_ID
          mock_run_build_response
        end
        mock_request_handler
      end

      it "runs a build: root/example" do
        mock_action_factory = Action::Factory.new(mock_run_build_request_handler, mock_request_factory, mock_credentials)
        expect(runner_run_build_root_example.run(mock_action_factory, mock_result_saver)).to eql('build request GUID')
      end

    end

  end
end

end
