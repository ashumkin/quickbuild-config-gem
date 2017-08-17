require 'quickbuild/config/request'
require 'quickbuild/error'

module Quickbuild::Config::Request

  class Factory

    def create(type, options, extras = {})
      return case type
        when :get_configuration_id
          GetConfigurationID.new(options.server, options.configurations.first)
        when :run_build
          RunBuild.new(options.server, extras[:configuration_id], extras[:variables])
        else
          raise Quickbuild::Error::UnsupportedRequestType.new(type)
        end
    end

  end

end
