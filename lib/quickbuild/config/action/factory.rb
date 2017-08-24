require 'quickbuild/error'

module Quickbuild::Config::Action

  class Factory

    @@registered_actions = []

    def self.register(action)
      @@registered_actions << action
    end

    def initialize(request_handler, request_factory, credentials_helper)
      @request_handler, @request_factory, @credentials_helper = request_handler, request_factory, credentials_helper
    end

    def find_by_type(action, options)
      @@registered_actions.each do |a|
        return a.new(options, @request_handler, @request_factory, @credentials_helper) if a.oftype? action
      end
      return nil
    end

    def create(options)
      action = options.action
      unless action = find_by_type(action, options)
        raise Quickbuild::Error::UnsupportedAction.new(action)
      end
      action
    end

  end

end

require 'quickbuild/config/action'
