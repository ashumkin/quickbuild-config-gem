
module Quickbuild::Config

  module Action

    class ListConfigurationIDs < Custom

      Factory.register(self)

      def self.type
        :list_ids
      end

      def list_config_ids
        @logger.info('Get configurations list')
        do_request(self.class.type, server: @opts.server)
      end

      def run(result_saver)
        list_config_ids
      end

    end

  end
end
