class Parser

  def initialize 
    @valid_digits = [175,9,158,155,57,179,183,137,191,187]
  end

  def parse(record)
    digits = slice_digits(record).map { |digit| recognizer digit }
    checksum = calc_checksum digits

    {
      :number => digits.join, 
      :valid => (checksum == 0),
      :illegible => (checksum == nil)
    }
  end

  def slice_digits(record)
    (0..8).collect do |i| 
      record.map { |line| line[i*3..i*3+2] }
    end
  end

  def recognizer(next_digit)
    binary_digit = next_digit.join.gsub(/\S/,'1').gsub(/\s/,'0')  # maps input chars to 1's and 0's
    digit = @valid_digits.index binary_digit.to_i(2)  # turn into integer and lookup
    digit.nil? ? '?' : digit.to_s
  end

  def calc_checksum(digits) 
    checksum = digits.each_with_index.inject(0) { |sum,(d,i)| (d=='?') ? sum : sum+(9-i)*d.to_i }
    digits.include?('?') ? nil : (checksum % 11)
  end

  private :slice_digits, :recognizer, :calc_checksum

end