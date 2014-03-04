class ParamFile
  def initialize(filepath)
    @filepath = filepath
  end

  def name
    time.strftime('%Y-%m-%d %H:%I:%S')
  end

  def permalink
    '/' + File.basename(filepath)
  end

  private

  attr_reader :filepath

  def time
    basename = File.basename(filepath)
    Time.parse(basename)
  end
end
