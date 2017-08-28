require 'quickbuild/config/result_printer'
require 'quickbuild/config/result_saver/to_directory_saver'

module Quickbuild::Config

  class ResultSaver

    attr_reader :device

    def initialize(device)
      @device = device
    end

    def save(configuration_path, configuration_content)
      result_printer = create_param_printer
      @device.puts result_printer.print(configuration_path, configuration_content)
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

    def create_param_printer
      ResultPrinter.new
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

    def save(configuration_path, configuration_content)
      @device.configuration = configuration_path
      super
    end

  end

end
