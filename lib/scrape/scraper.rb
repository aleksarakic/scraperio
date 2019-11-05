require_relative 'vienna_airport'

class Scraper

	def initialize(site)
		@site = site
	end

	def start
		@site.scrape
	end
end