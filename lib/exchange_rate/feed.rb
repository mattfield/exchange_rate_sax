require "exchange_rate/parser"

class Feed
  def initialize(file_path, parser=Parser)
    @raw = read_file(file_path)
    @parser = parser
    @parsed = parse
  end

  attr_reader :raw, :parsed

  def read_file(file_path)
    File.open(file_path) { |f| f.read }
  end

  def parse
    doc = @parser.new @raw
    doc.parse
    doc.elements
  end
end

class ECBFeed < Feed
	def parse
		super
	end	

	def get_dates
		@dates = []

		@parsed.each do |k|
			item = k[:Cube]
			if item.is_a?(Hash) && item.key?("time")
				@dates << item["time"]
			end
		end

		@dates
	end

	def group_by_date
		time = nil
		base_obj = {}
		attr_pairs = []

		get_dates.each do |k|
			#if item.is_a?(Hash) && item.key?("time")
				#time = item["time"]
				#date_group = { time => {} }
				#exit
			#end	

			#if item.is_a?(Hash) && (item.key?("currency") || item.key?("rate"))
				#puts date_group
			#end
		end
	end
end
