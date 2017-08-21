require "quickbuild/config/version"

module Quickbuild
  module Config
    class Runner

      def initialize(opts)
        @opts = opts
      end

      def run(action_factory)
        action = action_factory.create(@opts)
        action.run
      end

    end
  end
end

