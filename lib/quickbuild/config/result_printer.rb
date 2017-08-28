require 'quickbuild/helpers/string_helper'
require 'quickbuild/error'

module Quickbuild
module Config

  class UnsupportedResultPrinterArgument < Quickbuild::Error::CustomError

  end

  class ResultPrinter

    def print(configuration_path, configuration_content)
      if configuration_content.kind_of? String
        configuration_content.inject_to_xml(configuration_path)
      elsif configuration_content.kind_of? Array
        configuration_content.join("\n")
      else
        raise UnsupportedResultPrinterArgument.new configuration_content.class.name
      end
    end

  end

end

end
