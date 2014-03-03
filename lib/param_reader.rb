require 'yaml'

class ParamReader
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

  def filepath
    "params/#{filename}"
  end

  private

  attr_reader :filename

  def file
    @file ||= File.open(filepath, 'r')
  end

  def inflate(string)
    YAML.load(string)
  end
end
