require_relative 'param_accessor'
require 'yaml'

class Params
  class ParamReader < ParamAccessor
    file_access_mode 'r'

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

    def to_url
      '/' + filename
    end

    def read
      @params = inflate(file.read) if exist?
      self
    end

    def exist?
      File.exist?(filepath)
    end

    private

    def inflate(string)
      YAML.load(string)
    end
  end
end
