require_relative 'recordreader.rb'
require 'minitest/autorun'

class RecordReader 
  public :validate
end

RR_VALID_RECORD = %{
    _  _  _  _  _  _     _ 
|_||_|| ||_||_   |  |  ||_ 
  | _||_||_||_|  |  |  | _|

}

RR_BAD_RECORD = %{
    _  _  _  _  _  _     _ 
|_||_|| ||_||_   |  |  ||_ 
  | _||_|
}


class RecordReaderTests < MiniTest::Unit::TestCase

  def setup
    @recordreader = RecordReader.new('./testfile')
  end

  def test_recordreader_number_records
    count = 0
    @recordreader.each { |rec| count+=1 }
    assert_equal 12, count
  end

  def test_recordreader_size_record
    @recordreader.each { |rec| assert_equal 3, rec.length }
  end

  def test_recordreader_bad_file
    assert_raises RuntimeError do
      RecordReader.new('./does_not_exist')
    end
  end

  def test_recordreader_validate_succeeds
    @recordreader.validate RR_VALID_RECORD.lines.to_a[1..4]
  end

  def test_recordreader_validate_fails
    assert_raises RuntimeError do
      @recordreader.validate RR_BAD_RECORD.lines.to_a[1..4]
    end
    assert_raises RuntimeError do
      @recordreader.validate RR_VALID_RECORD.lines.to_a[1..3]<<'INVALID LINE'
    end
  end

end