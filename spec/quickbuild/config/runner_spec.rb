require "spec_helper"
require 'quickbuild/config/runner'
require 'quickbuild/config/runner/options'

module Quickbuild::Config

RSpec.describe Runner do

  subject do
    cliOptions = RunnerOptions.new []
    Runner.new(cliOptions)
  end

  it 'initialized with options' do
    is_expected.not_to be nil
  end

end

end
