require 'csv'
require 'hash_flattener'

module HashToCsv
  class HashToCsv

    def initialize(hash_flattener)
      @hash_flattener = hash_flattener
    end

    def to_csv(hashes, options={}, &block)
      @hashes = [hashes].flatten.map { |h| @hash_flattener.flatten h }
      @include = options[:include]
      @exclude = options[:exclude]
      @sort = options[:sort] == true

      CSV.generate do |csv|
        csv << column_names
        rows.each { |row| csv << values_for_row(row, &block) }
      end
    end

    private

    def column_names
      return @column_names if @column_names
      keys = all_keys

      keys = @include.map do |include_pattern|
        keys.select { |key| column_matches_pattern? key, include_pattern }
      end.flatten if @include

      keys.reject! { |key| @exclude.index { |pattern| column_matches_pattern? key, pattern } } if @exclude
      keys.sort! if @sort
      @column_names = keys
    end

    def rows
      @hashes
    end

    def values_for_row(row, &block)
      column_names.map do |column_name|
        value = row[column_name]
        value = block.call value, column_name if block
        value
      end
    end

    def all_keys
      keys = Set.new
      @hashes.each { |h| keys += h.keys }
      keys.to_a
    end

    def column_matches_pattern?(column, pattern)
      pattern.kind_of?(Regexp) ? column =~ pattern : column == pattern.to_s
    end

  end
end