# frozen_string_literal: true

require_relative "client/version"
require_relative "client/exceptions"
require_relative "client/environment.rb"

require "httparty"

module PagerDuty
  class Client
    SUCCESS = 200
    TOO_MANY_REQUESTS = 429

    def find_service(service_name)
      response = HTTParty.get("https://api.pagerduty.com/services?query=#{service_name}&limit=1&sort_by=name:asc",
                              headers: {
                                "Authorization" => "Token token=#{Environment.get_env_variable("TOKEN")}",
                                "Accept" => "application/vnd.pagerduty+json;version=2",
                                "Content-Type" => "application/json"
                              })
      parse_response(response)
    end

    private

    def parse_response(response)
      raise RateLimitError, "Too many requests." if response.code == TOO_MANY_REQUESTS
      raise ApiError, "Received non-success response with code #{response.code} and body #{response.body}." if response.code > SUCCESS

      services = JSON.parse(response.body)["services"]
      raise ServiceNotFound, "Service not found." if services.empty?

      services[0]
    end
  end
end
