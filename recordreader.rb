class RecordReader 

  def initialize(inputfile)
    if File.exist? inputfile
      # Read into memory for now - streaming would be better but this works for 500 records
      @lines = File.readlines inputfile
      raise "Lines in file not divisible by 4" unless @lines.size % 4 == 0
    else
      raise "File not found: " + inputfile
    end
  end

  def each
      # Slice into four line records, validate, and pass off to our parser
      @lines.each_slice(4) do |slice| 
        validate slice
        yield slice[0..2]
      end
  end

  def validate(four_line_record)
    four_line_record[0..2].each_with_index do |line, i|
      raise "Bad line length: " + i.to_s unless line.chomp.length == 27
    end
    raise "Last line must be blank" unless four_line_record[3].chomp.empty?
  end

  private :validate

end