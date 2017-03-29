require 'hash_flattener'
require 'hash_to_csv'

module YamWow
  class Response

    attr_accessor :data, :reference_data

    def initialize(data, reference_data=nil)
      @data = data
      @reference_data = reference_data
    end

    def to_csv(options={})
      HashToCsv.to_csv @data, options
    end

    def parse_template(template)
      keys = template.scan(/(\{(.+?)\})/m)
      results = flatten_data.map do |h|
        t = "#{template}"
        keys.each { |k| t.gsub! k[0], h[k[1]].to_s.gsub("\n", ' ') }
        t
      end
      results.join
    end

    private

    def flatten_data
      data = @data.kind_of?(Array) ? @data : [@data]
      data.map { |h| HashFlattener.flatten h }
    end

  end
end