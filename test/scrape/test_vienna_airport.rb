require 'minitest/autorun'
require_relative '../../config/environment'
require_relative '../../lib/scrape/vienna_airport'

class ViennaAirportTest < Minitest::Test
  
  def test_it_can_be_instantiated
    dummy = ViennaAirport.new('x','x','x')
    assert dummy != nil
  end

  def test_scrape_returns_an_array
    url = 'https://www.viennaairport.com/passagiere/ankunft__abflug/abfluege'
    vienna_results = ViennaAirport.new(url, 'class', "detail-table__row  ").scrape
    assert_kind_of Array, vienna_results
  end

  def test_returns_nil_when_invalid_url
    dummy = ViennaAirport.new('x','x','x')
    assert_nil dummy.scrape
  end
end
