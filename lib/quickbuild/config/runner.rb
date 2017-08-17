require "quickbuild/config/version"

module Quickbuild
  module Config
    class Runner

      def initialize(opts)
        @opts = opts
      end

      def run(action_factory)
        begin
          action = action_factory.create(@opts)
          action.run
        rescue Exception => e
          warn e.message
          warn e.backtrace if @opts.logger_level_is_debug?
          exit 1
        end
      end

    end
  end
end

