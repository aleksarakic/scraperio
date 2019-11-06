require 'minitest/autorun'
require_relative '../config/environment'
require_relative '../lib/helper'

class HelperTest < Minitest::Test

  def test_temp_hash_method_returns_hash
    assert_kind_of Hash, Class.new.extend(Helper).temp_hash
  end

  def test_appropriate_message_when_the_weather_is_hot
    helper = Class.new.extend(Helper)
    temp_hash = helper.temp_hash
    assert_includes ['Boils inside', 'Fan noise', 'Hot'], temp_hash[26..].sample
  end

  def test_define_note_returns_string
    helper = Class.new.extend(Helper)
    assert_kind_of String, helper.define_note(21, 'X')
  end

  def test_define_note_translates_successfully
    helper = Class.new.extend(Helper)
    note = helper.define_note(21, 'en-de')
    translations = ['Fühlt sich schön', 'Wo sind wir?', 'Möglich Regen']
    assert_includes translations, note
  end

  def test_returns_english_note_when_can_not_translate
    helper = Class.new.extend(Helper)
    note = helper.define_note(21, 'en-xx')
    assert_includes ['Feels nice', 'Where are we?', 'Possible rain'], note
  end
end
