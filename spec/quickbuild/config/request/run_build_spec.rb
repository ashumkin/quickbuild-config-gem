require "spec_helper"

module Quickbuild::Config

RSpec.describe Request::RunBuild do

  describe '#request_method' do

    it 'request_method is POST' do
      request = Request::RunBuild.new(server: :server, configuration_id: :id, variables: VariableList.new)
      expect(request.request_method).to eql :post
    end

  end

  describe '#body' do

    let(:expected_body) do
      <<BODY
<com.pmease.quickbuild.BuildRequest>
  <configurationId>id</configurationId>
  <respectBuildCondition>false</respectBuildCondition>
  
  
</com.pmease.quickbuild.BuildRequest>
BODY
    end

    it 'contains no variable and not promoted' do
      request = Request::RunBuild.new(server: :server, configuration_id: :id, variables: VariableList.new)
      expect(request.body).to eql expected_body
    end

  end

end

end
