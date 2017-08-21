
module Quickbuild::Error

  class CustomError < Exception
  end

  class UnsupportedAction < CustomError
  end

  class UnsupportedRequestType < CustomError
  end

  class NoConfigurationByPath < CustomError
    def initialize(configuration_path)
      super('No configuration for path %s' % configuration_path)
    end
  end

end
