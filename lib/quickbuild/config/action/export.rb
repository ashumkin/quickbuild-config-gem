require 'quickbuild/helpers/string_helper'

module Quickbuild::Config

  module Action

    class ExportConfiguration < Custom

      Factory.register(self)

      def self.type
        :export
      end

      def export_config(configuration_id)
        @logger.info('Get configuration description (ID = %d)' % [configuration_id])
        do_request(self.class.type, server: @opts.server, configuration_id: configuration_id)
      end

      def get_configuration_list
        get_configuration_list_action = @factory.create(:list, @opts)
        get_configuration_list_action.run(nil)
      end

      def expand_configurations(configurations)
        configurations.map do |configuration|
          if configuration.match_all?
            get_configuration_list
          else
            configuration
          end
        end.flatten
      end

      def run(result_saver)
        configurations = expand_configurations(@opts.configurations)
        configurations.each do |configuration|
          configuration_id = get_configuration_id(configuration)
          exported_config = export_config(configuration_id)
          save_result(result_saver, configuration, exported_config)
        end
      end

    end

  end
end
