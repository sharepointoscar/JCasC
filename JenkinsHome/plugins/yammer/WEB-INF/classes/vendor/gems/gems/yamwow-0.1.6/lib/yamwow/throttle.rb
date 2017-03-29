module YamWow
  class Throttle

    def initialize(max_requests, duration_in_seconds)
      @request_log = []
      @max_requests = max_requests
      @duration_in_seconds = duration_in_seconds
    end

    def when_ready
      sleep_if_limit_reached
      @request_log << Time.now
      yield
    end

    private

    def sleep_if_limit_reached
      seconds_to_sleep = calculate_seconds_to_sleep
      return unless seconds_to_sleep > 0
      puts "Rate limit reached. Sleeping for #{seconds_to_sleep} seconds..."
      sleep seconds_to_sleep
    end

    def calculate_seconds_to_sleep
      log_index = @request_log.length - @max_requests
      return 0 if log_index < 0

      oldest_applicable = @request_log[log_index]
      return 0 unless oldest_applicable

      age = Time.now - oldest_applicable
      (@duration_in_seconds - age + 0.5).round 2
    end

  end
end