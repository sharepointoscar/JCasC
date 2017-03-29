require 'hash_flattener'
require_relative 'hash_to_csv/hash_to_csv'

module HashToCsv

  def self.to_csv(hashes, options={}, &block)
    hash_flattener = HashFlattener::HashFlattener.new
    hash_to_csv = HashToCsv.new hash_flattener
    hash_to_csv.to_csv hashes, options, &block
  end

end