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

  describe '#save' do

    it 'saves configuration and content' do
      expect(subject.save('configuration/path', 'configuration content')).to eql nil
    end

  end

  describe '#create_by_output' do

    it 'creates STDOUT saver for "-"' do
      expect(ResultSaver.create_by_output('-')).to eql ResultSaverSTDOUT.new
    end

    it 'creates STDOUT saver for nil' do
      expect(ResultSaver.create_by_output(nil)).to eql ResultSaverSTDOUT.new
    end

    it 'creates saver for directory' do
      expect(ResultSaver.create_by_output('directory')).to eql ResultSaverToDirectory.new('directory')
    end

  end

end

RSpec.describe ResultSaverToDirectory do

  describe '#save' do

    let(:test_config) { 'test/config' }

    let(:tmp_dir) do
      File.expand_path('../../../tmp/', __FILE__)
    end

    let(:tmp_test_config) do
      File.join(tmp_dir, test_config)
    end

    let(:tmp_test_config_xml) do
      tmp_test_config + '.xml'
    end

    def read_file_content(file)
      content = ''
      File.open(file, 'r') do |f|
        content = f.readlines
      end
      content
    end

    subject do
      ResultSaverToDirectory.new(tmp_dir)
    end

    before do
      File.unlink(tmp_test_config) if File.exist?(tmp_test_config)
    end

    it 'saves to a directory' do
      subject.save(test_config, 'test config content')

      expect(read_file_content(tmp_test_config_xml)).to eql ['test config content']
    end

    it 'saves to a directory multiline text' do
      subject.save(test_config, "first line\nsecond line")

      expect(read_file_content(tmp_test_config_xml)).to eql ["first line\n", "second line"]
    end

  end
end

end
