require 'minitest/autorun'
require_relative '../../config/environment'
require_relative '../../lib/weather/check_weather'

class CheckWeatherTest < Minitest::Test
  def test_start_returns_nil_when_bad_params
   	response = CheckWeather.start('XXX')
  	assert CheckWeather.start('XXX') == nil
  end

  def test_start_returns_json
  	response = CheckWeather.start('Ljubljana')
  	assert_kind_of Hash, response
  end

  def test_temperature_conversion
  	assert CheckWeather.kelvin_to_celsius(300) == 26.9
  end
end
