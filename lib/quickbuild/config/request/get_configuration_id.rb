require 'quickbuild/config/request/custom'
require 'quickbuild/error'

module Quickbuild::Config::Request

  class GetConfigurationIDResponseHandler < CustomResponseHandler

    def do_handle(response)
      raise Quickbuild::Error::NoConfigurationByPath.new(@owner.configuration_path) if response.body.to_s.empty?
      response.body
    end

  end

  class GetConfigurationID < Custom
    attr_reader :configuration_path

    Factory.register(self)

    def initialize(params)
      initialize_with_server(params[:server], params[:configuration])
    end

    def initialize_with_server(server, configuration_path)
      @configuration_path = configuration_path
      @url = '%s/rest/ids?configuration_path=%s' % [server, @configuration_path]
    end

    def response_handler
      GetConfigurationIDResponseHandler.new(self)
    end

    def self.type
      :get_configuration_id
    end

  end

end
