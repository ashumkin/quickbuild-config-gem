
module Quickbuild::Config

  module Action

    class ListConfigurations < Custom

      Factory.register(self)

      def self.type
        :list
      end

      def list_config_ids(result_saver)
        list_ids_action = @factory.create(:list_ids, @opts)
        list_ids_action.run(result_saver)
      end

      def retreive_config_paths_by_ids(config_ids)
        @logger.info('Get configuration paths')
        result = []
        config_ids.each do |configuration_id|
          @logger.info('Get configuration path for %d' % configuration_id)
          result << do_request(:get_configuration_path, server: @opts.server, configuration_id: configuration_id)
        end
        result
      end

      def run(result_saver)
        listed_config_ids = list_config_ids(result_saver)
        config_with_paths = retreive_config_paths_by_ids(listed_config_ids)
        save_result(result_saver, self.class.type, config_with_paths)
        config_with_paths
      end

    end

  end
end
