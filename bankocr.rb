#!/usr/bin/env ruby

require_relative 'recordreader.rb'
require_relative 'parser.rb'
require_relative 'outputwriter.rb'

begin
  if ARGV.any?
    parser = Parser.new
    writer = OutputWriter.new

    RecordReader.new(ARGV[0]).each do |record|
      data = parser.parse record
      writer.write data
    end
  else
    raise "Missing file argument"
  end

rescue Exception => e  
  puts e.message
  abort "Usage: bankocr.rb inputfile"  
end
