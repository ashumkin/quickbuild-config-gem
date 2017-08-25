require 'quickbuild/config/result_saver'

module Quickbuild::Config

RSpec.describe ResultSaver do

  let(:mock_output) do
    output = double('mock_output')
    allow(output).to receive(:puts)
    output
  end

  subject do
    ResultSaver.new(mock_output)
  end

  it 'saves configuration and content' do
    expect(subject.save('configuration/path', 'configuration content')).to eql nil
  end

end

end
