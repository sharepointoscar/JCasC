require 'csv'
require_relative 'enumerable_extensions'

module YamWow
  class Response

    attr_accessor :data, :reference_data

    def initialize(data, reference_data=nil)
      @data = data
      @reference_data = reference_data
    end

    def to_csv(options={})
      hashes = flatten_data
      columns = options[:include]

      unless columns
        keys = Set.new
        hashes.each { |h| keys += h.keys }
        columns = keys.sort
      end

      exclude_columns = options[:exclude] || []
      columns = columns.reject { |c1| exclude_columns.index { |c2| c1 =~ c2 } }

      CSV.generate do |csv|
        csv << columns
        hashes.each { |h| csv << columns.map { |k| h[k] } }
      end
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
      data.map { |h| h.flatten_with_path }
    end

  end
end