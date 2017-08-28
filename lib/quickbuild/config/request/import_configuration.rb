module Quickbuild::Config::Request

  class ImportConfigurationHandler < CustomResponseHandler

    def do_handle(response)
      response.body
    end

  end

  class ImportConfiguration < Custom

    Factory.register(self)

    def initialize(params)
      initialize_with_server(params[:server], params[:configuration_id])
    end

    def initialize_with_server(server, configuration_id)
      @configuration_id = configuration_id
      @url = '%s/rest/configurations' % [server]
      @variables = Quickbuild::Config::VariableList.new
    end

    def response_handler
      ImportConfigurationHandler.new(self)
    end

    def request_method
      :post
    end

    def self.type
      :import
    end

    def variables
      @variables.to_xml
    end

    def body
      <<BODY
<com.pmease.quickbuild.model.Configuration>
  <id>#{@configuration_id}</id>
  #{variables}
</com.pmease.quickbuild.model.Configuration>
BODY
    end

  end

end

