require "spec_helper"
require 'quickbuild/config/runner'
require 'quickbuild/config/runner/options'

module Quickbuild::Config

RSpec.describe Runner do

  subject do
    cliOptions = RunnerOptions.new []
    Runner.new(cliOptions)
  end

  it "initialized" do
    is_expected.not_to be nil
  end

  describe '#run' do

    context 'run build' do
      FAKE_CONFIG_ID = '100'

      let(:runner_run_build_root_example) do
        cliOptions = RunnerOptions.new ['--run-build', 'root/example']
        Runner.new(cliOptions)
      end

      let(:mock_credentials) do
        allow(double('mock_credentials')).to receive(:get_credentials_for).and_return([nil, nil])
      end

      let(:mock_request_factory) do
        Request::Factory.new
      end

      let(:mock_get_configuration_id_response) do
        mock_response = double
        allow(mock_response).to receive(:ok?).and_return(true)
        allow(mock_response).to receive(:body).and_return(FAKE_CONFIG_ID)
        mock_response
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

      it "runs a build: root/example" do
        mock_request_handler = double('root/example')
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::GetConfigurationID), any_args).and_return(mock_get_configuration_id_response)
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::RunBuild), any_args).and_return(mock_run_build_response)

        mock_action_factory = Action::Factory.new(mock_request_handler, mock_request_factory, mock_credentials)
        expect(runner_run_build_root_example.run(mock_action_factory)).to eql('build request GUID')
      end

    end

  end
end

end
