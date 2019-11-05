require 'net/http'
require 'json'

require_relative '../translate/translation.rb'

class CheckWeather
	@translated = false
	@base_url = "http://api.openweathermap.org/data/2.5/weather?q="
	@api_id = "&APPID=#{SENSITIVE_DATA['weather']['api_id']}"

	class << self
		# @param [String] location for checking
		# returns JSON object with data
		def start(location)
			full_url = URI.parse(URI.escape("#{@base_url}#{location}#{@api_id}"))
			response = ping_api(full_url, location)
			return nil unless response

			JSON.parse(response.body)
		end

		def ping_api(url, location)
			response = Net::HTTP.get_response(url)

			# if request is not successful, try to translate location and try again
			if response.code == '404'
				return nil if @translated
				
				translated_location = Translation.new(location, 'de-en').translate
				return nil unless translated_location

				@translated = true
				url = URI.parse(URI.escape("#{@base_url}#{translated_location}#{@api_id}"))
				return ping_api(url, translated_location)
			end
			@translated = false
			response
		end

		def kelvin_to_celsius(k)
			(k - 273.15).round(1)
		end
	end
end