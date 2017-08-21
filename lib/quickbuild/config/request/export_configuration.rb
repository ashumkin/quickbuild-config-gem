module Quickbuild::Config::Request

  class ExportConfigurationHandler < CustomResponseHandler

    def do_handle(response)
      response.body
    end

  end

  class ExportConfiguration < Custom

    Factory.register(self)

    def initialize(params)
      initialize_with_server(params[:server], params[:configuration_id])
    end

    def initialize_with_server(server, configuration_id)
      @configuration_id = configuration_id
      @url = '%s/rest/configurations/%s' % [server, @configuration_id]
    end

    def response_handler
      ExportConfigurationHandler.new(self)
    end

    def self.type
      :export
    end

  end

end

