require 'fileutils'

module Quickbuild
module Config

  class ResultSaverToDirectoryDevice

    attr_reader :directory

    def initialize(directory)
      @directory = File.expand_path(directory)
      @configuration = nil
    end

    def configuration_directory
      File.dirname(full_filename)
    end

    def ext
      '.xml'
    end

    def create_path
      FileUtils.mkdir_p(configuration_directory)
    end

    def full_filename
      File.join(directory, @configuration) + ext
    end

    def create_file(value)
      File.open(full_filename, 'w+') do |f|
        f.write(value)
      end
    end

    def puts(value)
      create_path
      create_file(value)
    end

    def configuration=(value)
      @configuration = value
    end

    def eql?(object)
      directory.eql? object.directory
    end
  end

end
end
