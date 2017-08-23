module Quickbuild::Config::Request

  class CustomResponseHandler

    def initialize(owner)
      @owner = owner
    end

    def handle(response)
      if response.ok?
        do_handle(response)
      end
    end

  end

  class Custom
    attr_reader :url

    def initialize(params)
      @url = nil
    end

    def response_handler
    end

    def request_method
      :get
    end

    def self.type
      raise "Please, derive #{self.name}.type"
    end

    def self.oftype?(type)
      self.type.eql? type
    end
  end

end

