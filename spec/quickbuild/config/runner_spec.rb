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

      let(:root_example1) do
        cliOptions = RunnerOptions.new ['--run-build', 'root/example']
        Runner.new(cliOptions)
      end

      let(:root_example2) do
        cliOptions = RunnerOptions.new ['--run-build', 'root/example2']
        Runner.new(cliOptions)
      end

      let(:mock_credentials) do
        allow(double('mock_credentials')).to receive(:get_credentials_for).and_return([nil, nil])
      end

      let(:mock_request_factory) do
        double('mock_request_factory')
      end

      let(:mock_get_configuration_id_response) do
        mock_response = double
        allow(mock_response).to receive(:ok?).and_return(true)
        allow(mock_response).to receive(:body).and_return(FAKE_CONFIG_ID)
        mock_response
      end

      let(:request_get_configuration_id) do
        Request::GetConfigurationID.new('SERVER', 'root/example')
      end

      it "runs build: root/example1" do
        mock_request_handler = double('root/example')

        allow(mock_request_handler).to receive(:execute_request).and_return(mock_get_configuration_id_response)

        allow(mock_request_factory).to receive(:create).and_return(request_get_configuration_id)

        mock_action_factory = Action::Factory.new(mock_request_handler, mock_request_factory, mock_credentials)

        expect(root_example1.run(mock_action_factory)).to eql(FAKE_CONFIG_ID)
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

      let(:request_run_build) do
        Request::RunBuild.new('SERVER', 100, VariableList.new)
      end

      it "runs another build: root/example2" do
        allow(mock_request_factory).to receive(:create).with(:get_configuration_id, any_args).and_return(request_get_configuration_id)
        allow(mock_request_factory).to receive(:create).with(:run_build, any_args).and_return(request_run_build)

        mock_request_handler = double('root/example2')
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::GetConfigurationID), any_args).and_return(mock_get_configuration_id_response)
        allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::RunBuild), any_args).and_return(mock_run_build_response)

        mock_action_factory = Action::Factory.new(mock_request_handler, mock_request_factory, mock_credentials)
        expect(root_example2.run(mock_action_factory)).to eql('build request GUID')
      end

    end

  end
end

end
