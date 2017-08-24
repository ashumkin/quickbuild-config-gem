require "quickbuild/config/version"

module Quickbuild
  module Config
    class Runner

      def initialize(opts)
        @opts = opts
      end

      def run(action_factory, result_saver)
        action = action_factory.create(@opts)
        action.run(result_saver)
      end

    end
  end
end

