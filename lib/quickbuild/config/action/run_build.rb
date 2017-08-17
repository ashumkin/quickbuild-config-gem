
module Quickbuild::Config

  module Action

    class RunBuild

      def initialize(options, request_handler, request_factory, credentials_helper)
        @opts = options
        @request_handler, @request_factory, @credentials_helper = request_handler, request_factory, credentials_helper
      end

      def do_request(type, opts, extras = {})
        request = @request_factory.create(type, opts, extras)
        response = @request_handler.execute_request(request, @credentials_helper, opts.logger_level_is_trace?)
        request.response_handler.handle(response)
      end

      def get_configuration_id(opts)
        opts.logger.info('Getting ID for %s' % [opts.configurations.first])
        result = do_request(:get_configuration_id, opts)
        opts.logger.debug('Got %d' % result)
        result
      end

      def run_build(opts, configuration_id)
        opts.logger.info('Run build for configuration ID = %d' % [configuration_id])
        do_request(:run_build, opts, configuration_id: configuration_id, variables: opts.variables)
      end

      def run
        configuration_id = get_configuration_id(@opts)
        run_build_result = run_build(@opts, configuration_id)
        return run_build_result
      end

    end

  end
end
