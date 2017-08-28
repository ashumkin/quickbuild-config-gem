require "spec_helper"
require 'quickbuild/config/result_printer'

module Quickbuild::Config

RSpec.describe ResultPrinter do

  it 'prints string' do
    expect(subject.print('config/path', 'config XML')).to eql 'config XML'
  end

  it 'prints XML' do
    expect(subject.print('config/path', <<XML
<?xml ?>
config XML
XML
)).to eql "<?xml ?>\n<!-- config/path -->\nconfig XML\n"
  end

  it 'prints array' do
    expect(subject.print(:list, ['root', 'root/config-1'])).to eql "root\nroot/config-1"
  end

  it 'does not know how to print Hash' do
    expect do
      subject.print(:list, {root: 'root', root_config:'root/config-1' })
    end.to raise_error UnsupportedResultPrinterArgument
  end

end

end
