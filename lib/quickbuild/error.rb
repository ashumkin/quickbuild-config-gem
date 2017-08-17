
module Quickbuild::Error

  class UnsupportedAction < Exception
  end

  class UnsupportedRequestType < Exception
  end

  class NoConfigurationByPath < Exception
    def initialize(configuration_path)
      super('No configuration for path %s' % configuration_path)
    end
  end

end
