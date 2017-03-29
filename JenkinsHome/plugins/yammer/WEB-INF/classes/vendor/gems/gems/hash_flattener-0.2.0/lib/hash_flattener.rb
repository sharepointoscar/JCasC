require_relative 'hash_flattener/hash_flattener'

module HashFlattener

  def self.flatten(hash, delimiter=DEFAULT_DELIMITER)
    HashFlattener.new.flatten hash, delimiter
  end

end