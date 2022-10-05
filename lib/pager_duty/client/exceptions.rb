# frozen_string_literal: true

module PagerDuty
  class Client
    class ApiError < RuntimeError; end
    class RateLimitError < RuntimeError; end
    class ServiceNotFound < StandardError; end
  end
end
