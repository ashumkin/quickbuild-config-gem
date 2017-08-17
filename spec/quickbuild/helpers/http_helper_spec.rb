require 'spec_helper'
require 'quickbuild/helpers/net/http'

RSpec.describe Net::HTTPResponse do

  let(:response_ok) do
    Net::HTTPOK.new('1.1', '200', nil)
  end

  let(:response_not_ok) do
    Net::HTTPResponse.new('1.1', '000', nil)
  end

  describe '#ok?' do
    it 'should be OK' do
      expect(response_ok.ok?).to eql true
    end

    it 'should NOT be OK' do
      expect(response_not_ok.ok?).to eql false
    end
  end

end

