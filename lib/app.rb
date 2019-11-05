require_relative '../config/environment.rb'

# TODO: move to rake task
class Pipeline
	extend Helper

	def self.call
		vienna = ViennaAirport.new('https://www.viennaairport.com/passagiere/ankunft__abflug/abfluege', 'class', "detail-table__row  ")
		# starts the scraping process
		results = Scraper.new(vienna).start

		# exit if no results are found or request is bad
		if results.nil? || results.empty?
			puts 'No results. Exiting.'
			return nil
		end

		# establish conection to Memcachier
		client = Cache.new
		
		results.each do |res|
			place = res[:place]
			time = res[:time]

			# set cache if time or place is nil
			unless place && time
				client.set_cache(place || 'x', time || 'x')
				next
			end

			# check weather for given location
			weather = CheckWeather.start(place)
			temp = CheckWeather.kelvin_to_celsius(weather['main']['temp']) if weather

			# set cache if weather is unavailable
			unless weather
				client.set_cache(place, time)
				next
			end
			
			# define note 
			note = define_note(temp, "en-#{weather['sys']['country'].downcase}")

			# save result to the db
			s = ScrapeResult.new(temperature: temp, city: place, time: time, note: note)
			s.save
			puts "+ #{s.city} saved."
		end
	end
end

Pipeline.call 