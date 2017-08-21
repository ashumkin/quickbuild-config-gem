require 'shared/common'
require 'shared/run'

module Quickbuild::Config

RSpec.shared_context 'list and export' do

  include_context 'run'

  def create_get_configuration_path_response(configuration_id)
    mock_response = double
    allow(mock_response).to receive(:ok?).and_return(true)
    allow(mock_response).to receive(:body) do
      FAKE_CONFIG_PATHS[configuration_id]
    end
    mock_response
  end

  let(:mock_list_configuration_response_text) do
    FAKE_CONFIG_LIST_RESPONSE
  end

  let(:mock_list_configuration_response) do
    mock_response = double
    allow(mock_response).to receive(:ok?).and_return(true)
    allow(mock_response).to receive(:body).and_return(mock_list_configuration_response_text)
    mock_response
  end

end

end
