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
end
