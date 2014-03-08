require 'yaml'

class Params
  class ParamReader
    PARAM_PATH = 'params'

    attr_reader :params

    def self.read(filename)
      new(filename).read
    end

    def initialize(filename)
      @filename = filename
      @params = {}
    end

    def read
      @params = inflate(file.read)
      self
    end

    def permalink
      '/' + filename
    end

    private

    attr_reader :filename

    def file
      filepath = path_to(filename)
      @file ||= File.open(filepath, 'r')
    end

    def path_to(filename)
      File.join(PARAM_PATH, filename)
    end

    def inflate(string)
      YAML.load(string)
    end
  end
end
