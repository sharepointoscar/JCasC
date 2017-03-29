require_relative '../response'
require_relative 'topics_with_prefix_request'

module YamWow
  class TopicsRequest

    def initialize(client, options={})
      @client = client
      @detailed = options[:detailed]
    end

    def send
      @topics = []
      process_range '0', '9'
      process_range 'a', 'z'
      @topics.uniq! { |t| t['id'] }
      @topics.sort! { |x, y| x['name'].downcase <=> y['name'].downcase }
      Response.new @topics
    end

    private

    def process_range(first, last, current=nil)
      ((current.to_s + first)..(current.to_s + last)).each do |prefix|
        topics = send_topics_with_prefix_request prefix
        @topics += topics
        process_range first, last, prefix if topics.length == 50
      end
    end

    def send_topics_with_prefix_request(topic_prefix)
      response = TopicsWithPrefixRequest.new(@client, topic_prefix, detailed: @detailed).send
      response.data || []
    end

  end
end