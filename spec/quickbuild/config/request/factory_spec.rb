require "spec_helper"

module Quickbuild::Config

RSpec.describe Request::Factory do

  describe '#create' do

    it 'creates get_configuration_id' do
      options = RunnerOptions.new ['--run-build', '--server', 'SERVER', 'root']
      request = Request::GetConfigurationID.new('SERVER', 'root')

      expect(subject.create(:get_configuration_id, options).url).to eql(request.url)
    end

    it 'creates run_build' do
      options = RunnerOptions.new ['--run-build', '--server', 'SERVER', 'root']
      request = Request::RunBuild.new('SERVER', 'root', VariableList.new)

      expect(subject.create(:run_build, options).url).to eql(request.url)
    end

  end

end

end
