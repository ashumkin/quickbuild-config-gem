require 'quickbuild/error'

module Quickbuild::Config::Request

  class Factory

    @@registered_requests = []

    def self.register(request)
      @@registered_requests << request
    end

    def find_by_type(type, params)
      @@registered_requests.each do |request|
        return request.new(params) if request.oftype? type
      end
      return nil
    end

    def create(type, params)
      unless request = find_by_type(type, params)
        raise Quickbuild::Error::UnsupportedRequestType.new(type)
      end
      request
    end

  end

end

require 'quickbuild/config/request'
