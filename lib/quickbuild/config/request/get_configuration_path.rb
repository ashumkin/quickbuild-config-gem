module Quickbuild::Config::Request

  class GetConfigurationPathHandler < CustomResponseHandler

    def do_handle(response)
      response.body
    end

  end

  class GetConfigurationPath < Custom

    Factory.register(self)

    attr_reader :configuration_id

    def initialize(params)
      initialize_with_server(params[:server], params[:configuration_id])
    end

    def initialize_with_server(server, configuration_id)
      @configuration_id = configuration_id
      @url = '%s/rest/configurations/%d/path' % [server, configuration_id]
    end

    def response_handler
      GetConfigurationPathHandler.new(self)
    end

    def self.type
      :get_configuration_path
    end

  end

end

