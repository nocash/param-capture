class SavedParams
  MAX_AGE_DAYS = 30

  class << self
    def cleanup!
      Dir['params/*'].each do |path|
        filename = path[/\d+$/]
        time = Time.parse(filename)
        File.unlink path if too_old(time)
      end
    end

    def too_old(time)
      old = Date.today - MAX_AGE_DAYS
      time < old.to_time
    end
  end
end
