require "test_helper"

class CryptedValueTest < Minitest::Test
  def setup
    CryptedValue.pepper = "pepper"
    CryptedValue.stretches = 11
  end

  def test_that_it_has_a_version_number
    refute_nil ::CryptedValue::VERSION
  end

  def test_compare
    crypted_value = CryptedValue.new("ATSUSHI YOSHIDA")
    assert_match /\$2a\$11\$.+/, crypted_value.to_s
    assert crypted_value == "ATSUSHI YOSHIDA"
    assert crypted_value != "yalab"
  end

  def test_compare_from_crypted
    crypted_value = CryptedValue.new("$2a$11$QsqgvMOGbH0CcUHVzSifKevmAlycAsN5zIdaQQBIg7kkmZNOrc27y")
    assert crypted_value, "ATSUSHI YOSHIDA"
  end
end
