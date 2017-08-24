require "spec_helper"

module Quickbuild::Config

RSpec.describe Variable do

  subject do
    Variable.new(:foo, :bar)
  end

  describe '#to_xml' do
    it 'returns an entry' do
      expect(subject.to_xml).to eql '<entry><string>foo</string><string>bar</string></entry>'
    end
  end

end

RSpec.describe VariableList do

  describe '#to_xml' do

    it 'is empty' do
      expect(subject.to_xml).to eql ''
    end

    it 'contains 2 variables' do
      subject << Variable.new(:var, :value)
      subject << Variable.new(:foo, :bar)
      expect(subject.to_xml).to eql <<VARS
<variables>
  <entry><string>var</string><string>value</string></entry>
  <entry><string>foo</string><string>bar</string></entry>
</variables>
VARS
    end

  end
end

end
