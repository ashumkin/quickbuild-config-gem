require 'shared/common'

module Quickbuild::Config

RSpec.shared_context 'run' do

  let(:mock_request_factory) do
    Request::Factory.new
  end

  let(:mock_credentials) do
    allow(double('mock_credentials')).to receive(:get_credentials_for).and_return({login: nil, password: nil})
  end

  let(:mock_get_configuration_id_response) do
    mock_response = double
    allow(mock_response).to receive(:ok?).and_return(true)
    allow(mock_response).to receive(:body).and_return(FAKE_CONFIG_ID)
    mock_response
  end

  let(:mock_get_configuration_id_request_handler) do
    mock_request_handler = double('request_handler')
    allow(mock_request_handler).to receive(:execute_request).with(instance_of(Request::GetConfigurationID), any_args).and_return(mock_get_configuration_id_response)
    mock_request_handler
  end

  let(:mock_result_saver) do
    result_saver = double('result_saver')
    allow(result_saver).to receive(:save)
    result_saver
  end

end

end
