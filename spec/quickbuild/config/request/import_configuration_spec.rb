require "spec_helper"

module Quickbuild::Config

RSpec.describe Request::ImportConfiguration do

  describe '#request_method' do

    it 'request_method is POST' do
      request = Request::ImportConfiguration.new(server: :server)
      expect(request.request_method).to eql :post
    end

  end

  describe '#body' do

    let(:expected_body) do
      <<BODY
<com.pmease.quickbuild.model.Configuration>
  <id>2</id>
  
</com.pmease.quickbuild.model.Configuration>
BODY
    end

    it 'contains no variable and not promoted' do
      request = Request::ImportConfiguration.new(server: :server, configuration_id: 2)
      expect(request.body).to eql expected_body
    end

  end

end

end
