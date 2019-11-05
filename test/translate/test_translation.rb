require 'minitest/autorun'
require_relative '../../config/environment'
require_relative '../../lib/translate/translation'

class TranslationTest < Minitest::Test

  def test_it_can_be_instantiated
    assert Translation.new('x', 'x') != nil
  end

  def test_returns_nil_if_bad_request
    t = Translation.new('Bad Request', 'foo-bar')
    assert t.translate == nil
  end

  def test_translates_succesfuly
    t = Translation.new('Feels nice', 'en-de')
    assert t.translate == 'Fühlt sich schön'
  end
end
