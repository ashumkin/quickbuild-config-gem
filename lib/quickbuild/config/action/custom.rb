module Quickbuild::Config::Action

  class Custom

    def initialize(options, factory, request_handler, request_factory, credentials_helper)
      @opts = options
      @logger = options.logger
      @factory, @request_handler, @request_factory, @credentials_helper = factory, request_handler, request_factory, credentials_helper
    end

    def do_request(type, extras)
      request = @request_factory.create(type, extras)
      response = @request_handler.execute_request(request, @credentials_helper, @opts.logger_level_is_trace?)
      request.handle_response(response)
    end

    def get_configuration_id(configuration)
      @logger.info('Getting ID for %s' % [configuration])
      result = do_request(:get_configuration_id, server: @opts.server, configuration: configuration)
      @logger.debug('Got %d' % result)
      result
    end

    def self.type
      raise "Please, derive #{self.name}.type"
    end

    def self.oftype?(type)
      self.type.eql? type
    end

    def save_result(result_saver, configuration, value)
      result_saver.save(configuration, value) if result_saver
    end

    def run(result_saver)
      raise "Please, derive #{self.name}.run"
    end

  end

end


