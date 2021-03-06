require 'net/http'
require 'netrc'
require 'quickbuild/helpers/net/http'

module Quickbuild::Config::Request

  class Handler

    def execute_request(request, credentials_helper, turn_on_debugging = false)
      uri = URI(request.url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.set_debug_output $stderr if turn_on_debugging
      http.start do |ht|

        if request.request_method == :post
          http_request = Net::HTTP::Post.new uri.request_uri
          http_request.body = request.body
        else
          http_request = Net::HTTP::Get.new uri.request_uri
        end
        credentials = credentials_helper.get_credentials_for(uri)
        http_request.basic_auth credentials[:login], credentials[:password] if credentials

        response = ht.request http_request
        return response
      end

    end

  end

end
