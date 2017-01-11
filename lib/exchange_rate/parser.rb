require 'ox'

class Parser < ::Ox::Sax
	def initialize file_path
		@file_path = file_path
		@elements = []
	end

	attr_reader :elements

	def parse
		Ox.sax_parse self, @file_path
	end

	def start_element(name)
		@element_name = name
		@elements.push({ name => {} })
	end

	def end_element(name)
		name = name.to_s.strip

		if @elements.last[name]
			@element = @elements.pop

			@element.delete name

			if @element.keys.count == 1 and @element[:text]
				inject_into_element name, @element[:text]
			else
				inject_into_element name, @element
			end
		end
	end

	def inject_into_element name, value
		return unless @elements.last

		if @elements.last[name]
			@elements.last[name] = [@elements.last[name]] unless @elements.last[name].is_a? Array
			@elements.last[name].push value
		else
			@elements.last[name] = value
		end
	end

	def attr(name, value)
		return unless @elements.last

		name = name.to_s.strip
		value = value.to_s.strip

		@elements.last[@element_name] ||= {}
		@elements.last[@element_name][name] = value
	end

	def text(value)
		return unless @elements.last
		@elements.last[:text] = value.to_s.strip
	end
end
