require 'minitest/autorun'
require_relative '../../config/environment'
require_relative '../../lib/scrape/scraper'

class ScraperTest < Minitest::Test

  def test_it_can_be_instantiated
    assert Scraper.new('https://google.com') != nil
  end
end
