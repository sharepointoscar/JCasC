require_relative 'response'

module YamWow
  class TopicsResponder

    def create_response(topics)
      @topics = topics
      remove_duplicates
      sort_by_name
      Response.new @topics
    end

    def remove_duplicates
      @topics.uniq! { |t| t['id'] }
    end

    def sort_by_name
      @topics.sort! { |x, y| x['full_name'].to_s.downcase <=> y['full_name'].to_s.downcase }
    end

  end
end