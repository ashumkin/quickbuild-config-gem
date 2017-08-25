require 'spec_helper'
require 'quickbuild/helpers/string_helper'

RSpec.describe String do

  describe '#match_all' do

    it 'matches all' do
      expect(String.asterisk.match_all?).to eql true
    end

    it 'two asterisks do NOT match all' do
      expect('**'.match_all?).to eql false
    end

    it 'empty string does NOT match all' do
      expect(''.match_all?).to eql false
    end

    it 'space does NOT match all' do
      expect(' '.match_all?).to eql false
    end

    it 'any string does NOT match all' do
      expect('any string'.match_all?).to eql false
    end

  end

  describe '#as_xml_comment' do

    it 'returns string as an XML comment' do
      expect('any string'.as_xml_comment).to eql '<!-- any string -->'
    end

  end

  describe '#inject_to_xml' do

    expected_xml = <<EXPECTED_XML
<?xml version="1.0" ?>
<!-- root/configuration/path -->

<com.pmease.quickbuild.model.Configuration>
...
</com.pmease.quickbuild.model.Configuration>
EXPECTED_XML

    source_xml = <<SOURCE_XML
<?xml version="1.0" ?>

<com.pmease.quickbuild.model.Configuration>
...
</com.pmease.quickbuild.model.Configuration>
SOURCE_XML

    it 'adds configuration path after XML header' do
      expect(source_xml.inject_to_xml('root/configuration/path')).to eql expected_xml
    end

    it 'does not add anything to empty string' do
      expect(''.inject_to_xml('root/configuration/path')).to eql ''
    end

    it 'does not add anything if string is not an XML' do
      expect('string'.inject_to_xml('root/configuration/path')).to eql 'string'
    end

  end

end
