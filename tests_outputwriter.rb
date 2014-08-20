require_relative 'outputwriter.rb'
require 'minitest/autorun'

class OutputWriter
  public :print_number, :print_status
end

class OutputWriterTests < MiniTest::Unit::TestCase

  def setup
    @writer = OutputWriter.new
  end

  def test_outputwriter_write
    assert_output("123456789 \n") do
      @writer.write({ :number => '123456789', :valid => true })
    end
  end

  def test_outputwriter_write_err
    assert_output("123456789 ERR\n") do
      @writer.write({ :number => '123456789', :valid => false })
    end
  end

  def test_outputwriter_write_ill
    assert_output("?23456789 ILL\n") do
      @writer.write({ :number => '?23456789', :illegible => true })
    end
  end

  def test_outputwriter_print_number
      assert_equal '123456789', @writer.print_number({ :number => '123456789' })
  end

  def test_outputwriter_print_status_ill
      assert_equal 'ILL', @writer.print_status({ :illegible => true })
  end

  def test_outputwriter_print_status_err
      assert_equal 'ERR', @writer.print_status({ :illegible => false, :valid => false })
  end

end