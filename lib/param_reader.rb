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

    def to_h
      @params
    end

    def read
      @params = inflate(file.read) if exist?
      self
    end

    def exist?
      File.exist?(filepath)
    end

    def permalink
      '/' + filename
    end

    private

    attr_reader :filename

    def file
      @file ||= File.open(filepath, 'r')
    end

    def filepath
      File.join(PARAM_PATH, filename)
    end

    def inflate(string)
      YAML.load(string)
    end
  end
end
