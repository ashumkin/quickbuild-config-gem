require 'quickbuild/config/action/custom'

module Quickbuild::Config

  module Action

    class RunBuild < Custom

      Factory.register(self)

      def self.type
        :run_build
      end

      def run_build(opts, configuration_id)
        opts.logger.info('Run build for configuration ID = %d' % [configuration_id])
        do_request(self.class.type, server: opts.server, configuration_id: configuration_id, variables: opts.variables)
      end

      def run(result_saver)
        configuration = @opts.configurations.first
        configuration_id = get_configuration_id(configuration)
        run_build_result = run_build(@opts, configuration_id)
        save_result(result_saver, configuration, run_build_result)
        return run_build_result
      end

    end

  end
end
