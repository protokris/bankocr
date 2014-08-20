require_relative 'parser.rb'
require 'minitest/autorun'

class Parser
  public :slice_digits, :recognizer, :calc_checksum
end

VALID_DIGIT = %{
   
|_|
  |
}

ILL_DIGIT = %{
   
 _|
  |
}

VALID_RECORD = %{
    _  _  _  _  _  _     _ 
|_||_|| ||_||_   |  |  ||_ 
  | _||_||_||_|  |  |  | _|

}

class ParserTests < MiniTest::Unit::TestCase

  def setup
    @parser = Parser.new
  end

  def test_parse_record
    data = @parser.parse(VALID_RECORD.lines.to_a[1..3])
    assert_equal '490867715', data[:number]
    assert data[:valid]
    refute data[:illegible]
  end

  def test_parser_slice_digits
    digits = @parser.slice_digits(VALID_RECORD.lines.to_a[1..3])
    assert_equal 9, digits.length
  end

  def test_parser_slice_digits_check_first_digit
    digits = @parser.slice_digits(VALID_RECORD.lines.to_a[1..3])
    assert_equal ["   ", "|_|", "  |"], digits[0]
  end

  def test_parser_slice_digits_check_last_digit
    digits = @parser.slice_digits(VALID_RECORD.lines.to_a[1..3])
    assert_equal [" _ ", "|_ ", " _|"], digits[8]
  end

  #TODO I should really make a test for every number 0..9
  def test_parser_recognizer_success
    assert_equal '4', @parser.recognizer(VALID_DIGIT.lines.to_a[1..3].map{|l| l.chomp})
  end

  def test_parser_recognizer_fail
    assert_equal '?', @parser.recognizer(ILL_DIGIT.lines.to_a[1..3].map{|l| l.chomp})
  end

  def test_parser_calc_checksum_valid
    assert_equal 0, @parser.calc_checksum(['7','1','1','1','1','1','1','1','1'])
  end

  def test_parser_calc_checksum_invalid
    refute 0 == @parser.calc_checksum(['7','1','1','1','1','1','1','1','2'])
  end

  def test_parser_calc_checksum_illegible
    assert_nil @parser.calc_checksum(['7','1','1','1','1','1','1','1','?'])
  end

end