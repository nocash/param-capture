class Params
  class ParamAccessor
    private

    class << self; attr_reader :filemode; end

    def self.file_access_mode(mode)
      @filemode = mode
    end

    attr_reader :filename

    def file
      @file ||= File.open(filepath, filemode)
    end

    def filepath
      File.join(PARAM_DIR, filename)
    end

    def filemode
      self.class.filemode
    end
  end
end
