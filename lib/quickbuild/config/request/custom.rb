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

    def initialize
      @url = nil
    end

    def response_handler
    end

    def request_method
      :get
    end

  end

end

