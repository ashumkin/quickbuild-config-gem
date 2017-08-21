require 'nokogiri'

module Quickbuild::Config::Request

  class ListConfigurationsHandler < CustomResponseHandler

    def do_handle(response)
      xml = Nokogiri::XML(response.body)
      result = []
      xml.xpath('//com.pmease.quickbuild.model.Configuration/id').each do |conf|
        result << conf.text
      end
      result
    end

  end

  class ListConfigurations < Custom

    Factory.register(self)

    def initialize(params)
      initialize_with_server(params[:server])
    end

    def initialize_with_server(server)
      @url = '%s/rest/configurations/?recursive=true' % [server]
    end

    def response_handler
      ListConfigurationsHandler.new(self)
    end

    def self.type
      :list_ids
    end

  end

end

