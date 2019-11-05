require_relative 'translate/translation.rb'

module Helper
	def temp_hash
		{
			-50..0 => ['Freezing', 'Time for winter clothes', 'Fire would be nice'],
			1..15 => ['Meek', "Let's go south", "I will stay home"],
			16..25 => ['Feels nice', 'Where are we?', 'Possible rain'],
			26.. => ['Boils inside', 'Fan noise', 'Hot']
		}
	end

	# @param temperature [String]; language direction [String](eg. en-de) 
	# returns [String]
	def define_note(weather, languages)
		note = temp_hash.select {|temp| temp === weather.to_i }.values.flatten.sample
		translation = Translation.new(note, languages).translate
		translation ? translation : note
	end
end