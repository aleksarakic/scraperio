require 'net/http'
class ViennaAirport

	def initialize(url, html_tag, html_value)
		@url = url
		@html_tag = html_tag
		@html_value = html_value
	end

	# TODO extract to a new class
	# returns set of hashes
	def scrape
		# return nil if invalid url format
		return nil unless @url =~ URI::regexp

		options = Selenium::WebDriver::Firefox::Options.new(args: ['-headless'])
		driver = Selenium::WebDriver.for(:firefox, options: options)
		driver.get(@url)
		driver.switch_to.default_content
		content = driver.find_elements(element_hash(@html_tag, @html_value))
		if content.empty?
			driver.quit
			return nil 
		end
		hashes = create_array_of_hashes(content)
		driver.quit
		# first two hashes are table data
		hashes[2..-1]
	end

	private

	# returns array
	def create_array_of_hashes(content)
		content.map do |el|
		  el.text.split("\n")
		end.map do |x| 
			{'place': x[1], 'time': x[0]}
		end
	end

	def element_hash(html_tag, html_value)
		{html_tag.to_sym => html_value}
	end
end