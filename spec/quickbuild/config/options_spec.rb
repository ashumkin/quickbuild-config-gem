require "spec_helper"

module Quickbuild::Config

RSpec.describe RunnerOptions do

  context 'SERVER option' do

    it 'applies option server' do
      expect(RunnerOptions.new ['--server', 'SOMESERVER']).not_to be nil
    end

    it 'applies option server and configurations' do
      options = RunnerOptions.new ['--server', 'SOMESERVER', 'config-1', 'config-2']
      expect(options).not_to be nil
      expect(options.server).to eql('SOMESERVER')
      expect(options.configurations).to eql(['config-1', 'config-2'])
    end

  end

  context 'RUN build action' do

    it 'applies option --run-build' do
      expect(RunnerOptions.new ['--run-build']).not_to be nil
    end

  end

  context 'Export config action' do

    it 'applies option --export' do
      expect(RunnerOptions.new ['--export']).not_to be nil
    end

  end

  context 'LIST configs action' do

    it 'applies option --list' do
      expect(RunnerOptions.new ['--list']).not_to be nil
    end

  end

  context 'CONFIGURATIONS' do

    it 'enumerates configurations' do
      expect(RunnerOptions.new(['--run-build', 'some-configuration', 'foo=bar', 'configuration-2']).configurations).to contain_exactly('some-configuration', 'configuration-2')
    end

    it 'initializes variables' do
      expect(RunnerOptions.new(['some-configuration', 'configuration-2', 'var=value', 'foo=bar', 'config-3']).variables).to eql([Variable.new('var', 'value'), Variable.new('foo', 'bar')])
    end

  end

  context 'LOGGER' do

    it 'log level is WARN' do
      expect(RunnerOptions.new([]).logger.level).to eql Logger::WARN
    end

    it 'sets log level to INFO' do
      expect(RunnerOptions.new(['some-configuration', '-v']).logger.level).to eql Logger::INFO
    end

    it 'sets log level to DEBUG' do
      runner_options = RunnerOptions.new(['some-configuration', '-vv'])
      expect(runner_options.logger.level).to eql Logger::DEBUG
      expect(runner_options.logger_level_is_debug?).to eql true
    end

    it 'sets log level to TRACE' do
      runner_options = RunnerOptions.new(['some-configuration', '-vvv'])
      expect(runner_options.logger.level).to eql Logger::TRACE
      expect(runner_options.logger_level_is_trace?).to eql true
    end

  end

end

end
