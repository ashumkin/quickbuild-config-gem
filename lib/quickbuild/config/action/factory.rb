require 'quickbuild/error'
require 'quickbuild/config/action'

module Quickbuild::Config::Action

  class Factory

    def initialize(request_handler, request_factory, credentials_helper)
      @request_handler, @request_factory, @credentials_helper = request_handler, request_factory, credentials_helper
    end

    def create(options)
      return case options.action
        when :run_build
          RunBuild.new(options, @request_handler, @request_factory, @credentials_helper)
        else
          raise Quickbuild::Error::UnsupportedAction.new(options.action)
      end
    end

  end

end

