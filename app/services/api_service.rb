# app/services/api_service.rb
require 'net/http'
require 'json'

class ApiService
  API_URL = 'https://randomuser.me/api/'.freeze

  def call(records)
    uri = URI("#{API_URL}?results=#{records}")
    begin
      response = Net::HTTP.get(uri)
    rescue Exception => e
      # Capture with Sentry
    end

    parse_response(response)
  end

  private

  def parse_response(response)
    JSON.parse(response)
  rescue JSON::ParserError => e
    Rails.logger.error("Error parsing API response: #{e.message}")
  end
end
