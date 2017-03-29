module HashFlattener

  DEFAULT_DELIMITER = '.'

  class HashFlattener

    def flatten(hash, delimiter=DEFAULT_DELIMITER)
      @hash = hash.kind_of?(Hash) ? hash : hash.to_hash
      @delimiter = delimiter.to_s
      flatten_enumerable @hash
    end

    private

    def flatten_enumerable(enumerable, parent_prefix=nil)
      res = {}

      enumerable.each_with_index do |elem, i|
        if elem.is_a? Array
          k, v = elem
        else
          k, v = i, elem
        end

        k = k.to_s
        key = parent_prefix ? parent_prefix + @delimiter + k : k

        if v.is_a? Enumerable
          res.merge! flatten_enumerable(v, key)
        else
          res[key] = v
        end
      end

      res
    end

  end
end