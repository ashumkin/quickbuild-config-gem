require 'optparse'
require 'logger'
require 'quickbuild/config/variables'
require 'quickbuild/error'
require 'quickbuild/helpers/logger_helper'

module Quickbuild
  module Config

    class RunnerOptionsError < Quickbuild::Error::CustomError
    end

    class RunnerOptionsHelp < RunnerOptionsError
    end

    class RunnerOptionsVersion < RunnerOptionsError
    end

    class RunnerOptions < OptionParser
      attr_reader :server, :configurations, :action, :variables, :logger, :output

      def initialize(argv)
        super()
        set_defaults
        init
        parse_and_validate argv.dup
      end

      def set_defaults
        @version = VERSION
        @action = :none
        @server = ENV['QB_SERVER_PATH']
        @configurations = []
        @variables = VariableList.new
        @output = nil
        @logger = Logger.new(STDERR)
        self.logger_level = Logger::WARN
      end

      def logger_level
        @logger.level
      end

      def logger_level=(value)
        @logger.level = value
      end

      def logger_level_is_debug?
        logger_level <= Logger::DEBUG
      end

      def logger_level_is_trace?
        logger_level < Logger::DEBUG
      end

      def parse_and_validate(argv)
        parse! argv
        validate argv
      end

      def validate(argv)
        argv = argv.dup
        init_variables(argv)
        @configurations = argv
      end

      def init_variables(argv)
        argv.delete_if do |arg|
          if m = /(\w+)=(.*)/.match(arg)
            @variables << Variable.new(m[1], m[2])
            true
          end
        end
      end

      def init

        separator 'Options:'
        separator ''

        on('-e', '--export', 'Export configuration(s) to XML file(s)') do |s|
          @action = :export
        end

        on('-l', '--list', 'List configuration(s)') do |s|
          @action = :list
        end

        on('-s', '--server SERVER', 'Server URL') do |s|
          @server = s
        end

        on('-o', '--output DIRECTORY', 'Output directory') do |o|
          @output = o
        end

        on('-R', '--run-build', 'Runs build') do
          @action = :run_build
        end

        on('-v', '--verbose', 'Be verbose') do |v|
          self.logger_level = self.logger_level - 1
        end

        on_tail('-V', '--version', 'Shows version') do
          raise RunnerOptionsVersion.new version
        end

        on_tail('-h', '--help', 'Shows this help') do
          raise RunnerOptionsHelp.new help
        end

      end

    end
  end
end


