require 'yaml'

class ParamReader
  attr_reader :params

  def self.read(filepath)
    new(filepath).read
  end

  def initialize(filepath)
    @filepath = filepath
    @params = {}
  end

  def read
    @params = inflate(file.read)
    self
  end

  def permalink
    '/' + File.basename(filepath)
  end

  private

  attr_reader :filepath

  def file
    @file ||= File.open(filepath, 'r')
  end

  def inflate(string)
    YAML.load(string)
  end
end
