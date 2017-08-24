module Quickbuild::Config

  class ResultSaver

    attr_reader :device

    def initialize(device)
      @device = device
    end

    def save(configuration_path, exported_configuration)
      @device.puts exported_configuration
    end

    def eql?(object)
      @device == object.device
    end

  end

end
