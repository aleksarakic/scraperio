require 'net/http'
require 'json' 

class Translation
	# @params: text for translation; language direction (eg. en-de)
	def initialize(text, languages)
		@text = text
		@url = "https://translate.yandex.net/api/v1.5/tr.json/translate?"
		@api_id = "key=#{SENSITIVE_DATA['translation']['api_id']}"
		@params = "&text=#{text}&lang=#{languages}"
		@full_url = URI.parse(URI.escape("#{@url}#{@api_id}#{@params}"))
	end

	def translate
		response = Net::HTTP.get_response(@full_url)
		return nil if response.code != '200'
		JSON.parse(response.body)['text'].first
	end
end