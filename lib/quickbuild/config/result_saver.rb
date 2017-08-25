require 'quickbuild/helpers/string_helper'
require 'quickbuild/config/result_saver/to_directory_saver'

module Quickbuild::Config

  class ResultSaver

    attr_reader :device

    def initialize(device)
      @device = device
    end

    def save(configuration_path, exported_configuration)
      @device.puts exported_configuration.inject_to_xml(configuration_path)
    end

    def eql?(object)
      @device.eql? object.device
    end

    def self.create_by_output(output)
      if output.to_s.is_stdout?
        ResultSaverSTDOUT.new
      else
        ResultSaverToDirectory.new(output)
      end
    end

  end

  class ResultSaverSTDOUT < ResultSaver

    def initialize
      super($stdout)
    end

  end

  class ResultSaverToDirectory < ResultSaver

    attr_reader :output

    def initialize(directory)
      super(ResultSaverToDirectoryDevice.new(directory))
      @output = directory
    end

    def save(configuration_path, exported_configuration)
      @device.configuration = configuration_path
      super
    end

  end

end
