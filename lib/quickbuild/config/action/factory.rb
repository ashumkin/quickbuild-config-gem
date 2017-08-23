require 'quickbuild/error'
require 'quickbuild/config/action'

module Quickbuild::Config::Action

  class Factory

    def initialize(request_handler, request_factory, credentials_helper)
      @request_handler, @request_factory, @credentials_helper = request_handler, request_factory, credentials_helper
    end

    def create(options)
      action = options.action
      unless action = find_by_type(action, options)
        raise Quickbuild::Error::UnsupportedAction.new(action)
      end
      action
    end

    def find_by_type(action, options)
      return case action
        when :run_build
          RunBuild.new(options, @request_handler, @request_factory, @credentials_helper)
      end
    end

  end

end

