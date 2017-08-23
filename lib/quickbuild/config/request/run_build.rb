require 'nokogiri'

module Quickbuild::Config::Request

  class RunBuildHandler < CustomResponseHandler

    def do_handle(response)
      xml = Nokogiri::XML(response.body)
      xml.xpath('/com.pmease.quickbuild.RequestResult/requestId').text
    end

  end

  class RunBuild < Custom

    Factory.register(self)

    def initialize(params)
      initialize_with_server(params[:server], params[:configuration_id], params[:variables])
    end

    def initialize_with_server(server, configuration_id, variables)
      @configuration_id = configuration_id
      @url = '%s/rest/build_requests' % server
      @promotion_build_id = nil
      @variables = variables
    end

    def response_handler
      RunBuildHandler.new(self)
    end

    def request_method
      :post
    end

    def self.type
      :run_build
    end

    def variables
      @variables.to_xml
    end

    def promotion
      if @promotion_build_id
        <<PROMO
<promotionSource> <!-- Identifier of the source build to promote from -->
  <buildId>#{@promotion_build_id}</buildId>
</promotionSource>
PROMO
      end
    end

    def body
      <<BODY
<com.pmease.quickbuild.BuildRequest>
  <configurationId>#{@configuration_id}</configurationId>
  <respectBuildCondition>false</respectBuildCondition>
  #{variables}
  #{promotion}
</com.pmease.quickbuild.BuildRequest>
BODY
    end

  end

end

