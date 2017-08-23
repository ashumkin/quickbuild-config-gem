require "spec_helper"

module Quickbuild::Config

RSpec.describe Request::Factory do

  describe '#create' do

    let(:run_options) do
      RunnerOptions.new ['--run-build', '--server', 'SERVER', 'root']
    end

    let(:params_from_run_options) do
      { server: run_options.server, configuration: run_options.configurations.first }
    end

    it 'creates get_configuration_id' do
      request = Request::GetConfigurationID.new(server: 'SERVER', configuration: :root)

      expect(subject.create(:get_configuration_id, params_from_run_options).url).to eql(request.url)
    end

    it 'creates run_build' do
      request = Request::RunBuild.new(server: 'SERVER', configuration_id: 'root', variables: VariableList.new)

      expect(subject.create(:run_build, params_from_run_options).url).to eql(request.url)
    end

  end

end

end
