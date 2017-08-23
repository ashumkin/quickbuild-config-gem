require "spec_helper"
require 'quickbuild/error'

module Quickbuild::Config

RSpec.describe Request::GetConfigurationID do

  subject do
    Request::GetConfigurationID.new(server: :server, configuration: :name)
  end

  describe '#request_method' do

    it 'request_method is GET' do
      expect(subject.request_method).to eql :get
    end

  end

  describe '#response_handler' do

    it 'raises an error while handling an empty response' do
      mock_response_empty = double('empty response')
      allow(mock_response_empty).to receive(:body).and_return('')

      expect{ subject.response_handler.do_handle(mock_response_empty) }.to raise_error(Quickbuild::Error::NoConfigurationByPath)


    end

  end

end

end
